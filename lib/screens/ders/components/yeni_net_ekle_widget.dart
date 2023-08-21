import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yks_app/network/net/net_item_api.dart';
import 'package:flutter_yks_app/network/net/net_item_dao.dart';
import 'package:flutter_yks_app/utils/snackbar_message.dart';
import '/models/denemeler/deneme_manager.dart';
import '/utils/constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../models/adapters/adapters.dart';
import 'net_form_ders.dart';

class YeniNetEkle extends StatefulWidget {
  final Ders ders;

  const YeniNetEkle({
    Key? key,
    required this.ders,
  }) : super(key: key);

  @override
  State<YeniNetEkle> createState() => _YeniNetEkleState();
}

class _YeniNetEkleState extends State<YeniNetEkle> {
  Exam exam = Exam.tyt;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Deneme>(dbDenemeler).listenable(),
        builder: (context, Box<Deneme> box, _) {
          final denemeler = box.values.toList();

          Deneme deneme;
          int total;

          if (widget.ders.name == "Edebiyat") {
            deneme = denemeler
                .where((element) => exam != Exam.tyt
                    ? element.code == "tyt"
                    : element.code == "ayt")
                .first;

            Map<String, dynamic> dbDersFromDeneme = deneme.dersler!
                .where((element) => element["code"] == widget.ders.code)
                .first;

            total = dbDersFromDeneme["total"] as int;
          } else {
            deneme = denemeler
                .where((element) => exam == Exam.tyt
                    ? element.code == "tyt"
                    : element.code == "ayt")
                .first;

            Map<String, dynamic> dbDersFromDeneme = deneme.dersler!
                .where((element) => element["code"] == widget.ders.code)
                .first;

            total = dbDersFromDeneme["total"] as int;
          }

          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 3,
            children: [
              if (widget.ders.ayt == true && widget.ders.name != "Edebiyat")
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Text(Exam.tyt.name.toUpperCase()),
                    Radio(
                        value: Exam.tyt,
                        groupValue: exam,
                        onChanged: (e) {
                          context.read<DenemeManager>().resetDersNetData();

                          setState(() {
                            exam = Exam.tyt;
                          });
                        }),
                    const Spacer(),
                    Text(Exam.ayt.name.toUpperCase()),
                    Radio(
                      value: Exam.ayt,
                      groupValue: exam,
                      onChanged: (e) {
                        context.read<DenemeManager>().resetDersNetData();

                        setState(() {
                          exam = Exam.ayt;
                        });
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              Wrap(
                children: [
                  NetFormDers(
                    dersName: "dersName",
                    soruCount: total,
                  ),
                  Row(
                    children: [
                      Text(
                        "Tek seferde en fazla $total net girilebilir.",
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: defaultPadding * 3,
                  ),
                  // Tooltip(),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "İptal",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.redAccent,
                                  ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (!((context
                                      .read<DenemeManager>()
                                      .getDersNetData["dogru"] as int) ==
                                  0 &&
                              (context
                                      .read<DenemeManager>()
                                      .getDersNetData["yanlis"] as int) ==
                                  0)) {
                            DateTime now = DateTime.now();
                            FirebaseAnalytics.instance.logEvent(
                              name: "save_deneme",
                              parameters: {
                                "ders": widget.ders.name,
                                "ayt": (exam == Exam.ayt ||
                                        widget.ders.name == "Edebiyat")
                                    .toString(),
                                "dogru": context
                                    .read<DenemeManager>()
                                    .getDersNetData["dogru"] as int,
                                "yanlis": context
                                    .read<DenemeManager>()
                                    .getDersNetData["yanlis"] as int,
                              },
                            );
                            NetDao().saveNet(
                              APINetItem(
                                dersName: widget.ders.name,
                                dersCode: widget.ders.code,
                                ayt: exam == Exam.ayt ||
                                    widget.ders.name == "Edebiyat",
                                dogru: context
                                    .read<DenemeManager>()
                                    .getDersNetData["dogru"] as int,
                                yanlis: context
                                    .read<DenemeManager>()
                                    .getDersNetData["yanlis"] as int,
                                createdAt: now,
                              ),
                            );
                            Hive.box<DenemeStat>(dbDenemelerStat).add(
                              DenemeStat(
                                dersName: widget.ders.name,
                                dersCode: widget.ders.code,
                                ayt: exam == Exam.ayt ||
                                    widget.ders.name == "Edebiyat",
                                dogru: context
                                    .read<DenemeManager>()
                                    .getDersNetData["dogru"] as int,
                                yanlis: context
                                    .read<DenemeManager>()
                                    .getDersNetData["yanlis"] as int,
                                createdAt: now,
                              ),
                            );
                            context.read<DenemeManager>().resetDersNetData();

                            SnackbarMessage.showSnackbar(
                                "Netler Başarıyla Kaydedildi!",
                                Colors.greenAccent);

                            Navigator.pop(context);
                          } else {
                            Navigator.pop(context);
                            SnackbarMessage.showSnackbar(
                                "Lütfen doğru ve yanlış sayılarını giriniz.",
                                Colors.redAccent);
                          }
                        },
                        child: Text(
                          "Kaydet",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Colors.blueAccent,
                                  ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          );
        });
  }
}

enum Exam { tyt, ayt }
