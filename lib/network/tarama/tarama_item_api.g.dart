// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tarama_item_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APITaramaItem _$APITaramaItemFromJson(Map<String, dynamic> json) =>
    APITaramaItem(
      createdAt: DateTime.parse(json['createdAt'] as String),
      ders: json['ders'] as String,
      dersCode: json['dersCode'] as String,
      konu: json['konu'] as String,
      kind: json['kind'] as String,
      count: json['count'] as int,
    );

Map<String, dynamic> _$APITaramaItemToJson(APITaramaItem instance) =>
    <String, dynamic>{
      'ders': instance.ders,
      'dersCode': instance.dersCode,
      'konu': instance.konu,
      'kind': instance.kind,
      'count': instance.count,
      'createdAt': instance.createdAt.toIso8601String(),
    };
