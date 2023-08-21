import 'package:animations/animations.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yks_app/models/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../models/sign_in_methods.dart';
import 'clear_db.dart';
import '../constants.dart';

Future<void> logOut(BuildContext context, bool isPop) async {
  try {
    context.read<AppProvider>().setWait(true);
    if (isPop) {
      Navigator.pop(context);
      Navigator.pop(context);
    }
    EasyLoading.showInfo(
      'Çıkış Yapılıyor...',
      dismissOnTap: false,
    );
    AwesomeNotifications().setGlobalBadgeCounter(0);

    if (FirebaseAuth.instance.currentUser!.providerData[0].providerId ==
        "google.com") {
      GoogleSignInProvider().disconnect();
    }

    FirebaseAnalytics.instance.logEvent(name: "logout");

    clearDb();
    Purchases.logOut();
    FirebaseAuth.instance.signOut();
    EasyLoading.dismiss();
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

Future<void> logOutBeginning(BuildContext context) async {
  await EasyLoading.showInfo(
    'Çıkış Yapılıyor...',
    dismissOnTap: false,
  );

  FirebaseAnalytics.instance.logEvent(name: "error-logout");

  if (FirebaseAuth.instance.currentUser!.providerData[0].providerId ==
      "google.com") {
    GoogleSignInProvider().disconnect();
  }

  FirebaseAuth.instance.signOut();
  await EasyLoading.dismiss();
}

Future<void> logOutTerms(BuildContext context) async {
  FirebaseAnalytics.instance.logEvent(name: "not-accepted-terms-logout");

  if (FirebaseAuth.instance.currentUser!.providerData[0].providerId ==
      "google.com") {
    GoogleSignInProvider().disconnect();
  }

  FirebaseAuth.instance.signOut();
}

Future<void> showLogOutDialog(context) async {
  return await showModal(
    configuration: const FadeScaleTransitionConfiguration(
      transitionDuration: Duration(milliseconds: 300),
      reverseTransitionDuration: Duration(milliseconds: 300),
    ),
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: darkBackgroundColorSecondary,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24))),
      title: Text('Çıkış Yapmayı Onaylıyor musun?',
          style:
              Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 15)),
      actions: [
        TextButton(
          child: Text(
            'İptal',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.blueAccent),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: Text(
            'Çıkış Yap',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.red),
          ),
          onPressed: () {
            logOut(context, true);
          },
        ),
      ],
    ),
  );
}
