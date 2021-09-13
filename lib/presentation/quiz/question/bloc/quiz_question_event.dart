part of 'quiz_question_bloc.dart';

abstract class QuizQuestionEvent extends Equatable {
  const QuizQuestionEvent();

  @override
  List<Object> get props => [];
}

class LoadData extends QuizQuestionEvent {}

class ResetData extends QuizQuestionEvent {}

class UserAnswered extends QuizQuestionEvent {
  const UserAnswered({required this.answer});

  final String answer;

  @override
  List<Object> get props => [answer];
}

class NextQuestion extends QuizQuestionEvent {}