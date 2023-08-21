import 'package:animate_do/animate_do.dart';
import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '/models/adapters/deneme_stat/deneme_stat_adapter.dart';
import '../../../utils/constants.dart';
import '../../stats_taramalar/stats_detail_screen.dart';
import '../components/charts.dart';
import 'compute_netler_chart.dart';
import 'deneme_stat_tojson.dart';
import 'dropdown_menu_netler.dart';
import 'empty_netler.dart';
import '../../../utils/help_dialog.dart';

class NetlerStat extends StatefulWidget {
  const NetlerStat({Key? key}) : super(key: key);

  @override
  State<NetlerStat> createState() => _NetlerStatState();
}

class _NetlerStatState extends State<NetlerStat> {
  String? selectedItem = "-";
  String? selectedDersName = "-";
  String? selectedDersCode = "-";

  @override
  void initState() {
    final values = Hive.box<DenemeStat>(dbDenemelerStat).values;
    if (values.isNotEmpty) {
      final first = values.first;

      setState(() {
        selectedItem = "${first.dersName} ${first.ayt ? 'AYT' : 'TYT'}";
        selectedDersCode = first.ayt ? 'ayt' : 'tyt';
        selectedDersName = first.dersName;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isBig = MediaQuery.of(context).size.height > 700;

    return ValueListenableBuilder(
      valueListenable: Hive.box<DenemeStat>(dbDenemelerStat).listenable(),
      builder: (context, Box<DenemeStat> box, widget) {
        final netler = box.values.toList();

        return FutureBuilder(
          future: getNetler(netler),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData) {
              final snapshotData = snapshot.data as Map<String, dynamic>;

              final categories =
                  snapshotData["categories"] as Map<String, dynamic>;
              final daysSinceFirst = snapshotData["daysSinceFirst"] as int;
              final maxY = snapshotData["maxY"] as double;
              final List<Map<String, dynamic>> data =
                  snapshotData["data"] as List<Map<String, dynamic>>;
              final length = snapshotData["length"];

              return Wrap(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: defaultPadding,
                      ),
                      const Text(
                        "Netlerim",
                      ),
                      IconButton(
                        onPressed: () {
                          showHelpDialog(context);
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.circleQuestion,
                          color: Colors.white70,
                          size: 21,
                        ),
                      ),
                      const Spacer(),
                      if (netler.isNotEmpty)
                        DropdownMenuNetler(
                          categories: categories,
                          selectedItem: selectedItem!,
                          onChanged: (value) {
                            setState(() {
                              selectedItem = value;
                            });
                          },
                        ),
                    ],
                  ),
                  Stack(
                    children: [
                      if (netler.isEmpty)
                        const EmptyNetler(
                          message:
                              "+' ya dokunup deneme ekleyin veya derslerden birine tıklayıp Hızlı Net ekleyin.",
                        ),
                      if (netler.isNotEmpty && selectedItem == "-")
                        const EmptyNetler(
                          message: "Görüntülemek için Ders Seçiniz.",
                        ),
                      if (length == 1)
                        EmptyNetler(
                          message:
                              "Görüntülemek için 1 adet daha $selectedItem Neti giriniz.",
                        ),
                      NetlerChart(
                        showDetails: false,
                        maxData: maxY.toInt(),
                        length: daysSinceFirst,
                        data: data,
                      ),
                      if (!isBig)
                        Positioned(
                          top: -defaultPadding,
                          right: defaultPadding / 2,
                          child: BottomWidget(
                              netler: netler,
                              selectedItem: selectedItem,
                              maxY: maxY,
                              length: length,
                              daysSinceFirst: daysSinceFirst,
                              data: data),
                        ),
                    ],
                  ),
                  if (isBig)
                    Row(
                      children: [
                        const Spacer(),
                        BottomWidget(
                            netler: netler,
                            selectedItem: selectedItem,
                            maxY: maxY,
                            length: length,
                            daysSinceFirst: daysSinceFirst,
                            data: data),
                      ],
                    )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        );
      },
    );
  }

  Future<void> showHelpDialog(context) async {
    return await showModal(
        configuration: const FadeScaleTransitionConfiguration(
          transitionDuration: Duration(milliseconds: 300),
          reverseTransitionDuration: Duration(milliseconds: 300),
        ),
        context: context,
        builder: (_) => const HelpDialog(
              title: 'Net Durumu',
              message:
                  'Net durumunuz, her derse özel olarak zamanla eklediğiniz netlerin ortalamasını gösterir.\n\n',
              message2:
                  "İstediğiniz dersi seçerek netlerinizi görebilir, daha detaylı incelemek için İncele'ye basabilirsiniz..\n\n",
            ));
  }

  Future<Map<String, dynamic>> getNetler(List<DenemeStat> netler) {
    return compute(
      computeNetler,
      {
        "item": netler.map((e) => denemeStatToJson(e)).toList(),
        "value": selectedItem,
        "memberDate": FirebaseAuth.instance.currentUser!.metadata.creationTime!
      },
    );
  }
}

class BottomWidget extends StatelessWidget {
  const BottomWidget({
    Key? key,
    required this.netler,
    required this.selectedItem,
    required this.maxY,
    required this.length,
    required this.daysSinceFirst,
    required this.data,
  }) : super(key: key);

  final List<DenemeStat> netler;
  final String? selectedItem;
  final double maxY;
  final int length;
  final int daysSinceFirst;
  final List<Map<String, dynamic>> data;

  @override
  Widget build(BuildContext context) {
    return netler.isNotEmpty && selectedItem != "-" && length > 1
        ? FadeInRight(
            child: TextButton(
              onPressed: selectedItem != "-"
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NetStatsDetailScreen(
                            maxData: maxY.toInt(),
                            length: length,
                            daysSinceFirst: daysSinceFirst,
                            data: data,
                            title: selectedItem!,
                          ),
                        ),
                      );
                    }
                  : () {},
              child: Text(
                "İncele",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.blueAccent),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
