import 'package:equatable/equatable.dart';
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/core/data_wrapper.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/datamanager/quiz_datamanager.dart';
import 'package:flutter_architecture/data/models/question.dart';
import 'package:flutter_architecture/presentation/quiz/result/view/quiz_result_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quiz_question_event.dart';
part 'quiz_question_state.dart';

class QuizQuestionBloc extends Bloc<QuizQuestionEvent, QuizQuestionState> {

  final DataManager _dataManager;

  QuizQuestionBloc(this._dataManager) : super(const QuizQuestionState());

  @override
  void onTransition(Transition<QuizQuestionEvent, QuizQuestionState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<QuizQuestionState> mapEventToState(QuizQuestionEvent event) async* {
    if (event is ResetData) {
      yield QuizQuestionState();

    } else if (event is LoadData) {
      yield state.copyWith(dataState: DataStateLoading());

      try {
        final results = await _dataManager.getQuestions();
        final questions = results.toList();
        yield state.copyWith(dataState: questions.isEmpty ? DataStateEmpty() : DataStateLoaded(data: questions));
      } catch (error) {
        yield state.copyWith(dataState: DataStateError(error: error.toString()));
      }

    } else if (event is UserAnswered) {
      if (state.answer.isEmpty) {
        final dataState = state.dataState;
        if (dataState is DataStateLoaded<List<Question>>) {
          final question = dataState.data[state.currentIndex];
          yield state.copyWith(
              dataState: state.dataState,
              answer: event.answer,
              nbCorrect: event.answer == question.correctAnswer ? state.nbCorrect + 1 : state.nbCorrect
          );
        }
      }
    } else if (event is NextQuestion) {
      final dataState = state.dataState;
      if (dataState is DataStateLoaded<List<Question>>) {
        if (dataState.data.length == state.currentIndex + 1) {
          yield state.copyWith(
              dataState: state.dataState,
              toResult: ToRoute(Routes.quizResult, QuizResultPageArguments(bloc: this, nbCorrect: state.nbCorrect, nbQuestions: dataState.data.length))
          );
        } else {
          yield state.copyWith(
              dataState: state.dataState,
              currentIndex: state.currentIndex + 1,
              answer: ''
          );
        }
      }
    }
  }

}