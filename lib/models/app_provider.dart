import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  final PageController pageController = PageController(initialPage: 0);

  bool firstTime = false;
  bool wait = false;

  bool get getFirstTime => firstTime;
  bool get getWait => wait;

  void setWait(bool value) {
    wait = value;
    notifyListeners();
  }

  void setFirstTime(bool value) {
    firstTime = value;
    notifyListeners();
  }

  void goRegister() {
    pageController.animateToPage(1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutQuint);
    notifyListeners();
  }

  void goOnboarding() {
    pageController.animateToPage(0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic);
    notifyListeners();
  }
}
