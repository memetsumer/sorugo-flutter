import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yks_app/models/app_provider.dart';
import 'package:flutter_yks_app/models/first_time_provider.dart';
import 'package:flutter_yks_app/utils/account/logout.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../network/user/user_api.dart';
import '/models/adapters/deneme/deneme_adapter.dart';
import '/models/adapters/ders/ders_adapter.dart';
import '/utils/snackbar_message.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../network/ders/exam.dart' as fb_exam;
import '../../models/adapters/exam/exam_adapter.dart' as hive_exam;
import '../../network/user/user_dao.dart';
import '/utils/constants.dart';

class ChooseExamScreen extends StatefulWidget {
  const ChooseExamScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ChooseExamScreen> createState() => _ChooseExamScreenState();
}

class _ChooseExamScreenState extends State<ChooseExamScreen> {
  final List<Map<String, String>> services = [
    {
      "name": "YKS Sayısal",
      "code": examSayisal,
    },
    {
      "name": "YKS Sözel",
      "code": examSozel,
    },
    {
      "name": "YKS Eşit Ağırlık",
      "code": examEsit,
    },
  ];

  int selected = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      floatingActionButton: selected >= 0
          ? FadeInRight(
              duration: const Duration(milliseconds: 500),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: _setExam,
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            )
          : null,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.read<FirstTimeProvider>().goUserNameForm();
          },
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.only(
                  top: defaultPadding * 10,
                  left: defaultPadding * 2,
                  right: defaultPadding * 2,
                ),
                child: Text(
                  "Hangi Sınava Çalışmak İstiyorsun?",
                  style: GoogleFonts.poppins(
                      fontSize: 29,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade100,
                      shadows: const [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 12,
                        )
                      ]),
                ),
              )),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
            child: Column(children: [
              Expanded(
                child: ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: FadeInLeft(
                      duration: Duration(milliseconds: 300 + index * 200),
                      child: GestureDetector(
                        onTap: (() async {
                          setState(() {
                            selected = index;
                          });
                        }),
                        child: _buildItem(index),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
          border: index == selected
              ? Border.all(color: Colors.white24, width: 2)
              : Border.all(color: Colors.white24, width: 2),
          color: index == selected
              ? Colors.black.withOpacity(0.3)
              : Colors.grey.shade100.withOpacity(0.1),
          borderRadius: BorderRadius.circular(defaultPadding)),
      child: Center(
        child: Text(
          services[index]["name"] as String,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontSize: 18,
              ),
        ),
      ),
    );
  }

  Future<void> _setExam() async {
    try {
      context.read<AppProvider>().setFirstTime(true);
      await EasyLoading.showInfo(
        'Sınav Ayarlanıyor...',
        dismissOnTap: false,
        maskType: EasyLoadingMaskType.black,
      );
      await UserDao().setUser(APIUser(
        soruSolved: 0,
        soruCount: 0,
        exam: "",
        premium: false,
        isBanned: false,
      ));

      await UserDao().setExam(services[selected]["code"] as String).then(
            (value) => Hive.box<hive_exam.Exam>(dbExam).put(
              examBox,
              hive_exam.Exam(
                code: services[selected]["code"] as String,
                name: services[selected]["name"] as String,
              ),
            ),
          );

      await FirebaseAnalytics.instance.setUserProperty(
        name: examUserDocument,
        value: services[selected]["code"] as String,
      );

      await FirebaseMessaging.instance
          .subscribeToTopic(services[selected]["code"] as String);
      await FirebaseMessaging.instance.subscribeToTopic(mainNotificationTopic);
      await Hive.box(dbSettings).put(mainNotificationTopic, true);
      await Hive.box(dbSettings).put(examNotificationTopic, true);

      final ref = FirebaseFirestore.instance
          .collection(examsCollection)
          .doc(services[selected]["code"])
          .withConverter(
            fromFirestore: (snapshot, _) =>
                fb_exam.Exam.fromFirestore(snapshot, _),
            toFirestore: (fb_exam.Exam exam, _) => exam.toFirestore(),
          );
      final docSnap = await ref.get();

      fb_exam.Exam? exam = docSnap.data();

      if (exam != null) {
        await Hive.box(dbSettings).put("date", exam.date);

        await UserDao().setDersler({
          "dersler": exam.toFirestore()["dersler"],
        });

        List<Map<String, dynamic>> derslerOnlyTitle = [];
        List<Deneme> denemelerDb = [];

        List<Map<String, dynamic>>? denemeler = exam.denemeler;

        if (denemeler != null) {
          for (var deneme in denemeler) {
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
        }

        for (var e in exam.dersler!) {
          var konular = e["konular"];
          // print(konular);
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

        Hive.box<Deneme>(dbDenemeler).putAll(denemelerDb.asMap());
        Hive.box(dbOnlyDersNames).putAll(derslerOnlyTitle.asMap());
      } else {
        SnackbarMessage.showSnackbar("Giriş Yapılırken Hata", Colors.red);
        if (mounted) return;
        logOut(context, false);
      }

      EasyLoading.dismiss();
    } catch (e) {
      SnackbarMessage.showSnackbar("Fatal Error: $e", Colors.red);
    }
  }
}
