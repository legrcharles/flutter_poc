import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/provider/movieapi/movie_api_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/network/http_client.dart';
import 'data/provider/quizapi/quiz_api_provider.dart';

final baseHttpClient = HttpClient("https://opentdb.com");

final movieHttpClient = HttpClient("http://www.omdbapi.com");

final quizApiProvider = QuizApiProvider(baseHttpClient);

final movieApiProvider = MovieApiProvider(movieHttpClient);

final dataManager = DataManager(quizApiProvider, movieApiProvider);