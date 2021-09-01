import 'package:flutter_architecture/data/provider/movieapi/movie_api_provider.dart';
import 'package:flutter_architecture/data/provider/quizapi/quiz_api_provider.dart';

class DataManager {
  final QuizApiProviderInterface _quizApi;
  final MovieApiProviderInterface _movieApi;

  DataManager(this._quizApi, this._movieApi);

  QuizApiProviderInterface get quizApi {
    return _quizApi;
  }

  MovieApiProviderInterface get movieApi {
    return _movieApi;
  }

  void dispose() {
    _quizApi.dispose();
    _movieApi.dispose();
  }
}