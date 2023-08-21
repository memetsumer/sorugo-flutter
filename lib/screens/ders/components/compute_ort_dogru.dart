Map<String, dynamic> computeOrtalamaDogru(Map<String, dynamic> passedData) {
  var dersDenemeStat = passedData["netler"]
      .where((e) => e["dersCode"] == passedData["dersCode"])
      .toList();

  var aytNetList = dersDenemeStat.where((e) => e["ayt"] == true).toList();

  var tytNetList = dersDenemeStat.where((e) => e["ayt"] == false).toList();

  var aytDogru = 0;
  var aytYanlis = 0;
  var tytDogru = 0;
  var tytYanlis = 0;

  if (aytNetList.isNotEmpty) {
    aytDogru = aytNetList
        .map((e) => e["dogru"])
        .reduce((value, element) => value + element);
    aytYanlis = aytNetList
        .map((e) => e["yanlis"])
        .reduce((value, element) => value + element);
  }
  if (tytNetList.isNotEmpty) {
    tytDogru = tytNetList
        .map((e) => e["dogru"])
        .reduce((value, element) => value + element);
    tytYanlis = tytNetList
        .map((e) => e["yanlis"])
        .reduce((value, element) => value + element);
  }

  // var aytNet = aytDogru - 0.25 * aytYanlis;
  // var tytNet = tytDogru - 0.25 * tytYanlis;

  double avgTytNet = 0;
  double avgAytNet = 0;

  if (!(tytDogru + tytYanlis == 0)) {
    avgTytNet = tytDogru / (tytDogru + tytYanlis) * 100;
  }
  if (!(aytDogru + aytYanlis == 0)) {
    avgAytNet = aytDogru / (aytDogru + aytYanlis) * 100;
  }

  return {
    "avgTytNet": avgTytNet,
    "avgAytNet": avgAytNet,
  };
}
