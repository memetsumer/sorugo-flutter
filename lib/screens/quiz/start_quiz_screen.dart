import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/screens/quiz/question_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants.dart';
import '../components/sorugo_card.dart';
import 'leaderboard_screen.dart';

class StartQuizScreen extends StatelessWidget {
  const StartQuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
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
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned(
            right: defaultPadding,
            top: defaultPadding * 2,
            child: FadeIn(
              child: Lottie.asset("assets/lottie/heart.json", width: 200),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: defaultPadding,
                ),
                AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      "Şansına güvenmeye hazır mısın?",
                      speed: const Duration(milliseconds: 100),
                      textStyle: GoogleFonts.pressStart2p(
                        color: Colors.white,
                        fontSize: 21,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: defaultPadding * 1,
                ),
                FadeInLeft(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 3100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Her biri rastgele olan ve 5'er şıktan oluşan bu 10 soruluk quizde tüm soruları doğru cevaplama olasılığın, ",
                      ),
                      const SizedBox(
                        height: defaultPadding / 2,
                      ),
                      const Text(
                        "10.000.001.024'te birdir.",
                        style: TextStyle(
                          fontSize: 21,
                        ),
                      ),
                      const Text(
                        "(Piyangonun vurma olasılığından 1000 kat daha zor!)",
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(
                        height: defaultPadding * 1,
                      ),
                      Text(
                        "İçinden hangi şık geçiyorsa onu seçerek devam et :)",
                        style: GoogleFonts.pressStart2p(
                          color: Colors.white,
                          fontSize: 12,
                          height: 1.5,

                          // height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: defaultPadding * 3,
                ),
                Row(
                  children: [
                    const Spacer(),
                    FadeInRight(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 3200),
                      child: ElevatedButton(
                        onPressed: () {
                          HapticFeedback.heavyImpact();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const QuestionWidget(),
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
                            "Next",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.pressStart2p(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: defaultPadding * 4,
                ),
                FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 3200),
                  child: SorugoCard(
                    backgroundColor: Colors.red,
                    opacityForeground: 0.1,
                    borderRadius: 4,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      dense: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LeaderboardScreen(),
                          ),
                        );
                      },
                      // leading: const Icon(Icons.favorite),

                      title: Text(
                        "Sıralamaları Gör",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.pressStart2p(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
