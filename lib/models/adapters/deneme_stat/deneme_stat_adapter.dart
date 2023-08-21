import 'package:hive/hive.dart';

part 'deneme_stat_adapter.g.dart';

@HiveType(typeId: 6)
class DenemeStat extends HiveObject {
  @HiveField(0)
  String dersName;

  @HiveField(1)
  String dersCode;

  @HiveField(2)
  bool ayt;

  @HiveField(3)
  int dogru;

  @HiveField(4)
  int yanlis;

  @HiveField(5)
  int? sure;

  @HiveField(6)
  DateTime createdAt;

  DenemeStat({
    required this.dersName,
    required this.dersCode,
    required this.ayt,
    required this.dogru,
    required this.yanlis,
    required this.createdAt,
    this.sure,
  });
}
