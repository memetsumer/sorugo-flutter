import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'deneme_item_api.dart';

class DenemeDao {
  final CollectionReference colRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("denemeler");

  Future<void> saveDeneme(APIDenemeItem deneme) async {
    try {
      Map<String, dynamic> payload = deneme.toJson();

      await colRef.doc(payload["id"]).set(payload);
    } on firebase_core.FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void>? deleteDeneme(String id) async {
    try {
      await colRef.doc(id).delete();
    } on firebase_core.FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Query<Map<String, dynamic>> getData() {
    return colRef.orderBy("date", descending: true)
        as Query<Map<String, dynamic>>;
  }
}
