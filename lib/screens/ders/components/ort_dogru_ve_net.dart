import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../models/adapters/deneme_stat/deneme_stat_adapter.dart';
import '../../../models/adapters/ders/ders_adapter.dart';
import '../../../utils/constants.dart';
import '../../dashboard_screen/netler_stats/deneme_stat_tojson.dart';
import 'compute_ort_dogru.dart';
import 'ders_ayt_stat.dart';
import 'ders_tyt_stat.dart';

class OrtalamaDogruVeNetWidget extends StatelessWidget {
  const OrtalamaDogruVeNetWidget({
    Key? key,
    required this.dersObj,
    required this.type,
    required this.isTYTNotEmpty,
    required this.tyt,
    required this.isAYTNotEmpty,
    required this.isGeometri,
    required this.ayt,
  }) : super(key: key);

  final Ders dersObj;
  final bool isTYTNotEmpty;
  final int tyt;
  final bool isAYTNotEmpty;
  final bool isGeometri;
  final String type;
  final int ayt;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<DenemeStat>(dbDenemelerStat).listenable(),
      builder: (context, Box<DenemeStat> box, widget) {
        var netler = box.values.toList();

        return FutureBuilder(
            future: getOrtalamaDogrular(netler, dersObj.code),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              var ortDogrular = snapshot.data as Map<String, dynamic>;

              final avgTytNet = ortDogrular["avgTytNet"];
              final avgAytNet = ortDogrular["avgAytNet"];

              return Column(
                children: [
                  const SizedBox(height: defaultPadding * 2),
                  if (type == "tyt")
                    DersTYTStat(
                        isTYTNotEmpty: isTYTNotEmpty,
                        tyt: tyt,
                        avgTytNet: avgTytNet),
                  if (type == "ayt")
                    DersAYTStat(
                        isAYTNotEmpty: isAYTNotEmpty,
                        isGeometri: isGeometri,
                        ayt: ayt,
                        avgAytNet: avgAytNet),
                  const SizedBox(height: defaultPadding * 2),
                ],
              );
            }));
      },
    );
  }

  Future<Map<String, dynamic>> getOrtalamaDogrular(
      List<DenemeStat> netler, String dersCode) {
    return compute(computeOrtalamaDogru, {
      "netler": netler.map((e) => denemeStatToJson(e)).toList(),
      "dersCode": dersCode
    });
  }
}
