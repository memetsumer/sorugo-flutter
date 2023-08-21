import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'quiz_api.g.dart';

@JsonSerializable()
class APIQuiz {
  @JsonKey(includeFromJson: false, includeToJson: false)
  DocumentReference? reference;

  final String id;
  final DateTime date;
  final String name;
  final double score;
  final String? photoUrl;

  APIQuiz({
    required this.id,
    required this.date,
    required this.name,
    required this.score,
    this.photoUrl,
  });

  factory APIQuiz.fromJson(Map<String, dynamic> json) =>
      _$APIQuizFromJson(json);
  Map<String, dynamic> toJson() => _$APIQuizToJson(this);

  factory APIQuiz.fromSnapshot(DocumentSnapshot snapshot) {
    final message = APIQuiz.fromJson(snapshot.data() as Map<String, dynamic>);
    message.reference = snapshot.reference;
    return message;
  }
}
