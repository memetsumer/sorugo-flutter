import 'package:fl_chart/fl_chart.dart';

Map<String, dynamic> computeTaramalar(Map<String, dynamic> data) {
  final now = DateTime.now();

  final taramalar = data["taramalar"] as List<Map<String, dynamic>>;

  final filteredAytTotal = taramalar.where((element2) {
    return element2["kind"] == "ayt";
  }).toList();

  final filteredTytTotal = taramalar.where((element2) {
    return element2["kind"] == "tyt";
  }).toList();

  Map<String, dynamic> aytTotal = {};
  Map<String, dynamic> tytTotal = {};

  for (Map<String, dynamic> tarama in filteredAytTotal) {
    if (aytTotal.containsKey(tarama["dersCode"])) {
      aytTotal[tarama["dersCode"]] += tarama["count"];
    } else {
      aytTotal[tarama["dersCode"]] = tarama["count"];
    }
  }

  for (Map<String, dynamic> tarama in filteredTytTotal) {
    if (tytTotal.containsKey(tarama["dersCode"])) {
      tytTotal[tarama["dersCode"]] += tarama["count"];
    } else {
      tytTotal[tarama["dersCode"]] = tarama["count"];
    }
  }

  List<Map<String, dynamic>> last3DayData = [
    {"date": "Bugün", "count": 0},
    {"date": "Dün", "count": 0},
    {"date": "Önceki Gün", "count": 0}
  ];

  for (int i = 0; i < 3; i++) {
    final date = now.subtract(Duration(days: i));
    final filteredTaramalar = taramalar.where((element) {
      // bu cozum bug i cozer mi bilmiyorum ama denedim calisiyor
      return (element["createdAt"] as DateTime).difference(date).inHours < 24 &&
          (element["createdAt"] as DateTime).difference(date).inHours >= 0 &&
          (element["createdAt"] as DateTime).day == date.day;
    }).toList();
    final sum = filteredTaramalar.fold(0, (previousValue, element) {
      return (previousValue as int) + element["count"];
    });
    last3DayData[i]["count"] = sum;
  }

  List<Map<String, dynamic>> last30DayData = [];

  int maxY = 0;

  int lengthOfChart = 30;

  for (int i = 0; i < lengthOfChart; i++) {
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
    last30DayData.add({
      "date": date,
      "count": sum,
      "data": FlSpot(lengthOfChart - i.toDouble(), sum.toDouble()),
    });
  }

  return {
    "aytTotal": aytTotal,
    "tytTotal": tytTotal,
    "last3DayData": last3DayData,
    "last30DayData": last30DayData,
    "maxY": maxY,
    "lengthOfChart": lengthOfChart,
  };
}
