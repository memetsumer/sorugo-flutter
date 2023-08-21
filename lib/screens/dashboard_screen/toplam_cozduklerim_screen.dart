import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yks_app/screens/stats_taramalar/components/ders_tarama_toplam_taramalar.dart';
import '../stats_taramalar/components/compute_taramalar_toplam.dart';
import '../stats_taramalar/stats_detail_screen.dart';

import 'package:hive_flutter/hive_flutter.dart';

import '../../models/adapters/tarama/tarama_adapter.dart';
import '../../utils/constants.dart';
import 'components/charts.dart';
import 'components/status_card.dart';

class ToplamCozduklerimScreen extends StatefulWidget {
  const ToplamCozduklerimScreen({Key? key}) : super(key: key);

  @override
  State<ToplamCozduklerimScreen> createState() =>
      _ToplamCozduklerimScreenState();
}

class _ToplamCozduklerimScreenState extends State<ToplamCozduklerimScreen> {
  @override
  void initState() {
    FirebaseAnalytics.instance.logScreenView(
      screenName: 'ToplamCozduklerimScreen',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Toplam Taramalar",
            style: Theme.of(context).textTheme.titleLarge),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Tarama>(dbTaramalar).listenable(),
        builder: (context, Box<Tarama> box, widget) {
          final now = DateTime.now();

          var totalTaramalarDayLength = (DateTime.now()
                          .difference(FirebaseAuth
                              .instance.currentUser!.metadata.creationTime!)
                          .inHours /
                      24)
                  .ceil() +
              2;

          final taramalar = box.values.toList();

          return FutureBuilder(
            future: getTaramalarToplam({
              'taramalar': taramalar.map((e) => taramaToJson(e)).toList(),
              'totalTaramalarDayLength': totalTaramalarDayLength,
              'now': now,
            }),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final data = snapshot.data as Map<String, dynamic>;

              final maxY = data["maxY"] as int;

              final sumAytTotal = data["sumAytTotal"] as int;
              final sumTytTotal = data["sumTytTotal"] as int;
              final int? sumGeometriTotal = data["sumGeometriTotal"] ?? 0;

              final aytTotals = data["aytTotal"] as Map<String, dynamic>;
              final tytTotals = data["tytTotal"] as Map<String, dynamic>;

              final totalTaramalarSinceBegin = data["totalTaramalarSinceBegin"]
                  as List<Map<String, dynamic>>;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildTitle(context, totalTaramalarSinceBegin, maxY,
                        totalTaramalarDayLength),
                    TaramalarChart(
                      showDetails: false,
                      data: totalTaramalarSinceBegin,
                      length: totalTaramalarDayLength,
                      maxData: maxY,
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: darkGradientPurple.withOpacity(0.8),
                                blurRadius: 30,
                              ),
                            ],
                          ),
                          child: StatusCard(
                            message: "AYT",
                            maxWidth: 100,
                            data: sumAytTotal.toString(),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: darkGradientPurple.withOpacity(0.8),
                                blurRadius: 30,
                              ),
                            ],
                          ),
                          child: StatusCard(
                            message: "TYT",
                            maxWidth: 100,
                            data: sumTytTotal.toString(),
                          ),
                        ),
                        if (sumGeometriTotal != 0)
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: darkGradientPurple.withOpacity(0.8),
                                  blurRadius: 30,
                                ),
                              ],
                            ),
                            child: StatusCard(
                              message: "Geometri",
                              maxWidth: 100,
                              data: sumGeometriTotal.toString(),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    if (aytTotals.isNotEmpty)
                      DersTaramaToplamTaramalarWidget(
                        title: "AYT Derslerin",
                        data: aytTotals,
                      ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                    if (tytTotals.isNotEmpty)
                      DersTaramaToplamTaramalarWidget(
                        title: "TYT Derslerin",
                        data: tytTotals,
                      ),
                    const SizedBox(
                      height: defaultPadding,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Padding buildTitle(
      BuildContext context,
      List<Map<String, dynamic>> totalTaramalarSinceBegin,
      int maxY,
      int totalTaramalarDayLength) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        children: [
          const Text(
            "Üyelik Tarihinden İtibaren Taramaların",
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            width: defaultPadding / 2,
          ),
          TextButton(
            child: Text(
              "İncele",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.blueAccent),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StatsDetailScreen(
                    data: totalTaramalarSinceBegin,
                    maxData: maxY,
                    length: totalTaramalarDayLength,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> getTaramalarToplam(Map<String, dynamic> data) {
    return compute(
      computeTaramalarToplam,
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
