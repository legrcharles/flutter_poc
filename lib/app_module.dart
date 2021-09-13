import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/provider/firebaseauth/firebase_auth_provider.dart';
import 'package:flutter_architecture/data/provider/memorycache/memory_cache_provider.dart';
import 'package:flutter_architecture/data/provider/movieapi/movie_api_provider.dart';
import 'data/provider/quizapi/quiz_api_provider.dart';
import 'package:http/http.dart' as http;

class AppModule {

  final _httpClient = http.Client();

  static const _quizEndpoint = 'opentdb.com';
  static const _movieEndpoint = 'www.omdbapi.com';

  final _authProvider = FirebaseAuthProvider();
  final _cacheProvider = MemoryCacheProvider();

  late DataManager dataManager;

  AppModule() {
    final _quizApiProvider = QuizApiProvider(_quizEndpoint, _httpClient);
    final _movieApiProvider = MovieApiProvider(_movieEndpoint, _httpClient);

    dataManager = DataManager(_quizApiProvider, _movieApiProvider, _authProvider, _cacheProvider);
  }

  void dispose() {
    dataManager.dispose();
  }

}