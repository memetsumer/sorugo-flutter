import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yks_app/utils/snackbar_message.dart';

import './soru_item_api.dart';

class SoruDao {
  final CollectionReference colRef = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("kSorular");

  final firebase_storage.Reference storeRef = firebase_storage
      .FirebaseStorage.instance
      .ref('users')
      .child(FirebaseAuth.instance.currentUser!.uid);

  Future<String?> getSoruImage(String id) async {
    try {
      return await storeRef.child(id).child("soru").getDownloadURL();
    } on firebase_core.FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return null;
    }
  }

  Future<String> getCozumImage(String id) async {
    return await storeRef.child(id).child("cozum").getDownloadURL();
  }

  Future<void>? saveSoru(APISoruItem soru) async {
    try {
      Map<String, dynamic> payload = soru.toJson();

      final soruImage = soru.soruImage;
      final cozumImage = soru.cozumImage;

      if (soruImage != null) {
        final uploadTaskSoru =
            storeRef.child(payload["id"]).child("soru").putFile(soruImage);

        uploadTaskSoru.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
          switch (taskSnapshot.state) {
            case TaskState.running:
              break;
            case TaskState.paused:
              break;
            case TaskState.canceled:
              break;
            case TaskState.error:
              SnackbarMessage.showSnackbar(
                  "Soru yüklenirken hata oluştu.", Colors.redAccent);
              break;
            case TaskState.success:
              colRef.doc(payload["id"]).set(payload);
              SnackbarMessage.showSnackbar(
                  "Soru başarıyla yüklendi!", Colors.greenAccent);
              break;
          }
        });
      }
      if (cozumImage != null) {
        storeRef.child(payload["id"]).child("cozum").putFile(cozumImage);
      }
    } on firebase_core.FirebaseException catch (e) {
      SnackbarMessage.showSnackbar(
          "Soru yüklenirken hata oluştu.", Colors.redAccent);
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void>? updateNote(String id, String note) async {
    try {
      await colRef.doc(id).update({
        "extraNote": note,
      });
    } on firebase_core.FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void>? setCozum(File? cozumImage, String id) async {
    try {
      if (cozumImage != null) {
        final uploadTaskCozum =
            storeRef.child(id).child("cozum").putFile(cozumImage);
        uploadTaskCozum
            .timeout(const Duration(seconds: 5),
                onTimeout: () => throw "timeout")
            .catchError((err) {
          SnackbarMessage.showSnackbar(
              "Çözüm yüklenemedi, interneti kontrol edin.", Colors.redAccent);
          return uploadTaskCozum;
        });

        uploadTaskCozum.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
          switch (taskSnapshot.state) {
            case TaskState.running:
              break;
            case TaskState.paused:
              break;
            case TaskState.canceled:
              break;
            case TaskState.error:
              SnackbarMessage.showSnackbar(
                  "Çözüm yüklenirken hata oluştu.", Colors.redAccent);
              break;
            case TaskState.success:
              colRef.doc(id).update({
                "hasCozum": true,
              });
              SnackbarMessage.showSnackbar(
                  "Çözüm başarıyla yüklendi!", Colors.greenAccent);
              break;
          }
        });
      }
    } on firebase_core.FirebaseException catch (e) {
      SnackbarMessage.showSnackbar(
          "Çözüm yüklenemedi, interneti kontrol edin.", Colors.redAccent);
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void>? deleteSoru(String id) async {
    try {
      await storeRef.child(id).child("soru").delete();
      await colRef.doc(id).delete();
    } on firebase_core.FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void>? deleteCozumImage(String id) async {
    try {
      await storeRef.child(id).child("cozum").delete();
    } on firebase_core.FirebaseException catch (e) {
      if (kDebugMode) {
        print(e.code);
      }
    }
  }

  Future getSoru(String id) {
    return colRef
        .where("id", isEqualTo: id)
        .get()
        .then((value) => value.docs[0].data());
  }

  Query<Map<String, dynamic>> getData(Map<String, dynamic> query) {
    Query<Object?> colRefTemp = colRef.orderBy("date", descending: true);

    if (query["ders"] == "Tümü") {
      return colRefTemp as Query<Map<String, dynamic>>;
    }

    query.forEach((key, value) {
      if (value != '' && value != 'Tümü') {
        if (value == false) {
          colRefTemp = colRefTemp.where('hasCozum', isEqualTo: false);
        }
        if (value == true) {
          colRefTemp = colRefTemp.where('hasCozum', isEqualTo: true);
        } else {
          colRefTemp = colRefTemp.where(key, isEqualTo: value);
        }
      }
    });

    return colRefTemp as Query<Map<String, dynamic>>;
  }

  Query<Map<String, dynamic>> getDataKonu(String konuName) {
    Query<Object?> colRefTemp = colRef.orderBy("date", descending: true);

    colRefTemp = colRefTemp.where("konu", isEqualTo: konuName);

    return colRefTemp as Query<Map<String, dynamic>>;
  }
}
