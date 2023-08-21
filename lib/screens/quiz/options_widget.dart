import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../components/sorugo_card.dart';
import 'quiz_model.dart';

class OptionsWidget extends StatelessWidget {
  final Question question;
  final ValueChanged<Option> onTap;
  const OptionsWidget({
    Key? key,
    required this.question,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: question.options
          .map((option) => buildOption(context, option))
          .toList(),
    );
  }

  Widget buildOption(BuildContext context, Option option) {
    final color = getColorForOption(option, question);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      child: SorugoCard(
        borderRadius: defaultPadding / 4,
        width: double.infinity,
        borderColor: color,
        child: ListTile(
          dense: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              defaultPadding / 4,
            ),
          ),
          onTap: () => onTap(option),
          title: Text(
            option.text,
          ),
          // trailing: getIconForOptionResult(option, question),
        ),
      ),
    );
  }

  Color getColorForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;

    if (question.isLocked) {
      if (isSelected) {
        return Colors.amber;
      }
    }

    return Colors.white24;
  }

  Color getColorForOptionResult(Option option, Question question) {
    final isSelected = option == question.selectedOption;

    if (question.isLocked) {
      if (isSelected) {
        return option.isCorrect ? Colors.green : Colors.red;
      } else if (option.isCorrect) {
        return Colors.green;
      }
    }

    return Colors.white24;
  }

  // Widget getIconForOptionResult(Option option, Question question) {
  //   final isSelected = option == question.selectedOption;

  //   if (question.isLocked) {
  //     if (isSelected) {
  //       return option.isCorrect
  //           ? const Icon(
  //               Icons.check,
  //               color: Colors.green,
  //             )
  //           : const Icon(
  //               Icons.cancel,
  //               color: Colors.red,
  //             );
  //     } else if (option.isCorrect) {
  //       return const Icon(
  //         Icons.check,
  //         color: Colors.green,
  //       );
  //     }
  //   }

  //   return const SizedBox.shrink();
  // }
}
