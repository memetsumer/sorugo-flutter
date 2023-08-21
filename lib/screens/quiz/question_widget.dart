import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import '/network/quiz/quiz_api.dart';
import '/network/quiz/quiz_dao.dart';
import '/screens/quiz/quiz_model.dart';
import '/screens/quiz/result_screen.dart';
import '/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/sorugo_card.dart';
import 'options_widget.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({Key? key}) : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int questionNumber = 1;
  int score = 0;
  bool isLocked = false;
  bool correctFlag = false;
  late PageController pageController;
  List<Question> randomQuestions = [];

  @override
  void initState() {
    FirebaseAnalytics.instance.logScreenView(
      screenName: 'QuestionWidget',
    );

    pageController = PageController(initialPage: 0);
    for (var i = 0; i < randomQuestionsAmount; i++) {
      String text = lorem(paragraphs: 1, words: 10);

      text = text.replaceRange(text.length - 1, text.length, '?');
      List<Option> options = [];

      int randomNumber = Random().nextInt(5);

      for (var i = 0; i < 5; i++) {
        if (i == randomNumber) {
          options.add(Option(
            text: "${optionTitles[i]}) ${lorem(paragraphs: 1, words: 1)}",
            isCorrect: true,
          ));
        } else {
          options.add(
            Option(
              text: "${optionTitles[i]}) ${lorem(paragraphs: 1, words: 1)}",
              isCorrect: false,
            ),
          );
        }
      }

      randomQuestions.add(
        Question(
          text: text,
          options: options,
          isLocked: false,
          selectedOption: null,
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Text(
            "<",
            style: GoogleFonts.pressStart2p(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.only(right: defaultPadding),
            child: Text(
              "Soru $questionNumber/${randomQuestions.length}",
              style: GoogleFonts.pressStart2p(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          )),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: defaultPadding * 3),
              const SizedBox(height: defaultPadding * 2),
              Expanded(
                  child: PageView.builder(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: randomQuestions.length,
                itemBuilder: (context, index) {
                  final question = randomQuestions[index];

                  return Column(children: [
                    Text(
                      question.text,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: defaultPadding * 2),
                    Expanded(
                      child: OptionsWidget(
                        question: question,
                        onTap: (option) {
                          HapticFeedback.lightImpact();

                          setState(() {
                            question.isLocked = true;
                            question.selectedOption = option;
                          });
                          isLocked = question.isLocked;
                          if (question.selectedOption!.isCorrect) {
                            setState(() {
                              correctFlag = true;
                            });
                          } else {
                            setState(() {
                              correctFlag = false;
                            });
                          }
                        },
                      ),
                    ),
                  ]);
                },
              )),
              if (isLocked)
                FadeInRight(
                  duration: const Duration(milliseconds: 300),
                  child: ElevatedButton(
                    onPressed: () {
                      HapticFeedback.heavyImpact();
                      if (correctFlag) {
                        score++;
                      }
                      setState(() {
                        correctFlag = false;
                      });

                      if (questionNumber < randomQuestions.length) {
                        pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInExpo);
                        setState(() {
                          questionNumber++;
                          isLocked = false;
                        });
                      } else {
                        for (var question in randomQuestions) {
                          question.isLocked = false;
                          question.selectedOption = null;
                        }
                        QuizDao().saveQuiz(
                          APIQuiz(
                            score: score.toDouble(),
                            date: DateTime.now(),
                            name:
                                FirebaseAuth.instance.currentUser!.displayName!,
                            id: FirebaseAuth.instance.currentUser!.uid,
                            photoUrl:
                                FirebaseAuth.instance.currentUser!.photoURL,
                          ),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizResultScreen(
                              score: score,
                              total: randomQuestions.length,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(defaultPadding)),
                    ),
                    child: SorugoCard(
                      backgroundColor: Colors.red,
                      opacityForeground: 0.1,
                      constraints: const BoxConstraints(
                        minWidth: 120,
                      ),
                      borderRadius: defaultPadding / 4,
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding, vertical: defaultPadding),
                      child: Text(
                        questionNumber < randomQuestions.length
                            ? "Next"
                            : "Finish",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.pressStart2p(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: defaultPadding * 2),
            ],
          ),
        ),
      ),
    );
  }
}
