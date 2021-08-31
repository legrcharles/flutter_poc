import 'package:flutter_architecture/data/provider/quizapi/quiz_api_provider.dart';

class DataManager {
  final QuizApiProviderInterface _quizApi;

  DataManager(this._quizApi);

  QuizApiProviderInterface get quizApi {
    return _quizApi;
  }
}