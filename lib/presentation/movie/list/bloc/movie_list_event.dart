part of 'movie_list_bloc.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

class QueryChanged extends MovieListEvent {
  const QueryChanged({required this.query});

  final String query;

  @override
  List<Object> get props => [query];
}

class ClearQuery extends MovieListEvent {}

class FormSubmitted extends MovieListEvent {}
