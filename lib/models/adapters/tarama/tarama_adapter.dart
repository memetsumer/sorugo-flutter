import 'package:hive/hive.dart';

part 'tarama_adapter.g.dart';

@HiveType(typeId: 3)
class Tarama extends HiveObject {
  @HiveField(0)
  String ders;

  @HiveField(1)
  String dersCode;

  @HiveField(2)
  String konu;

  @HiveField(3)
  int count;

  @HiveField(4)
  DateTime createdAt;

  // Exam kind
  @HiveField(5)
  String kind;

  Tarama({
    required this.ders,
    required this.dersCode,
    required this.konu,
    required this.count,
    required this.createdAt,
    required this.kind,
  });
}
