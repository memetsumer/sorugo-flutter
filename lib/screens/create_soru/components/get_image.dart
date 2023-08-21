import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../utils/constants.dart';
import '../../../utils/show_img_menu.dart';

class GetImage extends StatefulWidget {
  final Function onSelectImage;
  final Function onDeleteImage;
  final String type;
  final bool error;

  const GetImage(
      {Key? key,
      required this.onSelectImage,
      required this.onDeleteImage,
      required this.error,
      required this.type})
      : super(key: key);

  @override
  State<GetImage> createState() => _GetImageState();
}

class _GetImageState extends State<GetImage> {
  File? image;

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
        //aspectRatio: const CropAspectRatio(ratioX: 9, ratioY: 16),
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Fotoğrafı Düzenle',
              toolbarColor: darkBackgroundColorSecondary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
              rotateButtonsHidden: true,
              title: 'Fotoğrafı Düzenle',
              doneButtonTitle: 'Bitti',
              cancelButtonTitle: 'İptal Et'),
        ],
      );

      if (croppedImage == null) {
        return;
      }
      File? imageToBeUploaded = File(croppedImage.path);

      widget.onSelectImage(imageToBeUploaded);

      setState(() {
        image = imageToBeUploaded;
      });
      // await imageTemporary.delete();
      // await croppedImage.delete();
    } catch (e) {
      if (kDebugMode) {
        print("Failed to pick image $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: _buildGetImage(),
      ),
    );
  }

  Widget _buildGetImage() {
    return Builder(builder: (BuildContext context) {
      return InkWell(
          borderRadius: BorderRadius.circular(defaultPadding),
          splashColor: Colors.purple.shade100.withOpacity(0.1),
          child: image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    image!,
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                )
              : AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 90,
                  height: 90,
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              !widget.error ? Colors.white24 : Colors.redAccent,
                          width: 2),
                      color: darkBackgroundColorSecondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(defaultPadding)),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/plus.svg",
                      height: 45,
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
          onTap: () {
            showImageMenu(
                context,
                pickImage,
                image,
                widget.onDeleteImage,
                () => setState(() {
                      image = null;
                    }));
          });
    });
  }
}
