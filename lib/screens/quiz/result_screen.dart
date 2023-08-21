import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yks_app/screens/quiz/leaderboard_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';
import '../components/sorugo_card.dart';

class QuizResultScreen extends StatefulWidget {
  final int score;
  final int total;
  const QuizResultScreen({
    Key? key,
    required this.score,
    required this.total,
  }) : super(key: key);

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  late ConfettiController _controllerTopCenter;

  @override
  void initState() {
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 1));

    if (widget.score == widget.total) {
      HapticFeedback.heavyImpact();
      _controllerTopCenter.play();
    }
    if (widget.score > widget.total / 2) {
      HapticFeedback.heavyImpact();
      _controllerTopCenter.play();
    }
    if (widget.score == widget.total / 2) {
      HapticFeedback.heavyImpact();
      _controllerTopCenter.play();
    }

    super.initState();
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "<",
            style: GoogleFonts.pressStart2p(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        title: Text(
          "Skor",
          style: GoogleFonts.pressStart2p(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.score == widget.total)
                    Text(
                      "INANILMAZ! Tamamını doğru işaretledin, bu konuda kesinlikle yeteneklisin!",
                      style: GoogleFonts.pressStart2p(
                          color: Colors.white, fontSize: 13, height: 1.4),
                    ),
                  if (widget.score == widget.total / 2)
                    Text(
                      "Tam yarısını doğru işaretledin, bravo!",
                      style: GoogleFonts.pressStart2p(
                          color: Colors.white, fontSize: 13, height: 1.4),
                    ),
                  if (widget.score == widget.total - 1)
                    Text(
                      "Biri hariç hepsini doğru işaretledin, süpersin!",
                      style: GoogleFonts.pressStart2p(
                          color: Colors.white, fontSize: 13, height: 1.4),
                    ),
                  if (widget.score > widget.total / 2 &&
                      widget.score != widget.total &&
                      widget.score != widget.total - 1)
                    Text(
                      "Yarısından fazlasını doğru yaptın! Tebrikler!",
                      style: GoogleFonts.pressStart2p(
                          color: Colors.white, fontSize: 13, height: 1.4),
                    ),
                  if (widget.score < widget.total / 2 && widget.score != 0)
                    Text(
                      "Bir dahaki sefere daha iyisini yapacaksın!",
                      style: GoogleFonts.pressStart2p(
                          color: Colors.white, fontSize: 13, height: 1.4),
                    ),
                  if (widget.score == 0)
                    Text(
                      "Maalesef, hiç biri tutmadı :(",
                      style: GoogleFonts.pressStart2p(
                          color: Colors.white, fontSize: 14, height: 1.4),
                    ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Center(
                      child: Row(
                    children: [
                      Text(
                        "${widget.score}",
                        style: GoogleFonts.pressStart2p(
                          color: Colors.white,
                          fontSize: 50,
                        ),
                      ),
                      Text(
                        "/",
                        style: GoogleFonts.pressStart2p(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        "${widget.total}",
                        style: GoogleFonts.pressStart2p(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  )),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LeaderboardScreen(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultPadding)),
                        ),
                        child: SorugoCard(
                          backgroundColor: Colors.red,
                          opacityForeground: 0.1,
                          constraints: const BoxConstraints(
                            minWidth: 120,
                          ),
                          borderRadius: defaultPadding / 4,
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding,
                              vertical: defaultPadding),
                          child: Text(
                            "Sıralamanı Gör!",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.pressStart2p(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controllerTopCenter,
              blastDirection: pi / 2,

              numberOfParticles: widget.score == widget.total
                  ? 80
                  : widget.score > widget.total / 2
                      ? 50
                      : 30, // a lot of particles at once
            ),
          ),
        ],
      ),
    );
  }
}
