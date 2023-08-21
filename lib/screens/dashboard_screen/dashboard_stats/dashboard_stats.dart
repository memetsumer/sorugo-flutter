import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yks_app/screens/dashboard_screen/components/status_card.dart';
import 'package:flutter_yks_app/screens/dashboard_screen/dashboard_stats/compute_dashboard_stats.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../models/adapters/deneme_stat/deneme_stat_adapter.dart';
import '../../../utils/constants.dart';
import '../netler_stats/deneme_stat_tojson.dart';

class DashboardStats extends StatelessWidget {
  const DashboardStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<DenemeStat>(dbDenemelerStat).listenable(),
        builder: (context, Box<DenemeStat> box, widget) {
          List<DenemeStat> netler = box.values.toList();

          return FutureBuilder(
              future: getDashboardNetler(netler),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final snapshotData = snapshot.data as Map<String, dynamic>;

                final aytOrt = snapshotData['aytOrt'];
                final tytOrt = snapshotData['tytOrt'];

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: darkGradientPurple.withOpacity(0.6),
                            blurRadius: 60,
                          ),
                        ],
                      ),
                      child: StatusCard(
                        message: "Ortalama AYT Net",
                        data: aytOrt.toStringAsFixed(2),
                      ),
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: darkGradientPurple.withOpacity(0.6),
                            blurRadius: 60,
                          ),
                        ],
                      ),
                      child: StatusCard(
                        message: "Ortalama TYT Net",
                        data: tytOrt.toStringAsFixed(2),
                      ),
                    ),
                  ],
                );
              }));
        });
  }

  Future<Map<String, dynamic>> getDashboardNetler(List<DenemeStat> netler) {
    return compute(
      computeNetlerDashboard,
      netler.map((e) => denemeStatToJson(e)).toList(),
    );
  }
}
