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

  BehaviorSubject<DataWrapper<List<Movie>>> _moviesSubject = BehaviorSubject.seeded(DataWrapper.initial());
  Stream<DataWrapper<List<Movie>>> get moviesStream => _moviesSubject.stream;

  // Init

  MovieListViewModel(this._dataManager);

  // Dispose

  void dispose() {
    _moviesSubject.close();
  }

  // Events

  void loadMovies(String keyword) async {
    _moviesSubject.sink.add(DataWrapper.loading());
    try {
      final results = await _dataManager.getMovies(query: keyword);
      final movies = results.toList();

      _moviesSubject.sink.add(movies.isEmpty ? DataWrapper.empty() : DataWrapper.data(movies));
    } catch(error) {
      _moviesSubject.sink.add(DataWrapper.error(error));
    }
  }
}