import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../models/adapters/ders/ders_adapter.dart';
import '../../../models/adapters/tarama/tarama_adapter.dart';
import '../../../utils/constants.dart';
import 'ort_dogru_ve_net.dart';

class DersStatsWidget extends StatelessWidget {
  final Ders dersObj;
  final bool isTYTNotEmpty;
  final bool isAYTNotEmpty;
  final String type;

  const DersStatsWidget({
    Key? key,
    required this.dersObj,
    required this.isAYTNotEmpty,
    required this.isTYTNotEmpty,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isGeometri = dersObj.code == "geometri";
    return ValueListenableBuilder(
      valueListenable: Hive.box<Tarama>(dbTaramalar).listenable(),
      builder: (context, Box<Tarama> box, widget) {
        var listTotal =
            box.values.toList().where((e) => e.ders == dersObj.name).toList();
        var ayt = 0;
        var tyt = 0;

        var aytList = [];
        var tytList = [];

        if (type == "tyt") {
          tytList =
              listTotal.where((e) => e.kind.toLowerCase() == "tyt").toList();
          if (tytList.isNotEmpty) {
            tyt = tytList
                .map((e) => e.count)
                .reduce((value, element) => value + element);
          }
        }

        if (type == "ayt") {
          aytList =
              listTotal.where((e) => e.kind.toLowerCase() == "ayt").toList();
          if (aytList.isNotEmpty) {
            ayt = aytList
                .map((e) => e.count)
                .reduce((value, element) => value + element);
          }
        }

        return OrtalamaDogruVeNetWidget(
          dersObj: dersObj,
          isTYTNotEmpty: isTYTNotEmpty,
          tyt: tyt,
          isAYTNotEmpty: isAYTNotEmpty,
          isGeometri: isGeometri,
          ayt: ayt,
          type: type,
        );
      },
    );
  }
}
