import 'package:hive/hive.dart';

part 'deneme_adapter.g.dart';

@HiveType(typeId: 2)
class Deneme extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String code;

  @HiveField(2)
  String kind;

  @HiveField(3)
  int total;

  @HiveField(4)
  List<Map<String, dynamic>>? dersler;

  Deneme({
    required this.name,
    required this.code,
    required this.kind,
    required this.total,
    this.dersler,
  });
}
