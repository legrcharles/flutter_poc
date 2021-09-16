part of 'movie_list_bloc.dart';

class MovieListState extends Equatable {
  final FormInput queryInput;
  final DataState? dataState;

  const MovieListState({this.queryInput = const FormInput(), this.dataState});

  MovieListState copyWith(
          {FormInput? queryInput, required DataState? dataState}) =>
      MovieListState(
          queryInput: queryInput ?? this.queryInput, dataState: dataState);

  @override
  List<Object?> get props => [queryInput, dataState];
}
