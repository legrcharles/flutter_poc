import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/provider/firebaseauth/firebase_auth_provider.dart';
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

final dataManager = Provider((ref) => DataManager(
  ref.read(_quizApiProvider),
  ref.read(_movieApiProvider),
  ref.read(_authProvider)
));

class AppModule {

  final _httpClient = http.Client();

  static const _quizEndpoint = 'opentdb.com';
  static const _movieEndpoint = 'opentdb.com';

  final _authProvider = FirebaseAuthProvider();

  late DataManager dataManager;

  AppModule() {
    final _quizApiProvider = QuizApiProvider(_quizEndpoint, _httpClient);
    final _movieApiProvider = MovieApiProvider(_movieEndpoint, _httpClient);

    dataManager = DataManager(_quizApiProvider, _movieApiProvider, _authProvider);
  }

  void dispose() {
    dataManager.dispose();
  }

}