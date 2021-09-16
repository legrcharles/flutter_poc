import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/presentation/common/utils/color_utils.dart';
import 'package:flutter_architecture/presentation/common/widgets/circular_icon.dart';
import 'package:html_character_entities/html_character_entities.dart';

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final bool isCorrect;
  final bool isDisplayingAnswer;
  final VoidCallback onTap;

  const AnswerCard(
      {required this.answer,
      required this.isSelected,
      required this.isCorrect,
      required this.isDisplayingAnswer,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColor.backgroundLight1,
          border: Border.all(
            color: isDisplayingAnswer
                ? isCorrect
                    ? AppColor.valid
                    : isSelected
                        ? AppColor.error
                        : AppColor.backgroundLight1
                : AppColor.backgroundLight1,
            width: 4.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                HtmlCharacterEntities.decode(answer),
                style: TextStyle(
                  color: AppColor.textDark3,
                  fontSize: 15.0,
                  fontWeight: isDisplayingAnswer && isCorrect
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
            if (isDisplayingAnswer)
              isCorrect
                  ? CircularIcon(icon: Icons.check, color: AppColor.valid)
                  : isSelected
                      ? CircularIcon(
                          icon: Icons.close,
                          color: AppColor.error,
                        )
                      : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
