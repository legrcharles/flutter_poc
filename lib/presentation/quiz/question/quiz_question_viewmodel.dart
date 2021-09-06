import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_module.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/core/data_wrapper.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/quiz_datamanager.dart';
import 'package:flutter_architecture/data/models/question.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final quizQuestionViewModelProvider = Provider((ref) => QuizQuestionViewModel(ref.read(dataManager)));

class QuizQuestionViewModel {

  // Dependencies

  final DataManager _dataManager;
  int _nbCorrectAnswers = 0;

  // Subjects

  final BehaviorSubject<DataWrapper<List<Question>>> _questionsSubject = BehaviorSubject.seeded(DataWrapper.initial());
  Stream<DataWrapper<List<Question>>> get questionsStream => _questionsSubject.stream;

  final BehaviorSubject<int> _currentIndexSubject = BehaviorSubject.seeded(0);
  Stream<int> get currentIndexStream => _currentIndexSubject.stream;

  final BehaviorSubject<String?> _selectedAnswerSubject = BehaviorSubject.seeded(null);
  Stream<String?> get selectedAnswerStream => _selectedAnswerSubject.stream;

  // Init

  QuizQuestionViewModel(this._dataManager);

  // Dispose

  void dispose() {
    _questionsSubject.close();
    _currentIndexSubject.close();
    _selectedAnswerSubject.close();
  }

  // Events

  void loadQuestions() async {
    _questionsSubject.sink.add(DataWrapper.loading());
    try {
      final results = await _dataManager.getQuestions();
      final questions = results.toList();
      _questionsSubject.sink.add(questions.isEmpty ? DataWrapper.empty() : DataWrapper.data(questions));
    } catch (error) {
      _questionsSubject.sink.add(DataWrapper.error(error));
    }
  }

  void submitAnswer(Question currentQuestion, String answer) {
    if (_selectedAnswer != null) return;

    _selectedAnswerSubject.sink.add(answer);

    if (currentQuestion.correctAnswer == answer) {
      _nbCorrectAnswers = _nbCorrectAnswers + 1;
    }
  }

  void nextQuestion(BuildContext context) {
    if (_currentIndex == _questions.length - 1) {
      Navigator.pushNamed(context, Routes.counter.path, arguments: 17);
    } else {
      _selectedAnswerSubject.sink.add(null);
      _currentIndexSubject.sink.add(_currentIndex + 1);
    }
  }

  // Privates

  List<Question> get _questions {
    final DataWrapperState state = _questionsSubject.value.state;
    if (state is StateData) {
      return state.data;
    }

    return <Question>[];
  }

  int get _currentIndex => _currentIndexSubject.value;

  String? get _selectedAnswer => _selectedAnswerSubject.value;
}