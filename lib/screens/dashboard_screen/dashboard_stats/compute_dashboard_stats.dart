Map<String, dynamic> computeNetlerDashboard(List<Map<String, dynamic>> netler) {
  List<Map<String, dynamic>> aytDenemeStats = [];
  List<Map<String, dynamic>> tytDenemeStats = [];

  double tytOrt = 0;
  double aytOrt = 0;

  Map<String, Map<String, dynamic>> statsPerDersAyt = {};
  Map<String, Map<String, dynamic>> statsPerDersTyt = {};

  if (netler.isNotEmpty) {
    for (var stat in netler) {
      if (stat["ayt"] == true) {
        aytDenemeStats.add(stat);
      } else {
        tytDenemeStats.add(stat);
      }
    }

    if (tytDenemeStats.isNotEmpty) {
      for (var stat in tytDenemeStats) {
        if (statsPerDersTyt.containsKey(stat["dersName"])) {
          statsPerDersTyt[stat["dersName"]]!["dogru"] += stat["dogru"];

          statsPerDersTyt[stat["dersName"]]!["yanlis"] += stat["yanlis"];

          statsPerDersTyt[stat["dersName"]]!["count"] += 1;
        } else {
          statsPerDersTyt.addAll({
            stat["dersName"]: {
              "dogru": stat["dogru"],
              "yanlis": stat["yanlis"],
              "count": 1,
            }
          });
        }
      }

      tytOrt = statsPerDersTyt.values.map((value) {
        return (value["dogru"] - 0.25 * value["yanlis"]) / value["count"];
      }).reduce((value, element) => value + element);
    }
    if (aytDenemeStats.isNotEmpty) {
      for (var stat in aytDenemeStats) {
        if (statsPerDersAyt.containsKey(stat["dersName"])) {
          statsPerDersAyt[stat["dersName"]]!["dogru"] += stat["dogru"];

          statsPerDersAyt[stat["dersName"]]!["yanlis"] += stat["yanlis"];

          statsPerDersAyt[stat["dersName"]]!["count"] += 1;
        } else {
          statsPerDersAyt.addAll({
            stat["dersName"]: {
              "dogru": stat["dogru"],
              "yanlis": stat["yanlis"],
              "count": 1,
            }
          });
        }
      }

      aytOrt = statsPerDersAyt.values.map((value) {
        return (value["dogru"] - 0.25 * value["yanlis"]) / value["count"];
      }).reduce((value, element) => value + element);
    }
  }

  return {
    "tytOrt": tytOrt,
    "aytOrt": aytOrt,
  };
}
