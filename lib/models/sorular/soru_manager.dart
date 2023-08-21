import 'dart:io';

import 'package:flutter/material.dart';

import '../adapters/ders/ders_adapter.dart';

class SoruManager extends ChangeNotifier {
  Ders? _selectedDers;
  String _selectedKonu = '';
  String _selectedKonuName = '';
  String _selectedKonuKind = '';
  String _selectedSebep = '';
  List<String?> _selectedDersKonular = [];
  List<Map<String, String>> _selectedKonular = [];
  String _extraNote = '';
  String _importance = 'Orta';
  String _updatedNote = '';
  int _repeatNotification = 0;
  File? _pickedImageSoru;
  File? _pickedImageCozum;

  Ders? get selectedDers => _selectedDers;
  String get selectedKonu => _selectedKonu;
  String get selectedKonuName => _selectedKonuName;
  String get selectedKonuKind => _selectedKonuKind;
  String get selectedSebep => _selectedSebep;
  List<String?> get selectedKonular => _selectedDersKonular;
  String get extraNote => _extraNote;
  String get importanceSoru => _importance;
  int get repeatNotification => _repeatNotification;
  File? get pickedImageSoru => _pickedImageSoru;
  File? get pickedImageCozum => _pickedImageCozum;
  String get updatedNote => _updatedNote;

  List<Map<String, String>> get getSelectedKonular => _selectedKonular;

  void setUpdatedNote(String value) {
    _updatedNote = value;
    notifyListeners();
  }

  List<String> validateSoru() {
    List<String> errors = [];
    if (_pickedImageSoru == null) {
      errors.add("soru");
    }
    if (_selectedKonu == '') {
      errors.add("konu");
    }
    if (_selectedDers == null) {
      errors.add("ders");
    }

    notifyListeners();
    return errors;
  }

  void resetForPop() {
    _selectedKonu = '';
    _selectedDers = null;
    _selectedDersKonular = [];

    _selectedSebep = '';
    _extraNote = '';
    _importance = 'Orta';
    _repeatNotification = 0;
    _pickedImageSoru = null;
    _pickedImageCozum = null;

    notifyListeners();
  }

  void setSoruImage(File f) {
    _pickedImageSoru = f;
    notifyListeners();
  }

  void setCozumImage(File f) {
    _pickedImageCozum = f;
    notifyListeners();
  }

  void delSoruImage() {
    _pickedImageSoru = null;
    notifyListeners();
  }

  void delCozumImage() {
    _pickedImageCozum = null;
    notifyListeners();
  }

  void setSelectedDers(Ders ders) {
    _selectedDers = ders;
    _selectedKonu = "";
    _selectedKonuName = "";
    _selectedKonular = ders.konular;
    notifyListeners();
  }

  void setSelectedKonu(String konu) {
    _selectedKonu = konu;
    _selectedKonuName =
        _selectedKonular.firstWhere((e) => e["name"] == konu)["name"] as String;
    _selectedKonuKind =
        _selectedKonular.firstWhere((e) => e["name"] == konu)["kind"] as String;
    notifyListeners();
  }

  void resetSelectedKonu() {
    _selectedKonu = '';
    notifyListeners();
  }

  void setSelectedSebep(String sebep) {
    _selectedSebep = sebep;
    notifyListeners();
  }

  void setExtraNote(String note) {
    _extraNote = note;
    notifyListeners();
  }

  void setImportanceSoru(String importance) {
    _importance = importance;
    notifyListeners();
  }

  void setRepeatNotification(int repeat) {
    _repeatNotification = repeat;
    notifyListeners();
  }
}
