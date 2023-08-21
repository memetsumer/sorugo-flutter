import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class DenemeTitleCard extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  const DenemeTitleCard({
    Key? key,
    required this.child,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultPadding),
        gradient: const LinearGradient(colors: [
          Color.fromARGB(255, 78, 36, 85),
          Color.fromARGB(255, 66, 2, 53),
          // defaultLightGrey
        ]),
        border: Border.all(
          color: Colors.white24,
          width: 1,
        ),
      ),
      margin: const EdgeInsets.all(defaultPadding / 8),
      padding: const EdgeInsets.symmetric(
        vertical: defaultPadding / 4,
        horizontal: defaultPadding / 2,
      ),
      child: child,
    );
  }
}
