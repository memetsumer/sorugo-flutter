// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotes_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIQuotes _$APIQuotesFromJson(Map<String, dynamic> json) => APIQuotes(
      date: DateTime.parse(json['date'] as String),
      quote: json['quote'] as String,
      author: (json['author'] as num).toDouble(),
    );

Map<String, dynamic> _$APIQuotesToJson(APIQuotes instance) => <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'quote': instance.quote,
      'author': instance.author,
    };
