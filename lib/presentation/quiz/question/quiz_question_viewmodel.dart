import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/core/data_wrapper.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/quiz_datamanager.dart';
import 'package:flutter_architecture/data/models/question.dart';

class QuizQuestionViewModel {
  final DataManager _dataManager;
  int _nbCorrectAnswers = 0;
  List<Question> _questions = [];
  String? _selectedAnswer;
  int _currentIndex = 0;

  final StreamController<DataWrapper<List<Question>>> _questionsStreamController = StreamController();
  Stream<DataWrapper<List<Question>>> get questionsStream => _questionsStreamController.stream;

  final StreamController<int> _currentIndexStreamController = StreamController.broadcast();
  Stream<int> get currentIndexStream => _currentIndexStreamController.stream;

  final StreamController<String?> _selectedAnswerStreamController = StreamController.broadcast();
  Stream<String?> get selectedAnswerStream => _selectedAnswerStreamController.stream;

  QuizQuestionViewModel(this._dataManager) {
    _questionsStreamController.sink.add(DataWrapper.initial());
//    _currentIndexStreamController.sink.add(0);
    loadQuestions();
  }

  void dispose() {
    _questionsStreamController.close();
    _currentIndexStreamController.close();
    _selectedAnswerStreamController.close();
  }

  void loadQuestions() async {
    _questionsStreamController.sink.add(DataWrapper.loading());
    try {
      final results = await _dataManager.getQuestions();
      _questions = results.toList();
      _questionsStreamController.sink.add(_questions.isEmpty ? DataWrapper.empty() : DataWrapper.data(_questions));
    } catch(error) {
      _questionsStreamController.sink.add(DataWrapper.error(error));
    }
  }

  void submitAnswer(Question currentQuestion, String answer) {
    if (_selectedAnswer != null) return;

    _selectedAnswer = answer;
    _selectedAnswerStreamController.sink.add(answer);

    if (currentQuestion.correctAnswer == answer) {
      _nbCorrectAnswers = _nbCorrectAnswers + 1;
    }
  }

  void nextQuestion(BuildContext context) {
    if (_currentIndex == _questions.length - 1) {
      Navigator.pushNamed(context, Routes.counter.path, arguments: 17);
    } else {
      _currentIndex = _currentIndex + 1;
      _selectedAnswer = null;
      _selectedAnswerStreamController.sink.add(null);
      _currentIndexStreamController.sink.add(_currentIndex);
    }
  }

  /*
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
   */
}