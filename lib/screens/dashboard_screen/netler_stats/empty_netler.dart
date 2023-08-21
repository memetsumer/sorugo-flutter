import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class EmptyNetler extends StatelessWidget {
  final String message;
  const EmptyNetler({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        const SizedBox(
          height: defaultPadding * 2,
        ),
        const Text(
          "Burası Henüz Boş!",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: defaultPadding / 2,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding / 2,
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
              ),
            )),
      ]),
    );
  }
}
