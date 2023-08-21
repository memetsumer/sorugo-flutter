import 'package:cloud_firestore/cloud_firestore.dart';

class QuotesDao {
  final CollectionReference colRef =
      FirebaseFirestore.instance.collection('quotes');

  Stream<QuerySnapshot> getQuotes() {
    return colRef.orderBy('date', descending: true).limit(5).snapshots();
  }
}
