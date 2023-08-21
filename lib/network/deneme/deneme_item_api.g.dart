// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deneme_item_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIDenemeItem _$APIDenemeItemFromJson(Map<String, dynamic> json) =>
    APIDenemeItem(
      title: json['title'] as String,
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      denemeTuru: json['denemeTuru'] as String,
      netler: (json['netler'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      ayt: json['ayt'] as bool,
      sure: (json['sure'] as num).toDouble(),
      importance: json['importance'] as String,
      dogru: json['dogru'] as int,
      yanlis: json['yanlis'] as int,
      net: (json['net'] as num).toDouble(),
      extraNote: json['extraNote'] as String?,
    );

Map<String, dynamic> _$APIDenemeItemToJson(APIDenemeItem instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'denemeTuru': instance.denemeTuru,
      'sure': instance.sure,
      'ayt': instance.ayt,
      'title': instance.title,
      'id': instance.id,
      'extraNote': instance.extraNote,
      'dogru': instance.dogru,
      'yanlis': instance.yanlis,
      'net': instance.net,
      'netler': instance.netler,
      'importance': instance.importance,
    };
