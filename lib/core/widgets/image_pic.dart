import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePic {
  static Future<File?> getImage() async {
    XFile? imageResult = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 20,
    );
    if (imageResult != null) {
      return File(imageResult.path);
    } else {
      return null;
    }
  }
}
