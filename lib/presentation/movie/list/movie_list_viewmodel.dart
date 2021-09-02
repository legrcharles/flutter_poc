import 'dart:async';
import 'package:flutter_architecture/core/data_wrapper.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/movie_datamanager.dart';
import 'package:flutter_architecture/data/models/movie.dart';

class MovieListViewModel  {
  final DataManager _dataManager;
  final StreamController<DataWrapper<List<Movie>>> _moviesStreamController = StreamController();
  Stream<DataWrapper<List<Movie>>> get moviesStream => _moviesStreamController.stream;

  MovieListViewModel(this._dataManager) {
    _moviesStreamController.sink.add(DataWrapper.initial());
  }

  void dispose() {
    _moviesStreamController.close();
  }

  void loadMovies(String keyword) async {
    _moviesStreamController.sink.add(DataWrapper.loading());
    try {
      final results = await _dataManager.getMovies(query: keyword);
      final movies = results.toList();

      _moviesStreamController.sink.add(movies.isEmpty ? DataWrapper.empty() : DataWrapper.data(movies));
    } catch(error) {
      _moviesStreamController.sink.add(DataWrapper.error(error));
    }
  }
}