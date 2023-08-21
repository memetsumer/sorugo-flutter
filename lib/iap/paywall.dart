import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_yks_app/iap/purchase_api.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/utils/constants.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class Paywall extends StatefulWidget {
  final Offering offering;
  final bool isExpired;

  const Paywall({
    Key? key,
    required this.offering,
    required this.isExpired,
  }) : super(key: key);

  @override
  State<Paywall> createState() => _PaywallState();
}

class _PaywallState extends State<Paywall> {
  @override
  Widget build(BuildContext context) {
    List<Package> packages = widget.offering.availablePackages;

    int discount = packages.length >= 2
        ? (packages[0].storeProduct.price /
                packages[1].storeProduct.price *
                100)
            .toInt()
        : 0;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 0, 9, 29),
            Color.fromARGB(255, 0, 9, 29),
            Color.fromARGB(255, 0, 44, 46),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: defaultPadding,
          horizontal: defaultPadding,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "SoruGO Premium",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    shadows: [
                      BoxShadow(color: Colors.white, blurRadius: 12),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const Spacer(),
            const PaywallListItem(
              message: "Önemli sorularını kaydet.",
            ),
            const PaywallListItem(
              message: "Notlarını asla kaybetme!",
            ),
            const PaywallListItem(
              message: "Netlerinin durumunu takip et.",
            ),
            const PaywallListItem(
              message: "Her dersten kaç soru çözdüğünü gör.",
            ),
            const PaywallListItem(
                message: "Başarın elindeki verilerle olacak!",
                icon: FontAwesomeIcons.solidStar),
            const Spacer(),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(
                defaultPadding,
              ),
              itemCount: packages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: defaultPadding * 2,
                mainAxisSpacing: defaultPadding * 2,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final package = packages[index];
                return SoruGOEntitlement(
                  widget: widget,
                  package: package,
                  index: index,
                );
              },
            ),
            const Spacer(),
            if (packages.length >= 2)
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: "${packages[1].storeProduct.title} al ve ",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                        shadows: const [
                          Shadow(
                            color: Colors.teal,
                            blurRadius: 20,
                          ),
                        ],
                      ),
                    ),
                    TextSpan(
                      text: "%$discount ",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 18,
                        color: Colors.white,
                        shadows: const [
                          Shadow(
                            color: Colors.teal,
                            blurRadius: 20,
                          ),
                        ],
                      ),
                    ),
                    TextSpan(
                      text: "daha az öde.",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 14,
                        color: Colors.white,
                        shadows: const [
                          Shadow(
                            color: Colors.teal,
                            blurRadius: 20,
                          ),
                        ],
                      ),
                    ),
                  ])),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class SoruGOEntitlement extends StatelessWidget {
  const SoruGOEntitlement({
    Key? key,
    required this.widget,
    required this.package,
    required this.index,
  }) : super(key: key);

  final Paywall widget;
  final Package package;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 130,
        maxHeight: 130,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultPadding),
        border: Border.all(
          color: index % 2 == 0
              ? const Color.fromARGB(255, 255, 136, 245)
              : const Color.fromARGB(255, 0, 225, 255),
          width: 1,
        ),
        boxShadow: index % 2 == 1
            ? const [
                BoxShadow(
                  color: Colors.cyan,
                  offset: Offset(0, 0),
                  blurRadius: 6,
                  spreadRadius: 0,
                  inset: true,
                ),
                BoxShadow(
                  color: Color.fromARGB(255, 0, 0, 0),
                  offset: Offset(0, 0),
                  blurRadius: 3,
                  spreadRadius: 0,
                  inset: true,
                ),
              ]
            : const [
                BoxShadow(
                  color: Color.fromARGB(255, 255, 35, 237),
                  offset: Offset(0, 0),
                  blurRadius: 6,
                  spreadRadius: 0,
                  inset: true,
                ),
                BoxShadow(
                  color: Color.fromARGB(255, 0, 0, 0),
                  offset: Offset(0, 0),
                  blurRadius: 3,
                  spreadRadius: 0,
                  inset: true,
                ),
              ],
      ),
      child: ElevatedButton(
        onPressed: () async {
          try {
            await PurchaseApi.purchasePackage(
                widget.offering.availablePackages[index]);
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          }
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(defaultPadding),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: darkGradientPurple,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultPadding)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: defaultPadding),
            Text(
              Platform.isIOS
                  ? package.storeProduct.title
                  : package.storeProduct.title.replaceAll("(SoruGO)", ""),
              // package.storeProduct.title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 16,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: index % 2 == 1
                        ? Colors.teal
                        : const Color.fromARGB(255, 208, 0, 255),
                    blurRadius: 20,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Center(
              child: Text(
                package.storeProduct.priceString,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 25,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: index % 2 == 1
                          ? Colors.teal
                          : const Color.fromARGB(255, 208, 0, 255),
                      blurRadius: 20,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class PaywallListItem extends StatelessWidget {
  final String message;
  final IconData? icon;
  const PaywallListItem({
    Key? key,
    required this.message,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: FaIcon(
        icon ?? FontAwesomeIcons.check,
        color: Colors.greenAccent,
      ),
      title: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
