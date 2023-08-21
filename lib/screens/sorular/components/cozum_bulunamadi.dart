import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as mbs;

import '../../../network/soru/soru_item_dao.dart';
import '../../../utils/constants.dart';
import '../../components/sorugo_button.dart';

class CozumBulunamadi extends StatefulWidget {
  final String id;
  final bool cozum;
  final bool isCozumUzerinde;
  final bool isFab;
  const CozumBulunamadi(
      {Key? key,
      required this.id,
      required this.cozum,
      required this.isFab,
      required this.isCozumUzerinde})
      : super(key: key);

  @override
  State<CozumBulunamadi> createState() => _CozumBulunamadiState();
}

class _CozumBulunamadiState extends State<CozumBulunamadi> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return widget.isFab
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultPadding),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 12,
                  color: sorugoColor,
                )
              ],
            ),
            child: SorugoButton(
              onPress: () => showImageMenu(context, pickImage),
              text: "Çözüm Ekle",
              width: 120,
            ),
          )
        : Card(
            elevation: 2,
            color: darkBackgroundColorSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultPadding),
            ),
            child: AspectRatio(
              aspectRatio: 0.75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.isCozumUzerinde
                        ? 'Çözümü Sorunun Üzerinde!'
                        : 'Çözüm Bulunamadı.',
                    style: const TextStyle(
                      fontSize: 21.0,
                      color: Color.fromRGBO(203, 213, 255, 1),
                    ),
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  TextButton(
                    onPressed: () => showImageMenu(context, pickImage),
                    child: Text(
                      widget.isCozumUzerinde
                          ? "Ekstra Çözüm Ekle"
                          : "Hemen Çözümünü Ekle!",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.blueAccent,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  Future pickImage(BuildContext context, ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    try {
      final imageToBe =
          await picker.pickImage(source: source, imageQuality: 30);

      if (imageToBe == null) return;

      final imageTemporary = File(imageToBe.path);

      await EasyLoading.showInfo('Yükleniyor...', dismissOnTap: false);
      await EasyLoading.dismiss();

      final croppedImage = await ImageCropper().cropImage(
          sourcePath: imageTemporary.path,
          aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 5),
          // aspectRatio: CropAspectRatio(ratioX: 0.7, ratioY: 0.1),
          cropStyle: CropStyle.rectangle,
          uiSettings: [
            IOSUiSettings(
                rotateButtonsHidden: true,
                title: 'Fotoğrafı Düzenle',
                doneButtonTitle: 'Bitti',
                cancelButtonTitle: 'İptal Et'),
            AndroidUiSettings(
                toolbarTitle: 'Fotoğrafı Düzenle',
                toolbarColor: darkBackgroundColorSecondary,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false)
          ]);

      if (croppedImage == null) {
        return;
      }

      File? imageToBeUploaded = File(croppedImage.path);

      setState(() {
        image = imageToBeUploaded;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Failed to pick image $e");
      }
    }
  }

  Future? setCozum() {
    return SoruDao().setCozum(image, widget.id);
  }

  Future<dynamic> showImageMenu(BuildContext context, Function pickImage) {
    return mbs.showMaterialModalBottomSheet(
        backgroundColor: darkBackgroundColorSecondary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) => Wrap(
              children: [
                ListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  title: const Text('Kamera'),
                  leading: SvgPicture.asset(
                    "assets/icons/camera.svg",
                    height: 30,
                    color: Colors.white,
                  ),
                  onTap: () async {
                    try {
                      await pickImage(context, ImageSource.camera);
                      if (image != null) {
                        setCozum();
                      }
                    } catch (e) {
                      if (kDebugMode) {
                        print("Failed to set cozum $e");
                      }
                    }

                    if (mounted) {
                      Navigator.pop(context);
                    }
                  },
                ),
                ListTile(
                  title: const Text('Galeri'),
                  leading: SvgPicture.asset(
                    "assets/icons/gallery.svg",
                    height: 30,
                    color: Colors.white,
                  ),
                  onTap: () async {
                    try {
                      await pickImage(context, ImageSource.gallery);
                      if (image != null) {
                        setCozum();
                      }
                    } catch (e) {
                      if (kDebugMode) {
                        print("Failed to set cozum $e");
                      }
                    }

                    if (mounted) {
                      Navigator.pop(context);
                    }
                  },
                ),
                const SizedBox(height: defaultPadding * 6),
              ],
            ));
  }
}
