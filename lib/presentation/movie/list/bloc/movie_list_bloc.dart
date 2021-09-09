import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/movie_datamanager.dart';
import 'package:flutter_architecture/data/models/movie.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {

  final DataManager _dataManager;

  MovieListBloc(this._dataManager) : super(const MovieListState());

  @override
  void onTransition(Transition<MovieListEvent, MovieListState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<MovieListState> mapEventToState(MovieListEvent event) async* {
    if (event is QueryChanged) {
      final query = event.query;
      yield state.copyWith(query: query, status: FormStatus.initial);

    } else if (event is ClearQuery) {
      yield MovieListState();

    } else if (event is QueryUnfocused) {
      yield state.copyWith(isQueryValid: isQueryValid);

    } else if (event is FormSubmitted) {
      yield state.copyWith(isQueryValid: isQueryValid);

      if (isFormValid) {
        yield state.copyWith(status: FormStatus.loading);

        try {
          final results = await _dataManager.getMovies(query: state.query);
          final movies = results.toList();
          yield state.copyWith(movies: movies, status: FormStatus.success);
        } catch (error) {
          yield state.copyWith(
              error: "Aucun résultat pour la recherche ${state.query}",
              movies: <Movie>[],
              status: FormStatus.failure);
        }
      }
    }
  }

  bool get isFormValid => isQueryValid;

  bool get isQueryValid => state.query.trim().length > 4;

}