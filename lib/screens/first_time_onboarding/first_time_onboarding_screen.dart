import 'package:flutter/material.dart';
import 'package:flutter_yks_app/models/first_time_provider.dart';
import 'package:flutter_yks_app/screens/first_time_onboarding/pages/terms_screen.dart';
import 'package:flutter_yks_app/screens/onboarding/choose_exam_screen.dart';
import 'package:flutter_yks_app/screens/onboarding/set_username_screen.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class FirstTimeOnboardingScreen extends StatefulWidget {
  const FirstTimeOnboardingScreen({Key? key}) : super(key: key);

  @override
  State<FirstTimeOnboardingScreen> createState() =>
      _FirstTimeOnboardingScreenState();
}

class _FirstTimeOnboardingScreenState extends State<FirstTimeOnboardingScreen> {
  List<Widget> pages = const [
    TermsScreen(),
    UserNameForm(),
    ChooseExamScreen(),
  ];

  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        context.read<FirstTimeProvider>().setPageController(pageController);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

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
          controller: pageController,
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
