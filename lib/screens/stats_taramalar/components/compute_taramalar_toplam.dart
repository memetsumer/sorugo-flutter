import 'package:fl_chart/fl_chart.dart';

Map<String, dynamic> computeTaramalarToplam(Map<String, dynamic> data) {
  final now = DateTime.now();

  final taramalar = data["taramalar"] as List<Map<String, dynamic>>;
  final totalTaramalarDayLength = data["totalTaramalarDayLength"] as int;

  final filteredGeometriTotal = taramalar.where((element2) {
    return element2["ders"] == "Geometri";
  }).toList();

  final filteredFromGeometri = taramalar.where((element2) {
    return element2["ders"] != "Geometri";
  }).toList();

  final filteredAytTotal = filteredFromGeometri.where((element2) {
    return element2["kind"] == "ayt";
  }).toList();

  final filteredTytTotal = filteredFromGeometri.where((element2) {
    return element2["kind"] == "tyt";
  }).toList();

  final sumGeometriTotal =
      filteredGeometriTotal.fold(0, (a, b) => (a as int) + b["count"]);

  final sumAytTotal =
      filteredAytTotal.fold(0, (a, b) => (a as int) + b["count"]);

  final sumTytTotal =
      filteredTytTotal.fold(0, (a, b) => (a as int) + b["count"]);

  Map<String, dynamic> aytTotal = {};
  Map<String, dynamic> tytTotal = {};

  for (Map<String, dynamic> tarama in filteredAytTotal) {
    if (aytTotal.containsKey(tarama["ders"])) {
      aytTotal[tarama["ders"]] += tarama["count"];
    } else {
      aytTotal[tarama["ders"]] = tarama["count"];
    }
  }

  for (Map<String, dynamic> tarama in filteredTytTotal) {
    if (tytTotal.containsKey(tarama["ders"])) {
      tytTotal[tarama["ders"]] += tarama["count"];
    } else {
      tytTotal[tarama["ders"]] = tarama["count"];
    }
  }

  List<Map<String, dynamic>> totalTaramalarSinceBegin = [];

  int maxY = 0;

  for (int i = 0; i <= totalTaramalarDayLength; i++) {
    final date = now.subtract(Duration(days: i));
    final filteredTaramalar = taramalar.where((element) {
      DateTime elementCreatedAt = element["createdAt"] as DateTime;
      String myDate =
          "${elementCreatedAt.month}/${elementCreatedAt.day}/${elementCreatedAt.year}";

      return myDate == "${date.month}/${date.day}/${date.year}";
    }).toList();
    final sum = filteredTaramalar.fold(0, (previousValue, element) {
      return (previousValue as int) + element["count"];
    });
    if (maxY < sum) {
      maxY = sum.toInt();
    }
    totalTaramalarSinceBegin.add({
      "date": date,
      "count": sum,
      "data": FlSpot(totalTaramalarDayLength - i.toDouble(), sum.toDouble()),
    });
  }

  return {
    "aytTotal": aytTotal,
    "tytTotal": tytTotal,
    "sumAytTotal": sumAytTotal,
    "sumGeometriTotal": sumGeometriTotal,
    "sumTytTotal": sumTytTotal,
    "maxY": maxY,
    "totalTaramalarSinceBegin": totalTaramalarSinceBegin,
  };
}
