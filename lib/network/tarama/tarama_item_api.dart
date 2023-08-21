import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'tarama_item_api.g.dart';

@JsonSerializable()
class APITaramaItem {
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference? reference;

  final String ders;
  final String dersCode;
  final String konu;
  final String kind;
  final int count;
  final DateTime createdAt;

  APITaramaItem({
    required this.createdAt,
    required this.ders,
    required this.dersCode,
    required this.konu,
    required this.kind,
    required this.count,
  });

  factory APITaramaItem.fromJson(Map<String, dynamic> json) =>
      _$APITaramaItemFromJson(json);
  Map<String, dynamic> toJson() => _$APITaramaItemToJson(this);

  factory APITaramaItem.fromSnapshot(DocumentSnapshot snapshot) {
    final message =
        APITaramaItem.fromJson(snapshot.data() as Map<String, dynamic>);
    message.reference = snapshot.reference;
    return message;
  }
}
