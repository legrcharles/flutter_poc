import 'package:flutter/material.dart';
import 'package:flutter_architecture/data/models/question.dart';
import 'package:flutter_architecture/presentation/common/widgets/custom_button.dart';
import 'package:flutter_architecture/presentation/quiz/question/bloc/quiz_question_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                  decoration: const BoxDecoration(
                      color: Color(0xff2E415A),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                  ),
                  child: Center(
                    child: Text(HtmlCharacterEntities.decode(question.category),
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontSize: 24.0,
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
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                            )
                        )
                    ),
                  ],
                ),
                Padding(padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                  child: LinearProgressIndicator(
                    value: (index + 1) / questions.length,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xffE6812F)),
                    backgroundColor: Colors.white,
                  ),
                ),
                Container(
                  height: 150.0,
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                  child: Center(
                    child: Text(
                      HtmlCharacterEntities.decode(question.question),
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 24.0,
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
                          margin: const EdgeInsets.all(20.0),
                          height: 50.0,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: CustomButton(
                              title: state.currentIndex + 1 < questions.length ? 'Next Question' : 'See results',
                              onTap: () => context.read<QuizQuestionBloc>().add(NextQuestion())
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