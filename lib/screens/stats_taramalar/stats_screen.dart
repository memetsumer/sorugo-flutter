import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import '../../models/adapters/tarama/tarama_adapter.dart';
import '../../utils/constants.dart';
import '../dashboard_screen/components/charts.dart';
import '../dashboard_screen/toplam_cozduklerim_screen.dart';
import 'components/compute_taramalar.dart';
import 'components/last_3_day_carousel.dart';
import 'components/taramalar_chart_label.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Tarama Durumu",
            style: Theme.of(context).textTheme.titleLarge),
        centerTitle: false,
        actions: [
          TextButton(
            child: Text(
              "Hepsini Gör",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.blueAccent),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ToplamCozduklerimScreen(),
                ),
              );
            },
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Tarama>(dbTaramalar).listenable(),
        builder: (context, Box<Tarama> box, widget) {
          final taramalar = box.values.toList();
          return FutureBuilder(
              future: getTaramalar({
                "taramalar": taramalar.map((e) => taramaToJson(e)).toList(),
              }),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final data = snapshot.data as Map<String, dynamic>;

                final maxY = data["maxY"] as int;
                final lengthOfChart = data["lengthOfChart"] as int;
                final last3DayData =
                    data["last3DayData"] as List<Map<String, dynamic>>;
                final last30DayData =
                    data["last30DayData"] as List<Map<String, dynamic>>;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Last3DayCarouselWidget(
                      data: last3DayData,
                    ),
                    const Spacer(),
                    TaramalarChartLabel(
                      showDetails: false,
                      maxData: maxY,
                      length: lengthOfChart,
                      data: last30DayData,
                    ),
                    TaramalarChart(
                      showDetails: false,
                      maxData: maxY,
                      length: lengthOfChart,
                      data: last30DayData,
                    ),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                  ],
                );
              });
        },
      ),
    );
  }

  Future<Map<String, dynamic>> getTaramalar(Map<String, dynamic> data) {
    return compute(
      computeTaramalar,
      data,
    );
  }

  Map<String, dynamic> taramaToJson(Tarama tarama) {
    return {
      "count": tarama.count,
      "createdAt": tarama.createdAt,
      "ders": tarama.ders,
      "dersCode": tarama.dersCode,
      "kind": tarama.kind,
      "konu": tarama.konu,
    };
  }
}
