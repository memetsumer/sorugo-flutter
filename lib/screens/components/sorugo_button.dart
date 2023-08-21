import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class SorugoButton extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  final double? width;
  final double? fontSize;
  final bool? error;
  const SorugoButton({
    Key? key,
    required this.onPress,
    required this.text,
    this.width,
    this.fontSize,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 80,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultPadding),
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 78, 36, 85),
            Color.fromARGB(255, 66, 2, 53),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        border: Border.all(
          color: error != null && error! ? Colors.redAccent : Colors.white24,
          width: 1,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          splashFactory: InkSparkle.splashFactory,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultPadding)),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: fontSize ?? 13,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
