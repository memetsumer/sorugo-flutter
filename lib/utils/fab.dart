import 'package:flutter/material.dart';

class Fab extends StatelessWidget {
  final Function onPressed;
  final Widget icon;
  const Fab({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => onPressed(),
      elevation: 10,
      enableFeedback: true,
      highlightElevation: 20,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(color: Colors.black, blurRadius: 10, spreadRadius: 3),
            BoxShadow(
              offset: Offset(-3, -3),
              color: Color.fromARGB(255, 114, 53, 124),
              spreadRadius: 2,
              blurRadius: 10,
            ),
            BoxShadow(
              offset: Offset(3, 3),
              color: Color.fromARGB(255, 105, 3, 85),
              blurRadius: 10,
            ),
          ],
          border: Border.all(
            color: const Color.fromARGB(255, 114, 53, 124),
            width: 2,
          ),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 114, 53, 124),
              Color.fromARGB(255, 105, 3, 85),
            ],
          ),
          // gradient: SorugoColors.getCyanPurpleGradient(context),
        ),
        child: Center(child: icon),
      ),
    );
  }
}
