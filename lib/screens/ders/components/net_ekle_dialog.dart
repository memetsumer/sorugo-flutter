import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../../../models/adapters/ders/ders_adapter.dart';
import '../../../utils/constants.dart';
import 'yeni_net_ekle_widget.dart';

class NetEkleDialog extends StatelessWidget {
  final Ders ders;
  const NetEkleDialog({
    Key? key,
    required this.ders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: darkBackgroundColorSecondary,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24))),
      content: Container(
        constraints: const BoxConstraints(
            // maxHeight: 300,
            ),
        child: Wrap(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Text(
                  "Hızlı Net Ekle",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            YeniNetEkle(ders: ders),
          ],
        ),
      ),
    );
  }
}

Future<void> netEkle(
  BuildContext context,
  Ders ders,
  bool isAytNotEmpty,
) async {
  return await showModal(
    configuration: const FadeScaleTransitionConfiguration(
      transitionDuration: Duration(milliseconds: 300),
      reverseTransitionDuration: Duration(milliseconds: 300),
    ),
    context: context,
    builder: (context) => NetEkleDialog(
      ders: ders,
    ),
  );
}
