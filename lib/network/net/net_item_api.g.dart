// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'net_item_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APINetItem _$APINetItemFromJson(Map<String, dynamic> json) => APINetItem(
      dersName: json['dersName'] as String,
      dersCode: json['dersCode'] as String,
      ayt: json['ayt'] as bool,
      dogru: json['dogru'] as int,
      yanlis: json['yanlis'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      sure: json['sure'] as int?,
    );

Map<String, dynamic> _$APINetItemToJson(APINetItem instance) =>
    <String, dynamic>{
      'dersName': instance.dersName,
      'dersCode': instance.dersCode,
      'ayt': instance.ayt,
      'dogru': instance.dogru,
      'yanlis': instance.yanlis,
      'createdAt': instance.createdAt.toIso8601String(),
      'sure': instance.sure,
    };
