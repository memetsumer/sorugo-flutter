import 'package:hive/hive.dart';

part 'exam_adapter.g.dart';

@HiveType(typeId: 4)
class Exam extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String code;

  Exam({
    required this.name,
    required this.code,
  });
}
