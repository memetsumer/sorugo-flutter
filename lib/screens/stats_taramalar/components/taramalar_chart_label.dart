import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../stats_detail_screen.dart';

class TaramalarChartLabel extends StatelessWidget {
  final bool showDetails;
  final int maxData;
  final int length;
  final List<Map<String, dynamic>> data;

  const TaramalarChartLabel({
    Key? key,
    required this.showDetails,
    required this.data,
    required this.maxData,
    required this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        children: [
          const Text(
            "Son 30 Günlük Taramalar",
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
                    maxData: maxData,
                    data: data,
                    length: length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
