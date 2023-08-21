import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yks_app/utils/constants.dart';

import '/utils/snackbar_message.dart';
import './user_api.dart';

class UserDao {
  final DocumentReference docRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  incrementSolvedSoru(int solvedSoru) async {
    try {
      await docRef.update({'soruSolved': FieldValue.increment(solvedSoru)});
    } catch (e) {
      SnackbarMessage.showSnackbar(e.toString(), Colors.redAccent);
    }
  }

  incrementSavedSoru() async {
    try {
      await docRef.update({'soruCount': FieldValue.increment(1)});
    } catch (e) {
      SnackbarMessage.showSnackbar(e.toString(), Colors.redAccent);
    }
  }

  decrementSavedSoru() async {
    try {
      await docRef.update({'soruCount': FieldValue.increment(-1)});
    } catch (e) {
      SnackbarMessage.showSnackbar(e.toString(), Colors.redAccent);
    }
  }

  Future<void> setExam(String exam) async {
    return await docRef.update({examUserDocument: exam});
  }

  Future<void> setDersler(Map<String, List<dynamic>> dersler) async {
    return await docRef.update(dersler);
  }

  Future<void> setUser(APIUser user) async {
    try {
      Map<String, dynamic> payload = user.toJson();

      await docRef.set(payload);
    } on firebase_core.FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<bool> getIsBanned() async {
    try {
      DocumentSnapshot doc = await docRef.get();
      return doc.get("isBanned") ?? false;
    } catch (e) {
      SnackbarMessage.showSnackbar(e.toString(), Colors.redAccent);
      return false;
    }
  }

  // Future<int> getSoruCount() async {
  //   return ((await docRef.get()).data() as Map<String, dynamic>)["soruCount"];
  // }
}
