import 'package:equatable/equatable.dart';

class QuestionResponseDto extends Equatable {
  final String category;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  const QuestionResponseDto({
    required this.category,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  @override
  List<Object> get props =>
      [
        category,
        difficulty,
        question,
        correctAnswer,
        incorrectAnswers,
      ];

  factory QuestionResponseDto.fromJson(Map<String, dynamic> map) {
    return QuestionResponseDto(
      category: map['category'] ?? '',
      difficulty: map['difficulty'] ?? '',
      question: map['question'] ?? '',
      correctAnswer: map['correct_answer'] ?? '',
      incorrectAnswers: List<String>.from(map['incorrect_answers'] ?? []),
    );
  }
}