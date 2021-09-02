import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_module.dart';
import 'package:flutter_architecture/core/data_wrapper.dart';
import 'package:flutter_architecture/data/models/question.dart';
import 'package:flutter_architecture/presentation/quiz/question/quiz_question_viewmodel.dart';
import 'package:flutter_architecture/presentation/quiz/question/widgets/quiz_question.dart';

class QuizQuestionScreen extends StatelessWidget {

  final viewModel = QuizQuestionViewModel(dataManager);
  final pageController = PageController();

  QuizQuestionScreen() {
    viewModel.currentIndexStream.listen((event) {
      pageController.animateToPage(event, duration: const Duration(microseconds: 250), curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF22293E),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("My App"),
        ),
        backgroundColor: Colors.transparent,
        body: StreamBuilder<DataWrapper<List<Question>>>(
          stream: viewModel.questionsStream,
          builder: (BuildContext context, AsyncSnapshot<DataWrapper<List<Question>>> snapshot) {
            final state = snapshot.data?.state ?? DataWrapper.initial();
            if (snapshot.hasData) {
              if (state is StateInitial) return Container();
              if (state is StateLoading) return Center(child: CircularProgressIndicator());
              if (state is StateData) return QuizQuestions(pageController: pageController, questions: state.data, viewModel: viewModel);
              if (state is StateEmpty) return Center(child: Text('Aucune questions'));
              if (state is StateError) return Center(child: Text('${state.error}'));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        /*
        bottomSheet: questionsFuture.maybeWhen(
            data: (questions) {
              if (!viewModelState.answered) return SizedBox.shrink();
              var currentIndex = pageController.page?.toInt() ?? 0;
              return CustomButton(
                  title: currentIndex + 1 < questions.length ? 'Next Question' : 'See results',
                  onTap: () {
                    context
                        .read(quizViewModelProvider.notifier)
                        .nextQuestion(questions, currentIndex);
                    if (currentIndex + 1 < questions.length) {
                      pageController.nextPage(
                          duration: const Duration(microseconds: 250), curve: Curves.linear);
                    }
                  });
            },
            orElse: () => SizedBox.shrink()),

         */
      ),
    );
  }

}
