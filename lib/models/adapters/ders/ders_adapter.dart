import 'package:hive/hive.dart';

part 'ders_adapter.g.dart';

@HiveType(typeId: 1)
class Ders extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String code;

  @HiveField(2)
  List<Map<String, String>> konular;

  @HiveField(3)
  bool ayt;

  Ders({
    required this.name,
    required this.code,
    required this.konular,
    required this.ayt,
  });
}
