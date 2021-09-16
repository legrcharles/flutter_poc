import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:flutter_architecture/app_route.dart';
import 'package:flutter_architecture/core/data_wrapper.dart';
import 'package:flutter_architecture/data/datamanager/datamanager.dart';
import 'package:flutter_architecture/data/models/question.dart';
import 'package:flutter_architecture/generated/locale_keys.g.dart';
import 'package:flutter_architecture/presentation/quiz/question/bloc/quiz_question_bloc.dart';
import 'package:flutter_architecture/presentation/quiz/question/widgets/widgets.dart';
import 'package:flutter_architecture/presentation/quiz/result/quiz_result_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class QuizQuestionPage extends StatelessWidget {
  const QuizQuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => QuizQuestionBloc(context.read<DataManager>()),
        child: const QuizQuestionView());
  }
}

class QuizQuestionView extends StatefulWidget {
  const QuizQuestionView({Key? key}) : super(key: key);

  @override
  _QuizQuestionViewState createState() => _QuizQuestionViewState();
}

class _QuizQuestionViewState extends State<QuizQuestionView>
    with WidgetsBindingObserver {
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    _pageController.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    dev.log('AppLifecycleState: $state');
  }

  @override
  Widget build(BuildContext context) {
    context.read<QuizQuestionBloc>().add(LoadData());

    return BlocListener<QuizQuestionBloc, QuizQuestionState>(
      listenWhen: (previous, current) =>
          previous.currentIndex != current.currentIndex ||
          previous.toResult != current.toResult,
      listener: (context, state) {
        final toRoute = state.toResult;

        if (toRoute != null) {
          Navigator.of(context)
              .pushNamed(toRoute.route.path, arguments: toRoute.arguments);
        } else if (_pageController.hasClients) {
          _pageController.animateToPage(state.currentIndex,
              duration: const Duration(microseconds: 250),
              curve: Curves.linear);
        }
      },
      child: PlatformScaffold(
        appBar: PlatformAppBar(
          title: const Text(LocaleKeys.quiz_title).tr(),
          cupertino: (context, platform) {
            return CupertinoNavigationBarData(
                transitionBetweenRoutes: true,
                automaticallyImplyLeading: true,
                previousPageTitle: LocaleKeys.home_title.tr());
          },
          material: (context, platform) {
            return MaterialAppBarData();
          },
        ),
        body: BlocBuilder<QuizQuestionBloc, QuizQuestionState>(
          builder: (context, state) {
            final dataState = state.dataState;

            if (dataState is DataStateLoading) {
              return Center(child: PlatformCircularProgressIndicator());
            } else if (dataState is DataStateEmpty) {
              return const Center(child: Text('Aucune questions'));
            } else if (dataState is DataStateError) {
              return Center(child: Text('${dataState.error}'));
            } else if (dataState is DataStateLoaded<List<Question>>) {
              return QuizQuestions(
                  pageController: _pageController, questions: dataState.data);
            }

            return Center(child: PlatformCircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
