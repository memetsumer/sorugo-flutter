import 'package:animations/animations.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yks_app/utils/account/clear_db.dart';

import '../../../models/sign_in_methods.dart';

import '../../../utils/snackbar_message.dart';
import '../constants.dart';

Future<void> deleteAccount(BuildContext context) async {
  try {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    EasyLoading.showInfo('Hesap Siliniyor...', dismissOnTap: false);

    if (FirebaseAuth.instance.currentUser!.providerData[0].providerId ==
        "google.com") {
      await GoogleSignInProvider().disconnect();
    }

    await FirebaseAuth.instance.currentUser!.delete();

    AwesomeNotifications().setGlobalBadgeCounter(0);

    FirebaseAnalytics.instance.logEvent(
      name: "delete_account",
    );

    clearDb();

    EasyLoading.dismiss();
  } on PlatformException catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
    SnackbarMessage.showSnackbar(
        "Bilinmeyen bir hata oluştu.", Colors.redAccent);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'requires-recent-login') {
      SnackbarMessage.showSnackbar(
          "Hesabınızı silmek için yeniden giriş yapmalısınız.",
          Colors.redAccent);
    } else {
      SnackbarMessage.showSnackbar(e.message, Colors.redAccent);
    }
  } catch (e) {
    SnackbarMessage.showSnackbar(
        "Hesap Silinirken Bir Hata Oluştu. $e", Colors.redAccent);
  }
}

Future<void> deleteAccountDialog(context) {
  return showModal(
    configuration: const FadeScaleTransitionConfiguration(
      transitionDuration: Duration(milliseconds: 300),
      reverseTransitionDuration: Duration(milliseconds: 300),
    ),
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: darkBackgroundColorSecondary,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24))),
      title: Text('Hesabını silmek istediğine emin misin?',
          style: Theme.of(context).textTheme.titleMedium),
      content: Wrap(
        children: [
          Text(
            "Hesabını sildikten sonra tüm verilerin de silinir.",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.amber,
                ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text(
            'İptal',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.blueAccent),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text('Hesabı Sil',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.red)),
          onPressed: () {
            deleteAccount(context);
          },
        ),
      ],
    ),
  );
}
