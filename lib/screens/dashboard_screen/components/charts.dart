import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '/utils/constants.dart';

class TaramalarChart extends StatelessWidget {
  final bool showDetails;
  final int maxData;
  final int length;

  final List<Map<String, dynamic>> data;

  const TaramalarChart({
    Key? key,
    required this.showDetails,
    required this.data,
    required this.maxData,
    required this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = [
      const Color.fromARGB(255, 114, 53, 124),
      const Color.fromARGB(255, 105, 3, 85),
      Colors.deepOrange.withOpacity(0.9),
    ];
    return AspectRatio(
      aspectRatio: showDetails ? 2 : 3,
      child: Padding(
        padding: EdgeInsets.only(
          top: defaultPadding * 3,
          bottom: defaultPadding,
          left: showDetails ? 0 : 0,
          right: showDetails ? defaultPadding * 2 : 0,
        ),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              show: showDetails,
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            gridData: FlGridData(
              show: false,
            ),
            minX: 0,
            maxX: length.toDouble(),
            minY: 0,
            maxY: maxData.toDouble(),
            lineBarsData: [
              LineChartBarData(
                spots:
                    data.map((element) => element["data"] as FlSpot).toList(),
                isCurved: true,
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                barWidth: 4,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: false,
                ),
                shadow: const Shadow(
                  color: Color.fromRGBO(255, 32, 184, 1),
                  blurRadius: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NetlerChart extends StatelessWidget {
  final bool showDetails;
  final int maxData;
  final int length;

  final List<Map<String, dynamic>> data;

  const NetlerChart({
    Key? key,
    required this.showDetails,
    required this.data,
    required this.maxData,
    required this.length,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = [
      const Color.fromARGB(255, 114, 53, 124),
      const Color.fromARGB(255, 105, 3, 85),
      Colors.deepOrange.withOpacity(0.9),
    ];

    return AspectRatio(
      aspectRatio: showDetails ? 2 : 3.5,
      child: Padding(
        padding: EdgeInsets.only(
          top: defaultPadding * 2,
          bottom: defaultPadding,
          left: showDetails ? 0 : 0,
          right: showDetails ? defaultPadding * 2 : 0,
        ),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              show: showDetails,
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            gridData: FlGridData(
              show: false,
            ),
            minX: 0,
            maxX: length.toDouble(),
            minY: 0,
            maxY: maxData.toDouble(),
            lineBarsData: [
              LineChartBarData(
                spots:
                    data.map((element) => element["data"] as FlSpot).toList(),
                isCurved: true,
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                barWidth: 4,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: false,
                ),
                shadow: const Shadow(
                  color: Color.fromRGBO(255, 32, 184, 1),
                  blurRadius: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
