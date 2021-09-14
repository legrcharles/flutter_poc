import 'dart:async';
import 'dart:developer' as dev;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/core/data_wrapper.dart';
import 'package:flutter_architecture/core/form_input.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/movie_datamanager.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {

  final DataManager _dataManager;

  MovieListBloc(this._dataManager) : super(const MovieListState());

  @override
  void onTransition(Transition<MovieListEvent, MovieListState> transition) {
    dev.log("SignInBloc Transition :\ncurrentState : ${transition.currentState.toString()} \n"
        "event : ${transition.event.toString()} \n"
        "nextState : ${transition.nextState.toString()}");
    super.onTransition(transition);
  }

  @override
  Stream<MovieListState> mapEventToState(MovieListEvent event) async* {
    if (event is QueryChanged) {
      yield state.copyWith(
          queryInput: state.queryInput.copyWith(value: event.query, state: null),
          dataState: (state.dataState is DataStateLoaded) ? state.dataState : null);

    } else if (event is ClearQuery) {
      yield const MovieListState();

    } else if (event is FormSubmitted) {
      yield state.copyWith(
          queryInput: state.queryInput.copyWith(state: queyState),
          dataState: null);

      if (queyState == InputValid()) {
        yield state.copyWith(dataState: DataStateLoading());

        try {
          final results = await _dataManager.getMovies(query: state.queryInput.value);
          final movies = results.toList();
          if (movies.isEmpty) {
            yield state.copyWith(dataState: DataStateEmpty());
          } else {
            yield state.copyWith(dataState: DataStateLoaded(data: movies));
          }
        } catch (error) {
          yield state.copyWith(dataState: DataStateError(error: "Aucun résultat pour la recherche ${state.queryInput.value}"));
        }
      }
    }
  }

  InputStateWrapper get queyState {
    if (state.queryInput.value.trim().length < 4) {
      return const InputInvalid(error: "Le nom du film doit contenir au moins 4 caractères");
    }
    return InputValid();
  }
}