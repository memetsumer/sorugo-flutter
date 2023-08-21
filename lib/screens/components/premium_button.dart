import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../iap/purchase_api.dart';
import '../../iap/show_plans.dart';
import '../../utils/constants.dart';

class PremiumButton extends StatefulWidget {
  final Color color1;
  final Color color2;
  final String? message;

  const PremiumButton({
    Key? key,
    this.color1 = Colors.cyan,
    this.color2 = Colors.greenAccent,
    this.message,
  }) : super(key: key);
  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        HapticFeedback.heavyImpact();
        PurchaseApi.fetchOffers(context).then((list) {
          if (list.isNotEmpty) {
            showPlans(context, list[0], false);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding / 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
              colors: [
                widget.color1,
                widget.color2,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: widget.color1.withOpacity(0.6),
                spreadRadius: 1,
                blurRadius: 16,
                offset: const Offset(-8, 0),
              ),
              BoxShadow(
                color: widget.color2.withOpacity(0.6),
                spreadRadius: 1,
                blurRadius: 16,
                offset: const Offset(8, 0),
              ),
            ]),
        child: Text(
          widget.message ?? "Yükselt!",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
