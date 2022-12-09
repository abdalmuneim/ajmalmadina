import 'dart:io';

import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePic {
  static Future<File?> _getImage(ImageSource source) async {
    XFile? imageResult = await ImagePicker().pickImage(
      source: source,
      imageQuality: 20,
    );
    if (imageResult != null) {
      return File(imageResult.path);
    } else {
      return null;
    }
  }

  static Future<File?> showBottomSheetPic() async => await Get.bottomSheet(
        Container(
          color: Colors.white,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// camera
              InkWell(
                onTap: () async {
                  var result = await _getImage(ImageSource.camera);
                  print(result?.path);
                  Get.back(result: result);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.camera,
                      color: Colors.green,
                      size: 50,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      text: LocaleKeys.camera.tr,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              /// gallery
              InkWell(
                onTap: () async {
                  await _getImage(ImageSource.gallery);
                  if (Get.isBottomSheetOpen ?? false) {
                    Get.back();
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.image,
                      color: Colors.green,
                      size: 50,
                    ),
                    const SizedBox(height: 5),
                    CustomText(
                      text: LocaleKeys.gallery.tr,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
