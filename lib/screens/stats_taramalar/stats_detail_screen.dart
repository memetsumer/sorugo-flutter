import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yks_app/screens/components/sorugo_card.dart';
import '../dashboard_screen/components/charts.dart';

import '../../utils/constants.dart';

class StatsDetailScreen extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final int maxData;
  final int length;
  const StatsDetailScreen({
    Key? key,
    required this.data,
    required this.length,
    required this.maxData,
  }) : super(key: key);

  @override
  State<StatsDetailScreen> createState() => _StatsDetailScreenState();
}

class _StatsDetailScreenState extends State<StatsDetailScreen> {
  @override
  void initState() {
    FirebaseAnalytics.instance.logScreenView(
      screenName: 'StatsDetailScreen',
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        title: Text("Tarama Detayları",
            style: Theme.of(context).textTheme.titleLarge!),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          TaramalarChart(
            showDetails: true,
            data: widget.data,
            length: widget.length,
            maxData: widget.maxData,
          ),
          ...widget.data.map(
            (e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  "${DateTime.parse(e['date'].toString()).day.toString()}/${DateTime.parse(e['date'].toString()).month.toString()}/${DateTime.parse(e['date'].toString()).year.toString()}",
                ),
                subtitle: Text(e["count"].toString()),
                leading: const Icon(
                  Icons.assessment,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NetStatsDetailScreen extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final int maxData;
  final int length;
  final String title;
  final int daysSinceFirst;
  const NetStatsDetailScreen({
    Key? key,
    required this.data,
    required this.length,
    required this.maxData,
    required this.title,
    required this.daysSinceFirst,
  }) : super(key: key);

  @override
  State<NetStatsDetailScreen> createState() => _NetStatsDetailScreenState();
}

class _NetStatsDetailScreenState extends State<NetStatsDetailScreen> {
  @override
  void initState() {
    FirebaseAnalytics.instance.logScreenView(
      screenName: 'NetStatsDetailScreen',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sum = 0;

    for (var e in widget.data) {
      sum += e["count"];
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        title: Text("${widget.title} Netlerin",
            style: Theme.of(context).textTheme.titleLarge!),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: defaultPadding),
            child: NetlerChart(
              showDetails: true,
              data: widget.data,
              length: widget.daysSinceFirst,
              maxData: widget.maxData,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: SorugoCard(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
                vertical: defaultPadding / 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Ortalama ${widget.title} Netin",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(
                    width: defaultPadding,
                  ),
                  Text(
                    (sum / widget.length).toStringAsFixed(2),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 26,
                        color: Colors.white,
                        shadows: const [
                          BoxShadow(
                            color: Color.fromARGB(127, 255, 255, 255),
                            blurRadius: 8,
                          )
                        ]),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
          ...widget.data.map(
            (e) => e["length"] == 0
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(defaultPadding / 2),
                    child: ListTile(
                      title: Text(
                        "${DateTime.parse(e['date'].toString()).day.toString()}/${DateTime.parse(e['date'].toString()).month.toString()}/${DateTime.parse(e['date'].toString()).year.toString()}",
                      ),
                      subtitle: Text("Net: ${e["count"]}"),
                      leading: const Icon(
                        Icons.assessment,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
