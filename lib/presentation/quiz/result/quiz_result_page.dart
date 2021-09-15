import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/generated/locale_keys.g.dart';
import 'package:flutter_architecture/presentation/common/utils/color_utils.dart';
import 'package:flutter_architecture/presentation/common/widgets/app_button.dart';
import 'package:flutter_architecture/presentation/quiz/question/bloc/quiz_question_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text(LocaleKeys.quiz_result_title).tr(),
        cupertino: (context, platform) {
          return CupertinoNavigationBarData(
              transitionBetweenRoutes: true,
              automaticallyImplyLeading: true,
              previousPageTitle: LocaleKeys.quiz_title.tr()

          );
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${args.nbCorrect} / ${args.nbQuestions}',
            style: TextStyle(
              color: AppColor.text,
              fontSize: 60.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            LocaleKeys.quiz_result_label_correct.tr(),
            style: TextStyle(
              color: AppColor.textDark3,
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40.0),
          Center(
            child: AppButton(
              style: AppButtonStyle.secondary,
              title: LocaleKeys.quiz_result_button_new,
              onPressed: () {
                args.bloc.add(ResetData());
                args.bloc.add(LoadData());
                Navigator.of(context).pop();
              },
            )
          ),
        ],
      ),
    );
  }
}