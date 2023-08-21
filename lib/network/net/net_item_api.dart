import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'net_item_api.g.dart';

@JsonSerializable()
class APINetItem {
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference? reference;

  final String dersName;
  final String dersCode;
  final bool ayt;
  final int dogru;
  final int yanlis;
  final DateTime createdAt;

  final int? sure;

  APINetItem({
    required this.dersName,
    required this.dersCode,
    required this.ayt,
    required this.dogru,
    required this.yanlis,
    required this.createdAt,
    this.sure,
  });

  factory APINetItem.fromJson(Map<String, dynamic> json) =>
      _$APINetItemFromJson(json);
  Map<String, dynamic> toJson() => _$APINetItemToJson(this);

  factory APINetItem.fromSnapshot(DocumentSnapshot snapshot) {
    final message =
        APINetItem.fromJson(snapshot.data() as Map<String, dynamic>);
    message.reference = snapshot.reference;
    return message;
  }
}
