import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/quiz_datamanager.dart';
import 'package:flutter_architecture/data/datamanager/user_datamanager.dart';
import 'package:flutter_architecture/data/models/question.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_architecture/app_module.dart';
import 'quiz_state.dart';

final quizViewModelProvider = StateNotifierProvider.autoDispose<QuizViewModel, QuizState>(
        (ref) => QuizViewModel(dataManager));

final questionsProvider = FutureProvider.autoDispose<List<Question>>(
        (ref) => ref.watch(quizViewModelProvider.notifier).getQuestions());

class QuizViewModel extends StateNotifier<QuizState> {
  final DataManager _dataManager;

  QuizViewModel(this._dataManager) : super(QuizState.initial());


  Future<List<Question>> getQuestions() {
    final user = _dataManager.getUser();
    return _dataManager.getQuestions();
  }

  void submitAnswer(Question currentQuestion, String answer) {
    if (state.answered) return;
    if (currentQuestion.correctAnswer == answer) {
      state = state.copyWith(
        selectedAnswer: answer,
        correct: state.nbCorrect + 1,
        status: QuizStatus.correct,
      );
    } else {
      state = state.copyWith(
        selectedAnswer: answer,
        status: QuizStatus.incorrect,
      );
    }
  }

  void nextQuestion(List<Question> questions, int currentIndex) {
    state = state.copyWith(
      selectedAnswer: '',
      status:  currentIndex + 1 < questions.length ? QuizStatus.initial : QuizStatus.complete
    );
  }

  void reset() {
    state = QuizState.initial();
  }
}