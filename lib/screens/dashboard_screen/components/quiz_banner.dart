import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants.dart';
import '../../quiz/start_quiz_screen.dart';

class QuizBanner extends StatelessWidget {
  const QuizBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GamifiedButton(
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        dense: true,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StartQuizScreen(),
            ),
          );
        },
        title: Text(
          "Sallama gücünü ölç!",
          style: GoogleFonts.pressStart2p(
            color: Colors.white,
            fontSize: 11,
          ),
        ),
        trailing: Text(
          ">",
          style: GoogleFonts.pressStart2p(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class GamifiedButton extends StatelessWidget {
  final Widget child;
  const GamifiedButton({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Colors.black, sorugoColorSecondary]),
          borderRadius: BorderRadius.circular(defaultPadding),
          border: Border.all(
            color: Colors.white24,
            width: 1,
          ),
        ),
        child: child);
  }
}
