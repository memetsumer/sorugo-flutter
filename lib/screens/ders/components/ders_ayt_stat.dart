import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../konu/components/status_konu.dart';
import '/screens/ders/components/status_sleek_item.dart';

class DersAYTStat extends StatelessWidget {
  const DersAYTStat({
    Key? key,
    required this.isAYTNotEmpty,
    required this.isGeometri,
    required this.ayt,
    required this.avgAytNet,
  }) : super(key: key);

  final bool isAYTNotEmpty;
  final bool isGeometri;
  final int ayt;
  final double avgAytNet;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (isAYTNotEmpty && !isGeometri)
          Tooltip(
            message: "AYT konularına ait çözülen toplam soru sayısı.",
            textStyle: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            showDuration: const Duration(seconds: 2),
            child: StatusKonu(
              title: "AYT Toplam",
              value: ayt,
              helpTitle: "AYT Toplam Taramalar",
              helpMessage:
                  "AYT konularına ait çözülen toplam soru sayısını gösterir.\n",
              helpMessage2:
                  'İstediğiniz konuya dokunup tarama ekleyebilirsiniz.',
            ),
          ),
        if (isAYTNotEmpty && !isGeometri)
          Tooltip(
            message:
                "AYT netlerindeki doğru cevap sayısının toplam cevap sayısına oranı.",
            showDuration: const Duration(seconds: 3),
            margin: const EdgeInsets.only(
                left: defaultPadding, right: defaultPadding),
            textStyle: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            child: StatusSleekItem(
                value: avgAytNet,
                topLabel: "AYT",
                bottomLabel: "Ortalama Doğru",
                ccw: true,
                startAngle: 0),
          ),
        if (isGeometri) ...[
          StatusKonu(
            title: "Toplam Çözülen",
            value: ayt,
            helpTitle: "Geometri Toplam Taramalar",
            helpMessage:
                "Geometri dersine ait çözülen toplam soru sayısını gösterir.\n",
            helpMessage2: 'İstediğiniz konuya dokunup tarama ekleyebilirsiniz.',
          ),
          const StatusWarning(
            value: "Geometri üzerinden net eklenmemektedir.",
          ),
        ]
      ],
    );
  }
}
