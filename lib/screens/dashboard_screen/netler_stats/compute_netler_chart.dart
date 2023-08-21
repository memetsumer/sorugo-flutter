import 'package:fl_chart/fl_chart.dart';

Map<String, dynamic> computeNetler(Map<String, dynamic> values) {
  final derseAitNetler = values["item"];
  final selectedItem = values["value"];

  Map<String, dynamic> categories = {};
  Map<String, dynamic> aytTotal = {};
  List<Map<String, dynamic>> data = [];
  double maxY = 0;

  for (var e in derseAitNetler) {
    String key = "${e["dersName"]} ${e["ayt"] ? 'AYT' : 'TYT'}";
    if (!categories.containsKey(key)) {
      categories[key] = {
        'dersName': e["dersName"],
        'ayt': e["ayt"],
        'sure': e["sure"],
        'createdAt': e["createdAt"],
      };
    }
  }

  final filteredAytTotal = derseAitNetler.where(
    (element2) {
      return selectedItem ==
          "${element2["dersName"]} ${element2["ayt"] ? 'AYT' : 'TYT'}";
    },
  ).toList();

  var length = filteredAytTotal.length;

  for (Map<String, dynamic> net in filteredAytTotal) {
    if (aytTotal.containsKey(net["dersName"])) {
      aytTotal[net["dersName"]] += (net["dogru"] - 0.25 * net["yanlis"]);
    } else {
      aytTotal[net["dersName"]] = (net["dogru"] - 0.25 * net["yanlis"]);
    }
  }

  for (int i = 0; i < length; i++) {
    double res = (filteredAytTotal[i]["dogru"].toDouble() -
        0.25 * filteredAytTotal[i]["yanlis"].toDouble());

    if (maxY < res) {
      maxY = res;
    }

    data.add(
      {
        "date": filteredAytTotal[i]["createdAt"],
        "count": res,
        "length": length,
        "data": FlSpot(i.toDouble(), res),
      },
    );
  }

  return {
    "data": data,
    "length": length,
    "daysSinceFirst": length,
    "maxY": maxY,
    "categories": categories,
  };
}
