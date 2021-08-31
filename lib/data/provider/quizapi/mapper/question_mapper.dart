import 'package:flutter_architecture/data/models/question.dart';
import 'package:flutter_architecture/data/provider/quizapi/dto/question_response_dto.dart';

class QuestionMapper {

  static Question map(QuestionResponseDto dto) {
    return Question(
        category: dto.category,
        difficulty: dto.difficulty,
        question: dto.question,
        correctAnswer: dto.correctAnswer,
        answers: dto.incorrectAnswers
          ..add(dto.correctAnswer)
          ..shuffle());
  }
}