import 'package:flutter/material.dart';

import '../adapters/deneme/deneme_adapter.dart';

class DenemeManager extends ChangeNotifier {
  String _title = '';
  Deneme? _selectedDeneme;
  double _denemeSure = 135;
  List<Map<String, dynamic>> allNetData = [];
  String _extraNote = '';
  String _importance = 'Orta';

  String get getTitle => _title;
  Deneme? get getDeneme => _selectedDeneme;
  double get getDenemeSure => _denemeSure;
  Map<String, dynamic> get getNetler => _getNetler();
  String get extraNote => _extraNote;

  String get importanceDeneme => _importance;

  Map<String, int> dersNetData = {'dogru': 0, 'yanlis': 0};

  Map<String, int> get getDersNetData => dersNetData;

  void resetDersNetData() {
    dersNetData = {'dogru': 0, 'yanlis': 0};
    notifyListeners();
  }

  void resetForPop() {
    _title = '';
    _selectedDeneme = null;
    _denemeSure = 135;
    allNetData = [];
    _extraNote = '';
    _importance = 'Orta';
    dersNetData = {'dogru': 0, 'yanlis': 0};
    notifyListeners();
  }

  void setDersNetDogru(int x) {
    dersNetData["dogru"] = x;
    notifyListeners();
  }

  void setDersNetYanlis(int x) {
    dersNetData["yanlis"] = x;
    notifyListeners();
  }

  Map<String, dynamic> _getNetler() {
    int dogru = 0;
    int yanlis = 0;
    for (var netData in allNetData) {
      dogru += netData["netler"]["dogru"] as int;
      yanlis += netData["netler"]["yanlis"] as int;
    }
    return {
      "dogru": dogru,
      "yanlis": yanlis,
      "net": dogru - yanlis / 4,
    };
  }

  List<String> validateDeneme() {
    List<String> errors = [];
    if (_title == '') {
      errors.add("title");
    }
    if (_selectedDeneme == null) {
      errors.add("deneme");
    }
    if (allNetData.isEmpty) {
      errors.add("net");
    }
    notifyListeners();
    return errors;
  }

  void setDenemeTitle(String title) {
    _title = title;
  }

  void setSelectedDeneme(Deneme deneme) {
    _selectedDeneme = deneme;
    notifyListeners();
  }

  void setDenemeSure(double dk) {
    _denemeSure = dk;
    notifyListeners();
  }

  void resetDenemeSure() {
    _denemeSure = 135;
    notifyListeners();
  }

  void resetAllNetData() {
    allNetData.clear();
    notifyListeners();
  }

  void addNetData(String denemeName, Map<String, int> dogruVeYanlis) {
    // print(allNetData);
    var netData = {
      'denemeName': denemeName,
      'short_name': denemeName.substring(0, 3),
      'netler': dogruVeYanlis
    };

    bool check = allNetData
        .any((element) => element["denemeName"] == netData["denemeName"]);

    if (check) {
      allNetData.removeWhere(
          (element) => element["denemeName"] == netData["denemeName"]);
      allNetData.add(netData);
    } else {
      allNetData.add(netData);
    }
    notifyListeners();
  }

  Map<String, int> restoreNetData(String denemeName) {
    bool check =
        allNetData.any((element) => element["denemeName"] == denemeName);

    if (check) {
      return allNetData.firstWhere(
              (element) => element["denemeName"] == denemeName)["netler"]
          as Map<String, int>;
    } else {
      return {'dogru': 0, 'yanlis': 0};
    }
  }

  void setExtraNote(String note) {
    _extraNote = note;
    notifyListeners();
  }

  void setImportanceDeneme(String importance) {
    _importance = importance;
    notifyListeners();
  }
}
