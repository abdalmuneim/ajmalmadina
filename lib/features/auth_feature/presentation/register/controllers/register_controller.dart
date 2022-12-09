// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/core/widgets/image_pic.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/register_use_case.dart';
import 'package:butcity/core/resources/toast_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController {
  final RegisterUseCase _registerUseCase;
  RegisterController(this._registerUseCase);

  TextEditingController nameCtrl = TextEditingController(text: '');
  TextEditingController emailCtrl = TextEditingController(text: '');
  TextEditingController passCtrl = TextEditingController(text: '');
  TextEditingController confPassCtrl = TextEditingController(text: '');

  String nameError = '';
  String emailError = '';
  String passwordError = '';
  String confirmPasswordError = '';
  String nameOrEmailOrPassOrConfirmPasswordError = '';

  bool isLoading = false;
  bool obscureTextPass = true;
  bool obscureTextPassCon = true;

  File? userImage;
  getImage() async {
    userImage = await ImagePic.showBottomSheetPic();
    update();
  }

  /// Register Function post data
  void register() async {
    isLoading = true;
    update();

    final response = await _registerUseCase(
        confirmPassword: confPassCtrl.text,
        email: emailCtrl.text,
        imageForWeb: userImage!,
        name: nameCtrl.text,
        password: passCtrl.text);
    isLoading = false;

    response.fold((failure) {
      update();
      ToastManager.showError(failure.message);
    }, (result) {
      Get.offAllNamed(Routes.allCompilations, arguments: result);
    });
  }
}
