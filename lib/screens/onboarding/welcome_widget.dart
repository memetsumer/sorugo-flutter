import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/app_provider.dart';
import '../../utils/constants.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<AppProvider>().setFirstTime(false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 7, 0, 29),
            Color.fromARGB(255, 0, 9, 29),
            Color.fromARGB(255, 44, 0, 46),
          ],
        ),
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: defaultPadding),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FadeIn(
              delay: const Duration(milliseconds: 500),
              child: const Text(
                "SoruGO'ya Hoşgeldin!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  shadows: [
                    BoxShadow(color: Colors.white, blurRadius: 12),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          const Padding(
            padding: EdgeInsets.all(defaultPadding * 2.4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.chartSimple,
                      color: Colors.greenAccent,
                      size: 33,
                    ),
                    SizedBox(width: defaultPadding),
                    Text(
                      " Netlerini ekle.",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: defaultPadding),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.fireFlameCurved,
                      color: Colors.greenAccent,
                      size: 33,
                    ),
                    SizedBox(width: defaultPadding),
                    Text(
                      "  Deneme sonuçlarını gör.",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: defaultPadding),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.chartLine,
                      color: Colors.greenAccent,
                      size: 33,
                    ),
                    SizedBox(width: defaultPadding),
                    Text(
                      "Taramalarını yönet.",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: defaultPadding),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.check,
                      color: Colors.greenAccent,
                      size: 33,
                    ),
                    SizedBox(width: defaultPadding),
                    Text(
                      " Sorularını kaydet.",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: defaultPadding),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.arrowTurnUp,
                      color: Colors.greenAccent,
                      size: 33,
                    ),
                    SizedBox(width: defaultPadding),
                    Text(
                      "  Yükselişini gör!",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: defaultPadding),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromARGB(255, 4, 95, 86),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Text(
                "Hemen Başla!",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
