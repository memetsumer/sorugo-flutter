import 'package:flutter/material.dart';

import 'constants.dart';

class HelpDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? message2;
  const HelpDialog({
    Key? key,
    required this.title,
    required this.message,
    this.message2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: darkBackgroundColorSecondary,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24))),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 15),
      ),
      content: Wrap(
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium!,
          ),
          if (message2 != null)
            Text(
              message2 ?? "",
              style: Theme.of(context).textTheme.bodyMedium!,
            ),
        ],
      ),
      actions: [
        TextButton(
          child: Text(
            'Tamam',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.blueAccent),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
