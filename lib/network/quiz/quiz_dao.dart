import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/foundation.dart';
import 'package:flutter_yks_app/network/quiz/quiz_api.dart';
import 'package:flutter_yks_app/network/user/user_dao.dart';

class QuizDao {
  final CollectionReference colRef =
      FirebaseFirestore.instance.collection('leaderboards');

  Future<void>? saveQuiz(APIQuiz quiz) async {
    try {
      Map<String, dynamic> payload = quiz.toJson();

      bool isBanned = await UserDao().getIsBanned();

      if (!isBanned) {
        await colRef.doc(payload["id"]).set(payload);
      }
    } on firebase_core.FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future getQuiz(String id) {
    return colRef
        .where("id", isEqualTo: id)
        .get()
        .then((value) => value.docs[0].data());
  }

  Query<Map<String, dynamic>> getData() {
    Query<Object?> colRefTemp = colRef
        .orderBy("score", descending: true)
        .orderBy("date", descending: true);

    return colRefTemp as Query<Map<String, dynamic>>;
  }

  Stream<QuerySnapshot> getFirstThree() {
    return colRef
        .orderBy("score", descending: true)
        .orderBy("date", descending: true)
        .limit(3)
        .snapshots();
  }
}
