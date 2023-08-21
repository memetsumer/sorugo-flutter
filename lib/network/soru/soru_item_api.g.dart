// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'soru_item_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APISoruItem _$APISoruItemFromJson(Map<String, dynamic> json) => APISoruItem(
      date: DateTime.parse(json['date'] as String),
      ders: json['ders'] as String,
      dersCode: json['dersCode'] as String,
      konu: json['konu'] as String,
      konuKind: json['konuKind'] as String,
      frequency: json['frequency'] as String,
      id: json['id'] as String,
      hasCozum: json['hasCozum'] as bool,
      isCozumUzerinde: json['isCozumUzerinde'] as bool,
      importance: json['importance'] as String,
      extraNote: json['extraNote'] as String?,
      isComplete: json['isComplete'] as bool? ?? false,
    );

Map<String, dynamic> _$APISoruItemToJson(APISoruItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'ders': instance.ders,
      'dersCode': instance.dersCode,
      'konu': instance.konu,
      'konuKind': instance.konuKind,
      'frequency': instance.frequency,
      'extraNote': instance.extraNote,
      'importance': instance.importance,
      'isComplete': instance.isComplete,
      'hasCozum': instance.hasCozum,
      'isCozumUzerinde': instance.isCozumUzerinde,
    };
