import 'dart:async';

import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/movie_datamanager.dart';
import 'package:flutter_architecture/data/models/movie.dart';

class MovieListViewModel  {
  final DataManager _dataManager;
  final StreamController<List<Movie>> _moviesStreamController = StreamController();

  MovieListViewModel(this._dataManager);

  void dispose() {
    _moviesStreamController.close();
  }

  Future<void> fetchMovies(String keyword) async {
    final results =  await _dataManager.getMovies(query: keyword);

    _moviesStreamController.sink.add(results.toList());
  }

  Stream<List<Movie>> get moviesStream => _moviesStreamController.stream;

}