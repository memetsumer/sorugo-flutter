import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../iap/iap.dart';

void getPlans(BuildContext context, bool mounted) async {
  HapticFeedback.heavyImpact();

  final list = await PurchaseApi.fetchOffers(context);

  if (!mounted) return;
  if (list.isNotEmpty) {
    showPlans(context, list[0], false);
  }
}

void premiumFunction(
  BuildContext context,
  bool mounted,
  Function func,
) async {
  bool isMvp = context.read<IAPManager>().getMvpOffer;
  !context.read<IAPManager>().isExpired || isMvp
      ? func()
      : getPlans(context, mounted);
}

Future<bool> checkMvpOffer() async {
  var res = await FirebaseFirestore.instance
      .collection('offers')
      .doc('mvp_offer')
      .get();

  if (res.exists) {
    var data = res.data();

    if (data != null) {
      if (data['free']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
  return false;
}
