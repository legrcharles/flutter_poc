part of 'movie_list_bloc.dart';

enum FormStatus { initial, loading, success, failure }

class MovieListState extends Equatable {
  final String query;
  final bool isQueryValid;
  final List<Movie> movies;
  final String error;
  final FormStatus status;

  const MovieListState({
    this.query = '',
    this.isQueryValid = true,
    this.movies = const <Movie>[],
    this.error = '',
    this.status = FormStatus.initial,
  });

  MovieListState copyWith({ String? query, bool? isQueryValid, List<Movie>? movies, String? error, FormStatus? status}) =>
      MovieListState(
        query: query ?? this.query,
        isQueryValid: isQueryValid ?? this.isQueryValid,
        movies: movies ?? this.movies,
        error: error ?? this.error,
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [query, isQueryValid, movies, error, status];
}