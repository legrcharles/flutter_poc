import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/provider/firebaseauth/firebase_auth_provider.dart';
import 'package:flutter_architecture/data/provider/memorycache/memory_cache_provider.dart';
import 'package:flutter_architecture/data/provider/movieapi/movie_api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/provider/quizapi/quiz_api_provider.dart';
import 'package:http/http.dart' as http;

final _httpClient = Provider((ref) => http.Client());

final _quizEndpoint = Provider((ref) => 'opentdb.com');
final _quizApiProvider = Provider((ref) => QuizApiProvider(ref.read(_quizEndpoint), ref.read(_httpClient)));

final _movieEndpoint = Provider((ref) => 'www.omdbapi.com');
final _movieApiProvider = Provider((ref) => MovieApiProvider(ref.read(_movieEndpoint), ref.read(_httpClient)));

final _authProvider = Provider((ref) => FirebaseAuthProvider());
final _cacheProvider = Provider((ref) => MemoryCacheProvider());

final dataManager = Provider((ref) => DataManager(
  ref.read(_quizApiProvider),
  ref.read(_movieApiProvider),
  ref.read(_authProvider),
  ref.read(_cacheProvider)
));

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