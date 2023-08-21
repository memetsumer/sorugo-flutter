import 'package:flutter/material.dart';

import '/utils/constants.dart';

class SnackbarMessage {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackbar(String? text, Color color) {
    if (text == null) return;

    final snackbar = SnackBar(
      content: Text(text),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(defaultPadding))),
      behavior: SnackBarBehavior.floating,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}
