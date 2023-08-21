import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'soru_item_api.g.dart';

@JsonSerializable()
class APISoruItem {
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference? reference;

  final String id;
  final DateTime date;
  final String ders;
  final String dersCode;
  final String konu;
  final String konuKind;
  final String frequency;
  final String? extraNote;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? soruImage;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? cozumImage;

  final String importance;
  final bool isComplete;
  final bool hasCozum;
  final bool isCozumUzerinde;

  APISoruItem({
    required this.date,
    required this.ders,
    required this.dersCode,
    required this.konu,
    required this.konuKind,
    required this.frequency,
    required this.id,
    required this.hasCozum,
    required this.isCozumUzerinde,
    required this.importance,
    this.extraNote,
    this.soruImage,
    this.cozumImage,
    this.isComplete = false,
  });

  factory APISoruItem.fromJson(Map<String, dynamic> json) =>
      _$APISoruItemFromJson(json);
  Map<String, dynamic> toJson() => _$APISoruItemToJson(this);

  factory APISoruItem.fromSnapshot(DocumentSnapshot snapshot) {
    final message =
        APISoruItem.fromJson(snapshot.data() as Map<String, dynamic>);
    message.reference = snapshot.reference;
    return message;
  }
}
