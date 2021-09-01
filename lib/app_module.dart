import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/provider/movieapi/movie_api_provider.dart';
import 'data/provider/quizapi/quiz_api_provider.dart';

final quizApiProvider = QuizApiProvider();

final movieApiProvider = MovieApiProvider();

final dataManager = DataManager(quizApiProvider, movieApiProvider);