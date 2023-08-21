import 'package:animations/animations.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/fab.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/adapters/ders/ders_adapter.dart';
import '../../models/adapters/tarama/tarama_adapter.dart';
import '../../models/sorular/soru_manager.dart';
import '../../utils/premium_function.dart';
import '../create_soru/create_soru_screen.dart';
import '../../utils/help_dialog.dart';
import '../sorular/components/sorular_list.dart';
import 'components/tarama_ekle.dart';
import '/utils/constants.dart';
import 'components/status_konu.dart';

class KonuScreen extends StatefulWidget {
  final String title;
  final Ders dersObj;
  final Map<String, String> konu;

  const KonuScreen({
    Key? key,
    required this.title,
    required this.konu,
    required this.dersObj,
  }) : super(key: key);

  @override
  State<KonuScreen> createState() => _KonuScreenState();
}

class _KonuScreenState extends State<KonuScreen> {
  @override
  void initState() {
    FirebaseAnalytics.instance.logScreenView(
      screenName: 'KonuScreen',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 17,
              ),
          overflow: TextOverflow.fade,
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: Fab(
        icon: SvgPicture.asset(
          "assets/icons/plus.svg",
          height: 36,
          color: Colors.grey.shade100,
        ),
        onPressed: () => premiumFunction(
            context,
            mounted,
            () => createSoru(
                context, widget.dersObj, widget.konu["name"] as String)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KonuStatsWidget(konu: widget.konu),
          Row(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                    right: defaultPadding, top: defaultPadding / 2),
                child: TextButton(
                  onPressed: () => premiumFunction(
                      context, mounted, () => taramaEkle(context)),
                  child: Text(
                    "Tarama Ekle",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.blueAccent),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          const Padding(
            padding:
                EdgeInsets.only(left: defaultPadding, bottom: defaultPadding),
            child: Text(
              "Kaydedilenler",
              style: TextStyle(fontSize: 19),
            ),
          ),
          Expanded(
            child: SorularListKonu(konuName: widget.konu["name"] as String),
          ),
        ],
      ),
    );
  }

  void createSoru(BuildContext context, Ders ders, String konu) {
    context.read<SoruManager>().setSelectedDers(ders);
    context.read<SoruManager>().setSelectedKonu(konu);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateSoruScreen(),
      ),
    );
  }

  Future<void> taramaEkle(BuildContext context) async {
    return await showModal(
        configuration: const FadeScaleTransitionConfiguration(
          transitionDuration: Duration(milliseconds: 300),
          reverseTransitionDuration: Duration(milliseconds: 300),
        ),
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: darkBackgroundColorSecondary,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            title: const Text(
              'Şu kadar soruyu bitirdim',
              textAlign: TextAlign.center,
            ),
            content: Wrap(
              alignment: WrapAlignment.center,
              spacing: 3,
              children: [
                TaramaEkle(
                  konu: widget.konu,
                  dersCode: widget.dersObj.code,
                  ders: widget.dersObj.name,
                )
              ],
            ),
          );
        });
  }
}

class KonuStatsWidget extends StatelessWidget {
  final Map<String, String> konu;

  const KonuStatsWidget({
    Key? key,
    required this.konu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Tarama>(dbTaramalar).listenable(),
        builder: (context, Box<Tarama> box, widget) {
          var total = 0;
          var lastMonthTotal = 0;
          var listLastMonth = [];
          var listTotal =
              box.values.toList().where((e) => e.konu == konu["name"]).toList();

          if (listTotal.isNotEmpty) {
            total = listTotal
                .map((e) => e.count)
                .reduce((value, element) => value + element);

            listLastMonth = listTotal
                .where((element) => DateTime.now()
                    .subtract(const Duration(days: 30))
                    .isBefore(element.createdAt))
                .toList();
            if (listLastMonth.isNotEmpty) {
              lastMonthTotal = listLastMonth
                  .map((e) => e.count)
                  .reduce((value, element) => value + element);
            }
          }

          return Column(
            children: [
              const SizedBox(
                height: defaultPadding,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  StatusKonu(
                    title: "Son 1 Ayda Çözülen",
                    value: lastMonthTotal,
                    helpTitle: "Son 1 ayda eklediğin taramalar",
                    helpMessage:
                        "Son 1 ayda çözdüğün toplam soru sayısını gösterir.",
                  ),
                  StatusKonu(
                    title: "Toplam Çözülen",
                    value: total,
                    helpTitle: "Toplam eklediğin taramalar",
                    helpMessage:
                        "En baştan beri çözdüğün toplam soru sayısını gösterir.",
                  ),
                ],
              ),
            ],
          );
        });
  }

  Future<void> showHelpDialog(context) async {
    return await showModal(
        configuration: const FadeScaleTransitionConfiguration(
          transitionDuration: Duration(milliseconds: 300),
          reverseTransitionDuration: Duration(milliseconds: 300),
        ),
        context: context,
        builder: (_) => const HelpDialog(
              title: "TYT Toplam Taramalar",
              message: "Bu derse ait toplam tarama sayısını gösterir.\n",
              message2: 'İstediğiniz konuya dokunup tarama ekleyebilirsiniz.',
            ));
  }
}
