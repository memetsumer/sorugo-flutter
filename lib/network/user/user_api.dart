import 'package:json_annotation/json_annotation.dart';

part 'user_api.g.dart';

@JsonSerializable()
class APIUser {
  final String exam;

  final int soruCount;

  final bool premium;

  final int soruSolved;

  final bool isBanned;

  APIUser({
    required this.exam,
    required this.premium,
    required this.soruCount,
    required this.soruSolved,
    required this.isBanned,
  });

  factory APIUser.fromJson(Map<String, dynamic> json) =>
      _$APIUserFromJson(json);
  Map<String, dynamic> toJson() => _$APIUserToJson(this);
}
