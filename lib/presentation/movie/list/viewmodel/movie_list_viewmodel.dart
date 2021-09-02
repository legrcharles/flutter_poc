import 'dart:async';
import 'package:flutter_architecture/core/data_wrapper.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/movie_datamanager.dart';
import 'package:flutter_architecture/data/models/movie.dart';

class MovieListViewModel  {
  final DataManager _dataManager;
  final StreamController<DataWrapper<List<Movie>>> _moviesStreamController = StreamController();

  MovieListViewModel(this._dataManager) {
    _moviesStreamController.sink.add(DataWrapper.empty());
  }

  void dispose() {
    _moviesStreamController.close();
  }

  Future<void> fetchMovies(String keyword) async {
    _moviesStreamController.sink.add(DataWrapper.empty());
    try {
      final results = await _dataManager.getMovies(query: keyword);

      _moviesStreamController.sink.add(DataWrapper.data(results.toList()));
    } catch(error) {
      _moviesStreamController.sink.add(DataWrapper.error(error));
    }
  }

  Stream<DataWrapper<List<Movie>>> get moviesStream => _moviesStreamController.stream;

}