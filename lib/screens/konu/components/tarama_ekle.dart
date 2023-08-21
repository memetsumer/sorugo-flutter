import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:flutter_yks_app/network/tarama/tarama_item_api.dart';
import 'package:flutter_yks_app/network/tarama/tarama_item_dao.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/utils/snackbar_message.dart';
import '../../../models/adapters/tarama/tarama_adapter.dart';
import '/network/user/user_dao.dart';
import '/utils/constants.dart';

class TaramaEkle extends StatefulWidget {
  final Map<String, String> konu;
  final String dersCode;
  final String ders;
  const TaramaEkle({
    Key? key,
    required this.konu,
    required this.dersCode,
    required this.ders,
  }) : super(key: key);

  @override
  State<TaramaEkle> createState() => _TaramaEkleState();
}

class _TaramaEkleState extends State<TaramaEkle> {
  int solvedSoru = 0;
  bool isButtonActive = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: SpinBox(
            incrementIcon: const Icon(
              Icons.add,
              size: 40,
            ),
            decrementIcon: const Icon(
              Icons.remove,
              size: 40,
            ),
            readOnly: true,
            showCursor: false,
            onChanged: (double x) {
              HapticFeedback.lightImpact();

              setState(() {
                solvedSoru = x.toInt();
              });
            },
            spacing: 2,
            min: 0,
            max: 200,
            decimals: 0,
            value: solvedSoru.toDouble(),
            step: 1,
            acceleration: 1,
            textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 40,
                  // fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Row(
          children: [
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "İptal",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.redAccent,
                    ),
              ),
            ),
            TextButton(
              onPressed: isButtonActive
                  ? () async {
                      await taramaEkle(context);
                    }
                  : () {},
              child: Text(
                "Kaydet",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.blueAccent,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> taramaEkle(BuildContext context) async {
    try {
      final now = DateTime.now();
      setState(() {
        isButtonActive = false;
      });
      if (solvedSoru > 0) {
        UserDao().incrementSolvedSoru(solvedSoru);

        FirebaseAnalytics.instance.logEvent(
          name: "save_deneme",
          parameters: {
            "ders": widget.ders,
            "ayt": widget.konu["kind"]!,
            "count": solvedSoru,
          },
        );

        TaramaDao().saveTarama(
          APITaramaItem(
            ders: widget.ders,
            dersCode: widget.dersCode,
            konu: widget.konu["name"]!,
            count: solvedSoru,
            createdAt: now,
            kind: widget.konu["kind"]!,
          ),
        );

        Hive.box<Tarama>(dbTaramalar).add(
          Tarama(
            ders: widget.ders,
            dersCode: widget.dersCode,
            konu: widget.konu["name"]!,
            count: solvedSoru,
            createdAt: now,
            kind: widget.konu["kind"]!,
          ),
        );
        if (!mounted) return;
        Navigator.pop(context);

        setState(() {
          solvedSoru = 0;
        });
        HapticFeedback.heavyImpact();

        SnackbarMessage.showSnackbar(
            "Tarama Başarıyla Kaydedildi!", Colors.greenAccent);
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            isButtonActive = true;
          });
        });
        Navigator.pop(context);

        SnackbarMessage.showSnackbar(
            "Sıfır'dan fazla bir değer giriniz :) ", Colors.redAccent);
      }
    } catch (e) {
      SnackbarMessage.showSnackbar(
          "Tarama Kaydederken Bir Hata Oluştu! $e", Colors.redAccent);
    }
  }
}
