// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIQuiz _$APIQuizFromJson(Map<String, dynamic> json) => APIQuiz(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      name: json['name'] as String,
      score: (json['score'] as num).toDouble(),
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$APIQuizToJson(APIQuiz instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'name': instance.name,
      'score': instance.score,
      'photoUrl': instance.photoUrl,
    };
