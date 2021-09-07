import 'dart:async';

import 'package:flutter_architecture/core/data_wrapper.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/movie_datamanager.dart';
import 'package:flutter_architecture/data/models/movie.dart';
import 'package:rxdart/rxdart.dart';


class MovieListViewModel  {

  // Dependencies

  final DataManager _dataManager;

  // Subjects

  BehaviorSubject<DataWrapper<List<Movie>>?> _moviesSubject;
  Stream<DataWrapper<List<Movie>>?> get moviesStream => _moviesSubject.stream;

  final BehaviorSubject<String> _searchSubject;
  Stream<String> get searchStream => _searchSubject.stream;

  // Init

  MovieListViewModel(this._dataManager)
      : _moviesSubject = BehaviorSubject.seeded(null),
        _searchSubject = BehaviorSubject.seeded("");

  // Dispose

  void dispose() {
    _moviesSubject.close();
    _searchSubject.close();
  }

  // Events

  void setSearch(String query) {
    _searchSubject.sink.add(query);
  }

  void loadMovies() async {
    _moviesSubject.sink.add(DataWrapper.loading());
    try {
      final results = await _dataManager.getMovies(query: _searchSubject.value);
      final movies = results.toList();

      _moviesSubject.sink.add(movies.isEmpty ? DataWrapper.empty() : DataWrapper.data(movies));
      _searchSubject.sink.add("");
    } catch(error) {
      _moviesSubject.sink.add(DataWrapper.error(error));
      _searchSubject.sink.add("");
    }
  }
}