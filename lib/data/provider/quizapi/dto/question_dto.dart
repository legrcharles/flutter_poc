import 'package:equatable/equatable.dart';

class QuestionDto extends Equatable {
  final String category;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  const QuestionDto({
    required this.category,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  @override
  List<Object> get props => [
        category,
        difficulty,
        question,
        correctAnswer,
        incorrectAnswers,
      ];

  QuestionDto.fromJson(Map<String, dynamic> json)
      : category = json['category'] ?? '',
        difficulty = json['difficulty'] ?? '',
        question = json['question'] ?? '',
        correctAnswer = json['correct_answer'] ?? '',
        incorrectAnswers = List<String>.from(json['incorrect_answers'] ?? []);
}
