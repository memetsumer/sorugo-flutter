import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'quotes_api.g.dart';

@JsonSerializable()
class APIQuotes {
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference? reference;

  final DateTime date;
  final String quote;
  final double author;

  APIQuotes({
    required this.date,
    required this.quote,
    required this.author,
  });

  factory APIQuotes.fromJson(Map<String, dynamic> json) =>
      _$APIQuotesFromJson(json);
  Map<String, dynamic> toJson() => _$APIQuotesToJson(this);

  factory APIQuotes.fromSnapshot(DocumentSnapshot snapshot) {
    final message = APIQuotes.fromJson(snapshot.data() as Map<String, dynamic>);
    message.reference = snapshot.reference;
    return message;
  }
}
