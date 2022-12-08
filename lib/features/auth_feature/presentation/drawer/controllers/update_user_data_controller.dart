import 'dart:io';

import 'package:butcity/core/error/failures.dart';
import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/resources/toast_manager.dart';
import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/core/widgets/image_pic.dart';
import 'package:butcity/features/auth_feature/domain/entities/user.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/get_user_use_case.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/update_user_use_case.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateUserController extends GetxController {
  final UpdateUserUseCase _updateUserUseCase;
  final GetUserUseCase _userUseCase;

  UpdateUserController(this._updateUserUseCase, this._userUseCase);

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
  late String imageUrlUser;
  getImage() async {
    userImage = await ImagePic.getImage();
    update();
  }

  User? user;

  userData() async {
    var result = await _userUseCase();

    result.fold((failure) {
      isLoading = false;
      update();
      if (failure.runtimeType == UnAuthenticatedFailure) {
        Get.offAllNamed(Routes.login);
      }
      ToastManager.showError(mapFailureToMessage(failure));
    }, (right) {
      user = right;
      nameCtrl.text = user!.name;
      emailCtrl.text = user!.email;
      imageUrlUser = user!.imageForWeb;
      update();
    });
  }

  String imageError = '';
  updateUser() async {
    isLoading = true;
    update();

    if (userImage != null) {
      var result = await _updateUserUseCase(
        name: nameCtrl.text,
        confirmPassword: confPassCtrl.text,
        password: passCtrl.text,
        imageForWeb: userImage!,
      );

      result.fold((failure) {
        isLoading = false;
        update();
        if (failure.runtimeType == UnAuthenticatedFailure) {
          Get.offAllNamed(Routes.login);
        }
        ToastManager.showError(
            mapFailureToMessage(failure)); // TODO:check here error
      }, (right) {
        user = right;

        update();
      });
    }
  }

  @override
  void onInit() async {
    await userData();
    super.onInit();
  }
}
