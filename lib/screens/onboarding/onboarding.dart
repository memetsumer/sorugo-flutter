import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yks_app/models/app_provider.dart';

import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '/utils/constants.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late PageController pageController;
  late int currentIndex;
  late Timer timer;

  final pages = const [
    OnboardingPageView(
        imageProvider: AssetImage('assets/images/soru.png'),
        text:
            "Sınavda kesin çıkar dediğin soruları kaydet, post-it'lerden kurtul!"),
    OnboardingPageView(
      imageProvider: AssetImage('assets/images/deneme.png'),
      text: 'Çözdüğün denemeleri ve netleri gir, durumunu incele!',
    ),
    OnboardingPageView(
        imageProvider: AssetImage('assets/images/stat.png'),
        text: 'İstatistiklerine bakarak çalışma stratejini geliştir!'),
  ];

  @override
  void initState() {
    pageController = PageController();
    currentIndex = 0;

    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentIndex < 2) {
        currentIndex++;

        pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      } else if (currentIndex == 2) {
        currentIndex = 0;
        pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        Theme.of(context).brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark);

    return SafeArea(
      child: Column(
        children: [
          Expanded(
              child: PageView(
            controller: pageController,
            onPageChanged: (int idx) {
              setState(() {
                currentIndex = idx;
              });
            },
            children: pages,
          )),
          buildIndicator(context),
          Padding(
              padding: const EdgeInsets.only(
                  top: defaultPadding * 2, bottom: defaultPadding * 2),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 44),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultPadding),
                  ),
                ),
                onPressed: () {
                  context.read<AppProvider>().goRegister();
                },
                child: Text(
                  "Hemen Başla!",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.black, fontSize: 19),
                ),
              )),
        ],
      ),
    );
  }

  Widget buildIndicator(context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: 3,
      effect: WormEffect(
        activeDotColor: Colors.white,
        dotColor: Colors.white.withOpacity(0.2),
      ),
    );
  }
}

class OnboardingPageView extends StatefulWidget {
  final ImageProvider imageProvider;
  final String text;
  const OnboardingPageView({
    Key? key,
    required this.imageProvider,
    required this.text,
  }) : super(key: key);

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              fit: BoxFit.fitWidth,
              image: widget.imageProvider,
            ),
          ),
          const SizedBox(height: defaultPadding),
          Text(
            widget.text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                  color: Colors.white,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
