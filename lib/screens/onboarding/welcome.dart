import 'package:flutter/material.dart';
import 'package:flutter_yks_app/models/app_provider.dart';
import 'package:flutter_yks_app/screens/login_register_forgot/register_screen_social.dart';
import 'package:flutter_yks_app/screens/onboarding/onboarding.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<Widget> pages = const [
    Onboarding(),
    RegisterScreenSocial(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgPath),
            fit: BoxFit.cover,
          ),
        ),
        child: PageView.builder(
          controller: context.read<AppProvider>().pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return pages[index];
          },
        ),
      ),
    );
  }
}
