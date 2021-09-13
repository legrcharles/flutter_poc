import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/common/widgets/custom_button.dart';
import 'package:flutter_architecture/presentation/quiz/question/bloc/quiz_question_bloc.dart';

class QuizResultPageArguments {
  final int nbCorrect;
  final int nbQuestions;
  final QuizQuestionBloc bloc;

  QuizResultPageArguments({required this.bloc, required this.nbCorrect, required this.nbQuestions});
}

class QuizResultPage extends StatelessWidget {
  final QuizResultPageArguments args;

  const QuizResultPage({
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF22293E),
      appBar: AppBar(
        title: Text("Results"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${args.nbCorrect} / ${args.nbQuestions}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 60.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const Text(
            'CORRECT',
            style: TextStyle(
              color: Colors.white,
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40.0),
          Center(
            child: ElevatedButton(
              child: Text('New Quiz'),
              onPressed: () {
                args.bloc.add(ResetData());
                args.bloc.add(LoadData());
                Navigator.of(context).pop();
                //context.refresh(questionsProvider);
                //context.read(quizViewModelProvider.notifier).reset();
              },
            ),
          ),
        ],
      ),
    );
  }
}