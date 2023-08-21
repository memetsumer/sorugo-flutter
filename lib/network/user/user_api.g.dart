// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIUser _$APIUserFromJson(Map<String, dynamic> json) => APIUser(
      exam: json['exam'] as String,
      premium: json['premium'] as bool,
      soruCount: json['soruCount'] as int,
      soruSolved: json['soruSolved'] as int,
      isBanned: json['isBanned'] as bool,
    );

Map<String, dynamic> _$APIUserToJson(APIUser instance) => <String, dynamic>{
      'exam': instance.exam,
      'soruCount': instance.soruCount,
      'premium': instance.premium,
      'soruSolved': instance.soruSolved,
      'isBanned': instance.isBanned,
    };
