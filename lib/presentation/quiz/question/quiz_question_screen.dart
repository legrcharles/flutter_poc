import 'package:flutter/material.dart';
import 'package:flutter_architecture/app_module.dart';
import 'package:flutter_architecture/core/data_wrapper.dart';
import 'package:flutter_architecture/data/models/question.dart';
import 'package:flutter_architecture/presentation/quiz/question/quiz_question_viewmodel.dart';
import 'package:flutter_architecture/presentation/quiz/question/widgets/quiz_question.dart';

class QuizQuestionScreen extends StatefulWidget {

  @override
  _QuizQuestionScreenState createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> with WidgetsBindingObserver {
  final _viewModel = QuizQuestionViewModel(dataManager);
  final _pageController = PageController();

  _QuizQuestionScreenState() {
    _viewModel.currentIndexStream.listen((event) {
      if (_pageController.hasClients) {
        _pageController.animateToPage(event, duration: const Duration(microseconds: 250), curve: Curves.linear);
      }
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _pageController.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _viewModel.loadQuestions();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('AppLifecycleState: $state');
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
          stream: _viewModel.questionsStream,
          builder: (BuildContext context, AsyncSnapshot<DataWrapper<List<Question>>> snapshot) {
            final state = snapshot.data?.state ?? DataWrapper.initial();
            if (snapshot.hasData) {
              if (state is StateInitial) return Container();
              if (state is StateLoading) return Center(child: CircularProgressIndicator());
              if (state is StateData) return QuizQuestions(pageController: _pageController, questions: state.data, viewModel: _viewModel);
              if (state is StateEmpty) return Center(child: Text('Aucune questions'));
              if (state is StateError) return Center(child: Text('${state.error}'));
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
