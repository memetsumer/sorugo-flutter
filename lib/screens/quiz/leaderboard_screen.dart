import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import '/network/quiz/quiz_dao.dart';
import '/screens/components/firebase_error.dart';
import '/screens/quiz/highlighted_user.dart';
import 'leaderboard_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  void initState() {
    FirebaseAnalytics.instance.logScreenView(
      screenName: 'LeaderboardScreen',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBar(
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
                          "Sıralamalar",
                          style: GoogleFonts.pressStart2p(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          child: Row(
                            children: [
                              Text(
                                "En İyi Sallayanlar",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.pressStart2p(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                width: defaultPadding,
                              ),
                              Lottie.asset(
                                "assets/lottie/trophy.json",
                                width: 40,
                              ),
                            ],
                          )),
                      StreamBuilder(
                          stream: QuizDao().getFirstThree(),
                          builder: ((context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const FirebaseError(
                                  message: "Bir Şeyler Yanlış Gitti!");
                            }
                            if (snapshot.hasData) {
                              List<Map<String, dynamic>> firstThree = [];

                              snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                firstThree.add(data);
                              }).toList();

                              if (firstThree.isEmpty) {
                                return const SizedBox.shrink();
                              }

                              return firstThree.length >= 3
                                  ? SizedBox(
                                      width: size.width,
                                      height: defaultPadding * 9 + 200,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Positioned(
                                            // right: size.width / 2,
                                            top: defaultPadding * 9,

                                            right: size.width * 0.10,
                                            child: HighlightedUser(
                                              data: firstThree.last,
                                              rank: 3,
                                              rankSize: 18,
                                              photoRadius: size.height * 0.055,
                                            ),
                                          ),
                                          Positioned(
                                              top: defaultPadding,
                                              child: HighlightedUser(
                                                data: firstThree.first,
                                                rank: 1,
                                                rankSize: 35,
                                                photoRadius: size.height * 0.11,
                                              )),
                                          Positioned(
                                            // left: 10,
                                            left: size.width * 0.11,
                                            top: defaultPadding * 6,

                                            child: HighlightedUser(
                                              rank: 2,
                                              rankSize: 24,
                                              data: firstThree[1],
                                              photoRadius: size.height * 0.055,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          }))
                    ],
                  ),
                ),
              ];
            },
            body: const SafeArea(
              child: LeaderBoardWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
