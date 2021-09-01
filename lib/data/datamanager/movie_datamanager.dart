import 'dart:math';

import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/user_datamanager.dart';
import 'package:flutter_architecture/data/models/movie.dart';
import 'package:flutter_architecture/data/models/question.dart';

extension MovieDataManager on DataManager {

  Future<List<Movie>> getMovies({required String query}) {
    return movieApi.getMovies(query: query);
  }
}
