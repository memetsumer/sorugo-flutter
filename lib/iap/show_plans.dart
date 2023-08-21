import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as mbs;

import '/iap/paywall.dart';

Future<dynamic> showPlans(BuildContext context, plans, bool isExpired) {
  return mbs.showCupertinoModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
    ),
    barrierColor: Colors.black.withOpacity(0.5),
    context: context,
    builder: (context) => Paywall(
      offering: plans,
      isExpired: isExpired,
    ),
  );
}
