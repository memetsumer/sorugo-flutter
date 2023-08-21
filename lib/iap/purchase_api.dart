import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '/utils/snackbar_message.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PurchaseApi {
  static Future initPlatformState() async {
    if (kDebugMode) {
      await Purchases.setLogLevel(LogLevel.error);
    }

    if (Platform.isAndroid) {
      await Purchases.configure(
          PurchasesConfiguration(dotenv.env['APPLE_RC_API_KEY']!));
    } else if (Platform.isIOS) {
      await Purchases.configure(
          PurchasesConfiguration(dotenv.env['GOOGLE_RC_API_KEY']!));
    }
  }

  static Future purchasePackage(Package package) async {
    try {
      await EasyLoading.showInfo('Yükleniyor...', dismissOnTap: true);
      await Purchases.purchasePackage(package);
      await EasyLoading.dismiss();
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        if (kDebugMode) {
          print(e);
        }
        SnackbarMessage.showSnackbar(e.toString(), Colors.redAccent);
      }
    }
  }

  static Future<List<Offering>> fetchOffers(context) async {
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;
      if (current != null && current.availablePackages.isNotEmpty) {
        return [current];
      }

      return [];
    } on PlatformException catch (e) {
      if (e.code == "10") {
        SnackbarMessage.showSnackbar(
            "İnternet bağlantısı yok.", Colors.redAccent);
      }
      return [];
    } catch (e) {
      SnackbarMessage.showSnackbar(
          "Abonelikler yüklenemedi.", Colors.redAccent);
      return [];
    }
  }
}
