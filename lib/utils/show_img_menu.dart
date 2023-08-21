import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as mbs;

import 'constants.dart';

Future<dynamic> showImageMenu(BuildContext context, Function pickImage,
    File? image, Function onDeleteImage, Function onDeleteImageState) {
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
                onTap: () {
                  pickImage(context, ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Galeri'),
                leading: SvgPicture.asset(
                  "assets/icons/gallery.svg",
                  height: 30,
                  color: Colors.white,
                ),
                onTap: () {
                  pickImage(context, ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              if (image != null)
                ListTile(
                  title: const Text('Resmi Sil'),
                  onTap: () {
                    onDeleteImageState();
                    onDeleteImage();
                    Navigator.pop(context);
                  },
                ),
              const SizedBox(height: defaultPadding * 6),
            ],
          ));
}
