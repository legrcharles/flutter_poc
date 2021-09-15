import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/data/models/question.dart';
import 'package:flutter_architecture/generated/locale_keys.g.dart';
import 'package:flutter_architecture/presentation/common/utils/color_utils.dart';
import 'package:flutter_architecture/presentation/common/widgets/app_button.dart';
import 'package:flutter_architecture/presentation/quiz/question/bloc/quiz_question_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_character_entities/html_character_entities.dart';

import 'answer_card.dart';

class QuizQuestions extends StatelessWidget {
  final PageController pageController;
  final List<Question> questions;

  const QuizQuestions({
    required this.pageController,
    required this.questions,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: questions.length,
      itemBuilder: (BuildContext context, int index) {
        final question = questions[index];
        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                    color: AppColor.backgroundDark1,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                ),
                child: Center(
                  child: Text(HtmlCharacterEntities.decode(question.category),
                      style: TextStyle(
                        color: AppColor.secondary,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      )
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Spacer(),
                  Padding(padding: const EdgeInsets.only(right: 10.0, bottom: 5.0),
                      child: Text(
                          '${index + 1}/${questions.length}',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: AppColor.text,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          )
                      )
                  ),
                ],
              ),
              Padding(padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                child: LinearProgressIndicator(
                  value: (index + 1) / questions.length,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColor.fourth),
                  backgroundColor: AppColor.backgroundDark1,
                ),
              ),
              Container(
                height: 150.0,
                padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: Center(
                  child: Text(
                    HtmlCharacterEntities.decode(question.question),
                    style: TextStyle(
                      color: AppColor.text,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    )
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: question.answers.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.4),
                  itemBuilder: (BuildContext context, int index) {

                    final answer = question.answers[index];

                    return BlocBuilder<QuizQuestionBloc, QuizQuestionState>(
                      builder: (context, state) {
                        return AnswerCard(
                            answer: answer,
                            isSelected: answer == state.answer,
                            isCorrect : answer == question.correctAnswer,
                            isDisplayingAnswer : state.answer.isNotEmpty,
                            onTap : () => context.read<QuizQuestionBloc>().add(UserAnswered(answer: answer))
                        );
                      }
                    );
                  },
                )
              ),
              BlocBuilder<QuizQuestionBloc, QuizQuestionState>(
                builder: (context, state) {
                  if (state.answer.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    width: double.infinity,
                    alignment: Alignment.center,
                    /*
                    child: PlatformWidget(
                      cupertino: (_, __) => CupertinoButton.filled(
                        child: Text(
                          state.currentIndex + 1 < questions.length ? LocaleKeys.quiz_button_next : LocaleKeys.quiz_button_see_result,
                          style: const TextStyle(fontSize: 18),
                        ).tr(),
                        onPressed: () => context.read<QuizQuestionBloc>().add(NextQuestion())),
                      material: (_, __)  => ElevatedButton(
                        child: Text(
                          state.currentIndex + 1 < questions.length ? LocaleKeys.quiz_button_next : LocaleKeys.quiz_button_see_result,
                          style: const TextStyle(fontSize: 15),
                        ).tr(),
                        onPressed: () => context.read<QuizQuestionBloc>().add(NextQuestion())),
                    ),


                     */
                    child: AppButton(
                      title: state.currentIndex + 1 < questions.length ? LocaleKeys.quiz_button_next : LocaleKeys.quiz_button_see_result,
                      onPressed: () => context.read<QuizQuestionBloc>().add(NextQuestion()),
                    )
                  );
                }
              )
            ],
          ),
        );
      }

    );
  }

}