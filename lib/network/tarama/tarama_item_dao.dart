import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_yks_app/network/tarama/tarama_item_api.dart';

class TaramaDao {
  final CollectionReference colRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("taramalar");

  Future<void>? saveTarama(APITaramaItem tarama) async {
    try {
      Map<String, dynamic> payload = tarama.toJson();

      await colRef.add(payload);
    } on firebase_core.FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<List<APITaramaItem>?> getTaramalar() async {
    try {
      QuerySnapshot querySnapshot = await colRef.get();

      List<APITaramaItem> taramalar = [];

      for (DocumentSnapshot doc in querySnapshot.docs) {
        taramalar
            .add(APITaramaItem.fromJson(doc.data() as Map<String, dynamic>));
      }

      return taramalar;
    } on firebase_core.FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }
}
