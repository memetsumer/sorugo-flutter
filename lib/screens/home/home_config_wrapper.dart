import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../models/adapters/exam/exam_adapter.dart';
import '../../utils/account/config_exam_social.dart';
import '../../utils/constants.dart';
import 'home_verify_wrapper.dart';

class HomeConfigWrapper extends StatefulWidget {
  const HomeConfigWrapper({Key? key}) : super(key: key);

  @override
  State<HomeConfigWrapper> createState() => _HomeConfigWrapperState();
}

class _HomeConfigWrapperState extends State<HomeConfigWrapper> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        Exam? exam = Hive.box<Exam>(dbExam)
            .get(examBox, defaultValue: Exam(name: "", code: ""));
        String? code = exam?.code;

        if (code == "") {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((DocumentSnapshot<Map<String, dynamic>> doc) {
            if (doc.exists) {
              String fbCode = doc.get(examUserDocument);

              if (fbCode != "" && mounted) {
                configExamSocial(context, mounted);
              }
            }
          });
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const HomeWrapper();
  }
}
