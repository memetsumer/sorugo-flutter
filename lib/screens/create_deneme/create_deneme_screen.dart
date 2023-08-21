import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import '../../network/net/net_item_api.dart';
import '../../network/net/net_item_dao.dart';
import '../../utils/snackbar_message.dart';
import '/models/adapters/deneme_stat/deneme_stat_adapter.dart';
import '/screens/components/sorugo_button.dart';
import '/utils/fab.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as mbs;
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:uuid/uuid.dart';

import '../../models/denemeler/deneme_manager.dart';
import 'components/components.dart';

import '../../utils/constants.dart';
import '../../../network/network.dart';
import '../components/components.dart';

class CreateDenemeScreen extends StatefulWidget {
  const CreateDenemeScreen({Key? key}) : super(key: key);

  @override
  State<CreateDenemeScreen> createState() => _CreateDenemeScreenState();
}

class _CreateDenemeScreenState extends State<CreateDenemeScreen> {
  bool isButtonActive = true;
  bool errorDenemeTur = false;
  bool errorTitle = false;
  bool errorNet = false;

  @override
  void initState() {
    FirebaseAnalytics.instance.logScreenView(
      screenName: 'CreateDenemeScreen',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<DenemeManager>().resetForPop();
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: Fab(
          onPressed: isButtonActive
              ? () async {
                  try {
                    await _sendDeneme();
                  } catch (e) {
                    // print(e);
                    // _showErrorToast(e.toString());
                  }
                }
              : () {},
          icon: SvgPicture.asset("assets/icons/check.svg",
              height: 30,
              color: isButtonActive
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColor.withOpacity(0.3)),
        ),
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  Center(
                    child: FadeInDown(
                      duration: const Duration(milliseconds: 500),
                      child: const SliderDenemeTime(),
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Doğru",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.greenAccent,
                            ),
                          ),
                          Text(
                            "${context.watch<DenemeManager>().getNetler['dogru']}",
                            style: const TextStyle(
                              fontSize: 45,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Yanlış",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.redAccent,
                              )),
                          Text(
                              "${context.watch<DenemeManager>().getNetler['yanlis']}",
                              style: const TextStyle(
                                fontSize: 45,
                                color: Colors.redAccent,
                              )),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Net",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 24,
                                    ),
                          ),
                          Text(
                            "${context.watch<DenemeManager>().getNetler['net']}",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 45,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  AnimatedCrossFade(
                    firstChild: const SizedBox(
                      height: defaultPadding,
                    ),
                    secondChild: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: SorugoButton(
                        width: 120,
                        text: "Netleri Ekle",
                        error: errorNet,
                        onPress: () {
                          mbs.showMaterialModalBottomSheet(
                              backgroundColor: darkBackgroundColorSecondary,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(defaultPadding * 2),
                                      topRight:
                                          Radius.circular(defaultPadding * 2))),
                              context: context,
                              builder: (context) => const DialogNetler());
                        },
                      ),
                    )),
                    crossFadeState:
                        context.watch<DenemeManager>().getDeneme == null
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 300),
                  ),
                  const ComponentTitle(
                    desc: "Deneme Adı",
                    margTop: 0,
                    margBot: 0.5,
                  ),
                  Center(
                    child: SorugoSubmitForm(
                      hintText: "XY Yayının Z Denemesi...",
                      maxLength: 18,
                      error: errorTitle,
                    ),
                  ),
                  const SizedBox(height: defaultPadding),
                  const ComponentTitle(
                    desc: "Deneme Türü",
                    margTop: 0,
                    margBot: 0.5,
                  ),
                  PanelToggleButtonDeneme(
                    btnText: context.read<DenemeManager>().getDeneme == null
                        ? "Deneme Ekle"
                        : context.read<DenemeManager>().getDeneme!.name,
                    openDialog: () {
                      openDialog("denemeTuru");
                    },
                    error: errorDenemeTur,
                  ),
                  const SizedBox(height: defaultPadding),
                  const ComponentTitle(
                    desc: "Zorluk Derecesi",
                    margTop: 1,
                    margBot: 0.5,
                  ),
                  const ImportanceDenemePicker(),
                  const SizedBox(
                    height: defaultPadding * 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future openDialog(String typeOfPanel) => mbs.showMaterialModalBottomSheet(
        backgroundColor: darkBackgroundColorSecondary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) => Container(
            constraints: const BoxConstraints(
              maxHeight: 500,
            ),
            child: typeOfPanel == 'denemeTuru'
                ? const DialogDenemeTurleri()
                : const DialogNetler()),
      );

  AppBar _buildAppBar(context) {
    return AppBar(
      elevation: 0,
      iconTheme: IconThemeData(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      title: Text("Deneme Ekle", style: Theme.of(context).textTheme.titleLarge),
      centerTitle: false,
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> _sendDeneme() async {
    setState(() {
      isButtonActive = false;
    });
    final result = context.read<DenemeManager>().validateDeneme();
    if (result.isNotEmpty) {
      if (result.contains("title")) {
        setState(() {
          errorTitle = true;
        });
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            errorTitle = false;
          });
        });
      }
      if (result.contains("deneme")) {
        setState(() {
          errorDenemeTur = true;
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              errorDenemeTur = false;
            });
          });
        });
      }
      if (result.contains("net")) {
        setState(() {
          errorNet = true;
        });
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            errorNet = false;
          });
        });
      }
      HapticFeedback.heavyImpact();
      SnackbarMessage.showSnackbar(
          "Gerekli Yerleri Lütfen Doldurunuz.", Colors.redAccent);
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          isButtonActive = true;
        });
      });
      // _showErrorToast(result);
      return;
    }

    await EasyLoading.showInfo('Kaydediliyor...', dismissOnTap: false);

    if (!mounted) return;

    final DateTime now = DateTime.now();

    APIDenemeItem denemeItem = APIDenemeItem(
      date: DateTime.now(),
      id: const Uuid().v4(),
      title: context.read<DenemeManager>().getTitle,
      extraNote: context.read<DenemeManager>().extraNote,
      denemeTuru: context.read<DenemeManager>().getDeneme!.name,
      sure: context.read<DenemeManager>().getDenemeSure,
      netler: context.read<DenemeManager>().allNetData,
      dogru: context.read<DenemeManager>().getNetler['dogru'],
      yanlis: context.read<DenemeManager>().getNetler['yanlis'],
      net: context.read<DenemeManager>().getNetler['net'],
      ayt: context.read<DenemeManager>().getDeneme!.kind == "ayt",
      importance: context.read<DenemeManager>().importanceDeneme,
    );
    FirebaseAnalytics.instance.logEvent(
      name: "save_deneme",
      parameters: {
        "tur": context.read<DenemeManager>().getDeneme!.name,
        "title": context.read<DenemeManager>().getTitle,
        "ayt":
            (context.read<DenemeManager>().getDeneme!.kind == "ayt").toString(),
        "dogru": context.read<DenemeManager>().getNetler['dogru'],
        "yanlis": context.read<DenemeManager>().getNetler['yanlis'],
      },
    );
    DenemeDao().saveDeneme(denemeItem);

    if (context.read<DenemeManager>().getDeneme!.dersler!.isNotEmpty) {
      for (var ders in context.read<DenemeManager>().getDeneme!.dersler!) {
        if (context
            .read<DenemeManager>()
            .allNetData
            .where((element) => element["denemeName"] == ders["name"])
            .isEmpty) {
          // First, save to the firestore
          NetDao().saveNet(
            APINetItem(
              dersName: ders["name"],
              dersCode: ders["code"],
              ayt: ders["kind"] == "ayt",
              dogru: 0,
              yanlis: 0,
              sure: context.read<DenemeManager>().getDenemeSure.toInt(),
              createdAt: now,
            ),
          );

          // Then, save to the local database
          Hive.box<DenemeStat>(dbDenemelerStat).add(
            DenemeStat(
              dersName: ders["name"],
              dersCode: ders["code"],
              ayt: ders["kind"] == "ayt",
              dogru: 0,
              yanlis: 0,
              sure: context.read<DenemeManager>().getDenemeSure.toInt(),
              createdAt: now,
            ),
          );
        } else {
          NetDao().saveNet(
            APINetItem(
              dersName: ders["name"],
              dersCode: ders["code"],
              ayt: ders["kind"] == "ayt",
              dogru: context
                      .read<DenemeManager>()
                      .allNetData
                      .where((element) => element["denemeName"] == ders["name"])
                      .toList()
                      .first["netler"]["dogru"] ??
                  0,
              yanlis: context
                      .read<DenemeManager>()
                      .allNetData
                      .where((element) => element["denemeName"] == ders["name"])
                      .toList()
                      .first["netler"]["yanlis"] ??
                  0,
              sure: context.read<DenemeManager>().getDenemeSure.toInt(),
              createdAt: now,
            ),
          );
          Hive.box<DenemeStat>(dbDenemelerStat).add(
            DenemeStat(
              dersName: ders["name"],
              dersCode: ders["code"],
              ayt: ders["kind"] == "ayt",
              dogru: context
                      .read<DenemeManager>()
                      .allNetData
                      .where((element) => element["denemeName"] == ders["name"])
                      .toList()
                      .first["netler"]["dogru"] ??
                  0,
              yanlis: context
                      .read<DenemeManager>()
                      .allNetData
                      .where((element) => element["denemeName"] == ders["name"])
                      .toList()
                      .first["netler"]["yanlis"] ??
                  0,
              sure: context.read<DenemeManager>().getDenemeSure.toInt(),
              createdAt: now,
            ),
          );
        }
      }
    } else {
      NetDao().saveNet(
        APINetItem(
          dersName: context.read<DenemeManager>().getDeneme!.name,
          dersCode: context.read<DenemeManager>().getDeneme!.code.substring(
              0, context.read<DenemeManager>().getDeneme!.code.length - 4),
          ayt: context.read<DenemeManager>().getDeneme!.kind == "ayt",
          dogru: context.read<DenemeManager>().getNetler['dogru'],
          yanlis: context.read<DenemeManager>().getNetler['yanlis'],
          sure: context.read<DenemeManager>().getDenemeSure.toInt(),
          createdAt: now,
        ),
      );
      Hive.box<DenemeStat>(dbDenemelerStat).add(
        DenemeStat(
          dersName: context.read<DenemeManager>().getDeneme!.name,
          dersCode: context.read<DenemeManager>().getDeneme!.code.substring(
              0, context.read<DenemeManager>().getDeneme!.code.length - 4),
          ayt: context.read<DenemeManager>().getDeneme!.kind == "ayt",
          dogru: context.read<DenemeManager>().getNetler['dogru'],
          yanlis: context.read<DenemeManager>().getNetler['yanlis'],
          sure: context.read<DenemeManager>().getDenemeSure.toInt(),
          createdAt: now,
        ),
      );
    }
    if (!mounted) return;
    context.read<DenemeManager>().resetForPop();

    await EasyLoading.dismiss();
    if (!mounted) return;
    Navigator.pop(context);
  }
}
