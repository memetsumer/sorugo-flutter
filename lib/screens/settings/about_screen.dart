import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/constants.dart';
import '../../utils/launch_url.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  void initState() {
    FirebaseAnalytics.instance.logScreenView(
      screenName: 'AboutScreen',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sorugo_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              left: defaultPadding,
              right: defaultPadding,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  const Center(
                    child: GlassmorphicLogo(),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Text(
                    "SoruGO",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w300,
                        shadows: const [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 12,
                          )
                        ]),
                  ),
                  const SizedBox(
                    height: defaultPadding * 3,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultPadding),
                      border: Border.all(
                        color: Colors.white24,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(defaultPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Designed & Developed by",
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Mehmet Sümer",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 21,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  GlassmorphicWidget(
                    child: ListTile(
                      dense: true,
                      leading: const FaIcon(
                        FontAwesomeIcons.envelope,
                        color: Colors.white,
                        size: 21,
                      ),
                      title: Text(
                        "iletisim@sorugo.app",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  GlassmorphicWidget(
                    child: ListTile(
                      dense: true,
                      leading: const FaIcon(
                        FontAwesomeIcons.section,
                        color: Colors.white,
                        size: 21,
                      ),
                      title: Text(
                        "Kullanım Koşulları",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                      trailing: const FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.white,
                        size: 21,
                      ),
                      onTap: () {
                        launchURL("https://sorugo.app/user-agreement");
                      },
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  GlassmorphicWidget(
                    child: ListTile(
                      dense: true,
                      leading: const FaIcon(
                        FontAwesomeIcons.scaleBalanced,
                        color: Colors.white,
                        size: 18,
                      ),
                      title: Text(
                        "Gizlilik Sözleşmesi",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                      trailing: const FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.white,
                        size: 21,
                      ),
                      onTap: () {
                        launchURL("https://sorugo.app/privacy-policy");
                      },
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  GlassmorphicWidget(
                    child: ListTile(
                      dense: true,
                      leading: const FaIcon(FontAwesomeIcons.circleInfo),
                      title: Text(
                        "Lisanslar",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                      ),
                      trailing: const FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.white,
                        size: 21,
                      ),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationVersion: "1.0.0",
                          applicationIcon: ClipRRect(
                            borderRadius: BorderRadius.circular(defaultPadding),
                            child: Image.asset(
                              "assets/images/sorugo_icon.png",
                              height: 70,
                            ),
                          ),
                          applicationLegalese: "2022 SoruGO ©",
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GlassmorphicWidget extends StatelessWidget {
  final Widget child;
  const GlassmorphicWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultPadding),
          border: Border.all(
            color: Colors.white24,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
            ),
          ],
        ),
        child: child);
  }
}

class GlassmorphicLogo extends StatelessWidget {
  const GlassmorphicLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultPadding),
          border: Border.all(
            color: Colors.white24,
            width: 2,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultPadding),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 25,
                spreadRadius: -20,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/images/sorugo_icon.png",
              width: 160,
              height: 160,
            ),
          ),
        ));
  }
}
