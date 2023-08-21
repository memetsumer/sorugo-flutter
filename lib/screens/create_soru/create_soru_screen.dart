import 'dart:io';
import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yks_app/utils/snackbar_message.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as mbs;
import '../../utils/fab.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

import 'package:uuid/uuid.dart';

import '../../models/sorular/soru_manager.dart';
import '../../network/user/user_dao.dart';
import '../../utils/constants.dart';
import '../../../network/network.dart';
import '../components/component_titles.dart';
import './components/components.dart';
import '/screens/create_soru/components/get_cozum.dart';

class CreateSoruScreen extends StatefulWidget {
  const CreateSoruScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateSoruScreen> createState() => _CreateSoruScreenState();
}

class _CreateSoruScreenState extends State<CreateSoruScreen> {
  bool isButtonActive = true;

  bool isCozumChecked = false;
  bool disableCheckCozum = false;
  final _descriptionController = TextEditingController();
  String extraNote = "";
  bool errorSoru = false;
  bool errorDers = false;
  bool errorKonu = false;

  @override
  void initState() {
    FirebaseAnalytics.instance.logScreenView(
      screenName: 'CreateSoruScreen',
    );

    _descriptionController.addListener(() {
      setState(() {
        extraNote = _descriptionController.text.trim();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  final List<String> repeat = [
    'Tekrar Yok',
    'Haftalık',
    'Aylık',
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<SoruManager>().resetForPop();
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: Fab(
          onPressed: isButtonActive
              ? () async {
                  try {
                    await _sendSoru();
                  } catch (e) {
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
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
          title: Text("Soru Kaydet",
              style: Theme.of(context).textTheme.titleLarge),
          centerTitle: false,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  FadeInLeft(
                      duration: const Duration(milliseconds: 300),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const ComponentTitle(
                                    desc: "Soru", margTop: 0.0, margBot: 0.0),
                                GetImage(
                                  onSelectImage: _selectImageSoru,
                                  onDeleteImage: () {
                                    context.read<SoruManager>().delSoruImage();
                                  },
                                  type: "soru",
                                  error: errorSoru,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const ComponentTitle(
                                    desc: "Çözüm (Varsa)",
                                    margTop: 0.0,
                                    margBot: 0.0),
                                GetCozum(
                                    isCozumChecked: isCozumChecked,
                                    onSelectImage: _selectImageCozum,
                                    onDeleteImage: () {
                                      setState(() {
                                        disableCheckCozum = false;
                                      });
                                      context
                                          .read<SoruManager>()
                                          .delCozumImage();
                                    },
                                    type: "cozum"),
                              ],
                            ),
                          ])),
                  // const SizedBox(height: defaultPadding),
                  if (!disableCheckCozum)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Çözüm Sorunun Üzerinde.",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 13,
                                  ),
                        ),
                        Checkbox(
                          checkColor: Colors.black,
                          value: isCozumChecked,
                          activeColor: Colors.pinkAccent,
                          onChanged: (bool? value) {
                            setState(() {
                              isCozumChecked = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  const SizedBox(height: defaultPadding),
                  PanelToggleButtonDers(
                      btnText: "Ders...",
                      type: "ders",
                      error: errorDers,
                      openDialog: () {
                        openDialog("ders");
                      }),

                  const SizedBox(height: defaultPadding),
                  PanelToggleButtonKonu(
                      btnText: "Konu...",
                      type: "konu",
                      error: errorKonu,
                      openDialog: () {
                        openDialog("konu");
                      }),

                  const SizedBox(height: defaultPadding * 2),
                  const ComponentTitle(
                    desc: "Not (İsteğe Bağlı)",
                    margTop: 0,
                    margBot: 0.5,
                  ),

                  Center(
                      child: Container(
                    decoration: BoxDecoration(
                        color: darkBackgroundColorSecondary,
                        borderRadius:
                            BorderRadius.circular(defaultPadding / 2)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Form(
                        child: TextFormField(
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 13),
                          maxLines: null,
                          maxLength: 200,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.multiline,
                          controller: _descriptionController,
                          decoration: InputDecoration(
                              counterText: "",
                              hintText: "Bu kesin sınavda çıkar...",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 13),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none),
                        ),
                      ),
                    ),
                  )),

                  const ComponentTitle(
                    desc: "Önem Derecesi",
                    margTop: 1.5,
                    margBot: 0.5,
                  ),

                  const ImportanceSoruPicker(),

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
          child: typeOfPanel == "konu"
              ? const DialogKonu()
              : const DialogDersler(),
        ),
      );

  Future<void> _sendSoru() async {
    setState(() {
      isButtonActive = false;
    });
    final result = context.read<SoruManager>().validateSoru();

    if (result.isNotEmpty) {
      if (result.contains("soru")) {
        setState(() {
          errorSoru = true;
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              errorSoru = false;
            });
          });
        });
      }
      if (result.contains("ders")) {
        setState(() {
          errorDers = true;
        });
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            errorDers = false;
          });
        });
      }
      if (result.contains("konu")) {
        setState(() {
          errorKonu = true;
        });
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            errorKonu = false;
          });
        });
      }
      HapticFeedback.heavyImpact();
      SnackbarMessage.showSnackbar(
          "Gerekli Yerleri Lütfen Doldurunuz.", Colors.redAccent);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isButtonActive = true;
        });
      });
      // _showErrorToast(result);
      return;
    }

    var id = const Uuid().v4();

    final DateTime dueDate = DateTime.now();
    APISoruItem soruItem = APISoruItem(
      id: id,
      date: dueDate,
      ders: context.read<SoruManager>().selectedDers!.name,
      dersCode: context.read<SoruManager>().selectedDers!.code,
      konu: context.read<SoruManager>().selectedKonu,
      konuKind: context.read<SoruManager>().selectedKonuKind,
      importance: context.read<SoruManager>().importanceSoru,
      soruImage: context.read<SoruManager>().pickedImageSoru,
      cozumImage: context.read<SoruManager>().pickedImageCozum,
      extraNote: extraNote,
      hasCozum:
          context.read<SoruManager>().pickedImageCozum != null ? true : false,
      isCozumUzerinde: isCozumChecked,
      isComplete: true,
      frequency: repeat[context.read<SoruManager>().repeatNotification],
    );

    context.read<SoruManager>().setExtraNote("");

    await EasyLoading.showInfo('Kaydediliyor...', dismissOnTap: false);
    if (!mounted) return;
    FirebaseAnalytics.instance.logEvent(
      name: "save_soru",
      parameters: {
        "ders": context.read<SoruManager>().selectedDers!.name,
        "konu": context.read<SoruManager>().selectedKonu,
      },
    );
    SoruDao()
        .saveSoru(soruItem)
        ?.then((value) => UserDao().incrementSavedSoru())
        .timeout(const Duration(seconds: 2),
            onTimeout: () => SnackbarMessage.showSnackbar(
                "Soru yüklenemedi. İnternetiniz kontrol edin",
                Colors.redAccent));

    await EasyLoading.dismiss();
    if (!mounted) return;
    context.read<SoruManager>().resetForPop();
    Navigator.pop(context);
  }

  void _selectImageSoru(File pickedImage) {
    context.read<SoruManager>().setSoruImage(pickedImage);
  }

  void _selectImageCozum(File pickedImage) {
    setState(() {
      isCozumChecked = false;
      disableCheckCozum = true;
    });
    context.read<SoruManager>().setCozumImage(pickedImage);
  }
}
