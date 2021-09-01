import 'dart:math';

import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/models/question.dart';

extension QuizDataManager on DataManager {

  Future<List<Question>> getQuestions() {
    return quizApi.getQuestions(numQuestions: 5, categoryId: Random().nextInt(24) + 9);
  }
}
