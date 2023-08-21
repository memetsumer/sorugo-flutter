import 'package:cloud_firestore/cloud_firestore.dart';

class Exam {
  final String? name;
  final DateTime? date;
  final List<Map<String, dynamic>>? dersler;
  final List<Map<String, dynamic>>? denemeler;

  Exam({
    this.name,
    this.date,
    this.dersler,
    this.denemeler,
  });

  factory Exam.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Exam(
      name: data?['name'],
      date: data?['date']?.toDate(),
      dersler:
          data?['dersler'] is Iterable ? List.from(data?['dersler']) : null,
      denemeler:
          data?['denemeler'] is Iterable ? List.from(data?['denemeler']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (date != null) "date": Timestamp.fromDate(date!),
      if (dersler != null) "dersler": dersler,
      if (denemeler != null) "denemeler": denemeler,
    };
  }
}
