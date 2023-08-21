import 'package:flutter/material.dart';

class SorularManager extends ChangeNotifier {
  String _queryDersName = '';
  String _queryKonuCode = '';
  bool ayt = false;
  String _queryTur = '';
  String _queryKonu = '';
  String _queryImportance = '';
  String _queryCozum = '';

  int _refresh = 0;

  Map<String, dynamic> get getQuery => {
        'ders': _queryDersName,
        'konu': _queryKonu,
        'konuKind': _queryTur,
        'importance': _queryImportance,
        'hasCozum': _queryCozum
      };

  String get getQueryTur => _queryTur;
  String get getQueryDersName => _queryDersName;
  String get getQueryKonuCode => _queryKonuCode;
  bool get getAyt => ayt;

  int get getRefresh => _refresh;

  void setQueryDersName(String dersName) {
    _queryDersName = dersName;
    notifyListeners();
  }

  void setRefresh(int refresh) {
    _refresh = refresh;
    notifyListeners();
  }

  void setQueryKonuCode(String code) {
    _queryKonuCode = code;
    notifyListeners();
  }

  void setQueryTur(String tur) {
    _queryTur = tur;
    notifyListeners();
  }

  void setAyt(bool ayt) {
    this.ayt = ayt;
    notifyListeners();
  }

  void setQueryKonu(String konu) {
    _queryKonu = konu;
    notifyListeners();
  }

  void setQueryImportance(String importance) {
    _queryImportance = importance;
    notifyListeners();
  }

  void setQueryCozum(String cozum) {
    _queryCozum = cozum;
    notifyListeners();
  }
}
