import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yks_app/utils/snackbar_message.dart';

import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../models/app_provider.dart';
import '/models/adapters/adapters.dart';
import '/network/net/net_item_dao.dart';
import '/network/user/user_api.dart';
import '/network/user/user_dao.dart';
import '/network/tarama/tarama_item_dao.dart';
import '../constants.dart';

import '../../network/ders/exam.dart' as fb_exam;
import '../../models/adapters/exam/exam_adapter.dart' as hive_exam;
import 'logout.dart';

Future<void> configExamSocial(BuildContext context, mounted) async {
  context.read<AppProvider>().setWait(true);
  DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();

  if (!doc.exists) {
    await UserDao().setUser(APIUser(
      soruSolved: 0,
      soruCount: 0,
      exam: "",
      premium: false,
      isBanned: false,
    ));
  } else {
    String userExam = doc.get(examUserDocument);

    if (userExam != "") {
      Hive.box<hive_exam.Exam>(dbExam).put(
        examBox,
        hive_exam.Exam(
          code: userExam,
          name: userExam,
        ),
      );

      final examRef = FirebaseFirestore.instance
          .collection(examsCollection)
          .doc(userExam)
          .withConverter(
            fromFirestore: (snapshot, _) =>
                fb_exam.Exam.fromFirestore(snapshot, _),
            toFirestore: (fb_exam.Exam exam, _) => exam.toFirestore(),
          );
      final docSnap = await examRef.get();

      fb_exam.Exam? exam = docSnap.data();

      if (exam != null) {
        Hive.box(dbSettings).put("date", exam.date);

        // List<Ders> dersler = [];
        List<Map<String, dynamic>> derslerOnlyTitle = [];
        List<Deneme> denemelerDb = [];

        for (var e in exam.dersler!) {
          var konular = e["konular"];
          List<Map<String, String>> newKonular = [];

          for (var konu in konular) {
            if (konu["name"] != null) {
              e["name"] != "Matematik"
                  ? newKonular.add(Map<String, String>.from(
                      {"name": konu["name"], "kind": konu["kind"]}))
                  : newKonular.add(Map<String, String>.from({
                      "name": konu["name"],
                      "kind": konu["kind"],
                      "geo": konu["geo"].toString()
                    }));
            }
          }

          Hive.lazyBox<Ders>(dbDersler).put(
            e["name"],
            Ders(
              code: e["code"],
              konular: newKonular,
              name: e["name"],
              ayt: e["ayt"],
            ),
          );

          derslerOnlyTitle.add(
            {
              "name": e["name"],
              "ayt": e["ayt"],
            },
          );
        }

        Hive.box(dbOnlyDersNames).putAll(derslerOnlyTitle.asMap());

        for (var deneme in exam.denemeler!) {
          String code = deneme["code"] as String;
          String name = deneme["name"] as String;
          String kind = deneme["kind"] as String;
          int total = deneme["total"] as int;

          var dersler = deneme["dersler"];

          List<Map<String, dynamic>>? denemeDersler = [];

          if (dersler != null) {
            for (var ders in dersler) {
              denemeDersler.add(
                Map<String, dynamic>.from(
                  {
                    "name": ders["name"] as String,
                    "code": ders["code"] as String,
                    "kind": ders["kind"] as String,
                    "total": ders["total"],
                  },
                ),
              );
            }
          }

          denemelerDb.add(
            Deneme(
              code: code,
              name: name,
              kind: kind,
              total: total,
              dersler: denemeDersler,
            ),
          );
        }

        await Hive.box<Deneme>(dbDenemeler).putAll(denemelerDb.asMap());

        // restore taramalar
        TaramaDao().getTaramalar().then((value) {
          for (var item in value!) {
            final data = item.toJson();

            Hive.box<Tarama>(dbTaramalar).add(
              Tarama(
                ders: data["ders"],
                dersCode: data["dersCode"],
                konu: data["konu"],
                count: data["count"],
                createdAt: DateTime.parse(data["createdAt"]),
                kind: data["kind"],
              ),
            );
          }
        });
        // restore netler
        NetDao().getNetler().then(
          (value) {
            for (var item in value!) {
              final data = item.toJson();

              Hive.box<DenemeStat>(dbDenemelerStat).add(
                DenemeStat(
                  dersName: data["dersName"],
                  dersCode: data["dersCode"],
                  ayt: data["ayt"],
                  dogru: data["dogru"],
                  yanlis: data["yanlis"],
                  sure: data["sure"],
                  createdAt: DateTime.parse(data["createdAt"]),
                ),
              );
            }
          },
        );

        await FirebaseMessaging.instance.subscribeToTopic(userExam);
        await FirebaseMessaging.instance
            .subscribeToTopic(mainNotificationTopic);
        await Hive.box(dbSettings).put(mainNotificationTopic, true);
        await Hive.box(dbSettings).put(examNotificationTopic, true);
      } else {
        SnackbarMessage.showSnackbar("Giriş Yapılırken Hata", Colors.red);

        if (mounted) logOut(context, false);
      }
    }
  }
}
