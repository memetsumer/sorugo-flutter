import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_yks_app/network/net/net_item_api.dart';

class NetDao {
  final CollectionReference colRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("netler");

  Future<void>? saveNet(APINetItem net) async {
    try {
      Map<String, dynamic> payload = net.toJson();

      await colRef.add(payload);
    } on firebase_core.FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<List<APINetItem>?> getNetler() async {
    try {
      QuerySnapshot querySnapshot = await colRef.get();

      List<APINetItem> netler = [];

      for (DocumentSnapshot doc in querySnapshot.docs) {
        netler.add(APINetItem.fromJson(doc.data() as Map<String, dynamic>));
      }

      return netler;
    } on firebase_core.FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }
}
