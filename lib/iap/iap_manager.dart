import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_yks_app/utils/constants.dart';
import 'package:flutter_yks_app/utils/premium_function.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'entitlement.dart';

class IAPManager extends ChangeNotifier {
  Entitlement _entitlement = Entitlement.free;

  int days = 7 -
      DateTime.now()
          .difference(FirebaseAuth.instance.currentUser!.metadata.creationTime!)
          .inDays;

  Entitlement get getEntitlement => _entitlement;

  bool mvpOffer = false;

  bool get getMvpOffer => mvpOffer;

  int get getDays => max(days, 0);
  bool get isExpired =>
      (days <= 0) && _entitlement == Entitlement.free ? true : false;

  Future init() async {
    await Purchases.logIn(FirebaseAuth.instance.currentUser!.uid);
    CustomerInfo info = await Purchases.getCustomerInfo();
    final entitlements = info.entitlements.active.values.toList();

    _entitlement = entitlements.isEmpty
        ? Entitlement.free
        : entitlements.first.productIdentifier == subscriptionMonthly
            ? Entitlement.monthly
            : Entitlement.threeMonthly;

    notifyListeners();
  }

  Future updatePurchaseStatus() async {
    final purchaserInfo = await Purchases.getCustomerInfo();

    final entitlements = purchaserInfo.entitlements.active.values.toList();

    if (kDebugMode) {
      print("ENTITLEMENTS ARE");
      print(entitlements);
    }

    _entitlement =
        entitlements.isEmpty ? Entitlement.free : Entitlement.threeMonthly;

    notifyListeners();
  }

  Future<void> isMvpOfferValid(VoidCallback func) async {
    var res = await checkMvpOffer();

    if (res) {
      mvpOffer = true;

      bool isShown =
          Hive.box(dbSettings).get(dbMvpOfferShown, defaultValue: false);

      if (!isShown) {
        func();
        Hive.box(dbSettings).put(dbMvpOfferShown, true);
      }
    } else {
      mvpOffer = false;
    }

    notifyListeners();
  }

  void setMvpOffer(bool val) {
    mvpOffer = val;

    notifyListeners();
  }
}
