import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'deneme_item_api.g.dart';

@JsonSerializable()
class APIDenemeItem {
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference? reference;

  final DateTime date;
  final String denemeTuru;
  final double sure;
  final bool ayt;
  final String title;
  final String id;
  final String? extraNote;

  final int dogru;
  final int yanlis;
  final double net;

  final List<Map<String, dynamic>> netler;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? kapakImage;

  final String importance;

  APIDenemeItem({
    required this.title,
    required this.id,
    required this.date,
    required this.denemeTuru,
    required this.netler,
    required this.ayt,
    required this.sure,
    required this.importance,
    required this.dogru,
    required this.yanlis,
    required this.net,
    this.extraNote,
    this.kapakImage,
  });

  factory APIDenemeItem.fromJson(Map<String, dynamic> json) =>
      _$APIDenemeItemFromJson(json);
  Map<String, dynamic> toJson() => _$APIDenemeItemToJson(this);

  factory APIDenemeItem.fromSnapshot(DocumentSnapshot snapshot) {
    final message =
        APIDenemeItem.fromJson(snapshot.data() as Map<String, dynamic>);
    message.reference = snapshot.reference;
    return message;
  }
}
