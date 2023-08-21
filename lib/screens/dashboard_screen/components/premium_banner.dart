import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../iap/entitlement.dart';
import '../../../iap/iap_manager.dart';
import '../../../utils/constants.dart';
import '../../components/premium_button.dart';

class PremiumBanner extends StatelessWidget {
  final String? message;
  final String? buttonMessage;
  final bool padding;
  final bool cardMargin;
  const PremiumBanner({
    Key? key,
    required this.padding,
    required this.cardMargin,
    this.buttonMessage,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !context.read<IAPManager>().getMvpOffer
        ? Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.black, sorugoColorSecondary]),
              borderRadius: BorderRadius.circular(defaultPadding),
              border: Border.all(
                color: Colors.white24,
                width: 1,
              ),
            ),
            child: ListTile(
              dense: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  defaultPadding,
                ),
              ),
              onTap: () {},
              title: Text(
                message ?? "Hemen Premium'a geç!",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                    ),
              ),
              subtitle:
                  context.watch<IAPManager>().getEntitlement != Entitlement.free
                      ? null
                      : Text(
                          "Son ${context.read<IAPManager>().getDays} günlük hakkın kaldı",
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
              trailing: PremiumButton(
                message: buttonMessage,
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
