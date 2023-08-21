import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../utils/help_dialog.dart';
import '/screens/components/sorugo_card.dart';

import '../../../utils/constants.dart';

class StatusKonu extends StatelessWidget {
  final String title;
  final int value;
  final String helpTitle;
  final String helpMessage;
  final String? helpMessage2;

  const StatusKonu({
    Key? key,
    required this.title,
    required this.value,
    required this.helpTitle,
    required this.helpMessage,
    this.helpMessage2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SorugoCard(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      constraints: const BoxConstraints(minWidth: 150),
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                ),
          ),
          Row(
            children: [
              Text(
                value.toString(),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 35,
                  color: Colors.white,
                  shadows: const [
                    BoxShadow(
                      color: Color.fromARGB(159, 255, 255, 255),
                      blurRadius: 8,
                    )
                  ],
                ),
              ),
              if (value == 0)
                IconButton(
                  onPressed: () => showHelpDialog(context),
                  icon: const FaIcon(
                    FontAwesomeIcons.circleQuestion,
                    color: Colors.white70,
                    size: 21,
                  ),
                )
            ],
          )
        ],
      ),
    );
  }

  Future<void> showHelpDialog(context) async {
    return await showModal(
        configuration: const FadeScaleTransitionConfiguration(
          transitionDuration: Duration(milliseconds: 300),
          reverseTransitionDuration: Duration(milliseconds: 300),
        ),
        context: context,
        builder: (_) => HelpDialog(
              title: helpTitle,
              message: helpMessage,
              message2: helpMessage2,
            ));
  }
}

class StatusWarning extends StatelessWidget {
  final String value;

  const StatusWarning({
    Key? key,
    required this.value,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(defaultPadding)),
        color: Color.fromARGB(255, 9, 9, 9),
        border: Border.fromBorderSide(
          BorderSide(
            color: Color.fromARGB(255, 26, 26, 26),
            width: 2,
          ),
        ),
      ),
      constraints:
          const BoxConstraints(minWidth: 150, maxWidth: 180, maxHeight: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const FaIcon(
            FontAwesomeIcons.triangleExclamation,
            color: Colors.orange,
            size: 20,
          ),
          Flexible(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 12,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
