part of 'quiz_question_bloc.dart';

class QuizQuestionState extends Equatable {
  final DataState? dataState;
  final String answer;
  final int nbCorrect;
  final int currentIndex;
  final ToRoute? toResult;

  const QuizQuestionState({
    this.dataState,
    this.answer = '',
    this.nbCorrect = 0,
    this.currentIndex = 0,
    this.toResult
  });

  QuizQuestionState copyWith({ String? answer, int? nbCorrect, int? currentIndex, ToRoute? toResult, required DataState? dataState}) =>
      QuizQuestionState(
          answer: answer ?? this.answer,
          nbCorrect: nbCorrect ?? this.nbCorrect,
          currentIndex: currentIndex ?? this.currentIndex,
          toResult: toResult,
          dataState: dataState
      );

  @override
  List<Object?> get props => [answer, nbCorrect, currentIndex, toResult, dataState];

}