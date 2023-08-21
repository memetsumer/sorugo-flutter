import 'package:flutter/material.dart';

class FirstTimeProvider extends ChangeNotifier {
  PageController? pageController;

  void setPageController(PageController pageController) {
    this.pageController = pageController;
    notifyListeners();
  }

  void goTerms() {
    pageController!.animateToPage(0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic);
    notifyListeners();
  }

  void goUserNameForm() {
    pageController!.animateToPage(1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutQuint);
    notifyListeners();
  }

  void goChooseExam() {
    pageController!.animateToPage(2,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutQuint);
    notifyListeners();
  }
}
