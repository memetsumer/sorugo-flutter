import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  String? userName = FirebaseAuth.instance.currentUser!.displayName;

  String get getUserName => userName ?? "";

  bool isDrawerOpen = false;

  bool get getIsDrawerOpen => isDrawerOpen;

  final GlobalKey<ScaffoldState> key = GlobalKey();

  //getKey
  GlobalKey<ScaffoldState> get getKey => key;

  void toggleKey() {
    key.currentState!.openEndDrawer();
    notifyListeners();
  }

  Future<void> updateUsername(String name) async {
    await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
    userName = name;
    notifyListeners();
  }
}
