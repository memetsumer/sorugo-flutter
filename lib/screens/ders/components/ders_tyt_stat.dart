import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../konu/components/status_konu.dart';
import 'status_sleek_item.dart';

class DersTYTStat extends StatelessWidget {
  const DersTYTStat({
    Key? key,
    required this.isTYTNotEmpty,
    required this.tyt,
    required this.avgTytNet,
  }) : super(key: key);

  final bool isTYTNotEmpty;
  final int tyt;
  final double avgTytNet;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (isTYTNotEmpty)
          Tooltip(
            message: "TYT konularına ait çözülen toplam soru sayısı.",
            textStyle: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            showDuration: const Duration(seconds: 2),
            child: StatusKonu(
              title: "TYT Toplam",
              value: tyt,
              helpTitle: "TYT Toplam Taramalar",
              helpMessage:
                  "TYT konularına ait çözülen toplam soru sayısını gösterir.\n",
              helpMessage2:
                  'İstediğiniz konuya dokunup tarama ekleyebilirsiniz.',
            ),
          ),
        if (isTYTNotEmpty)
          Tooltip(
            message:
                "TYT netlerindeki doğru cevap sayısının toplam cevap sayısına oranı.",
            showDuration: const Duration(seconds: 3),
            margin: const EdgeInsets.only(
                left: defaultPadding, right: defaultPadding),
            textStyle: const TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
            child: StatusSleekItem(
                value: avgTytNet,
                topLabel: "TYT",
                bottomLabel: "Ortalama Doğru",
                ccw: false,
                startAngle: 180),
          ),
      ],
    );
  }
}
