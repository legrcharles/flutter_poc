import 'package:flutter_architecture/data/provider/firebaseauth/firebase_auth_provider.dart';
import 'package:flutter_architecture/data/provider/movieapi/movie_api_provider.dart';
import 'package:flutter_architecture/data/provider/quizapi/quiz_api_provider.dart';

class DataManager {
  final QuizApiProviderInterface _quizApi;
  final MovieApiProviderInterface _movieApi;
  final FirebaseAuthProvider _authProvider;

  DataManager(this._quizApi, this._movieApi, this._authProvider);

  QuizApiProviderInterface get quizApi {
    return _quizApi;
  }

  MovieApiProviderInterface get movieApi {
    return _movieApi;
  }

  FirebaseAuthProvider get authProvider {
    return _authProvider;
  }

  void dispose() {
    _quizApi.dispose();
    _movieApi.dispose();
    _authProvider.dispose();
  }
}