import 'package:hive_flutter/hive_flutter.dart';

import '../../models/adapters/adapters.dart';

import '../constants.dart';

void clearDb() {
  Hive.box(dbSettings).clear();
  Hive.box<Tarama>(dbTaramalar).clear();
  Hive.box<Exam>(dbExam).clear();
  Hive.box<Deneme>(dbDenemeler).clear();
  Hive.box<DenemeStat>(dbDenemelerStat).clear();
  Hive.lazyBox<Ders>(dbDersler).clear();
}
