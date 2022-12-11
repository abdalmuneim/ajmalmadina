import 'dart:io';

import 'package:butcity/core/error/failures.dart';
import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/resources/toast_manager.dart';
import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/core/widgets/image_pic.dart';
import 'package:butcity/features/auth_feature/domain/entities/user.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/get_user_use_case.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/user_update_use_case.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserUpdateController extends GetxController {
  final UserUpdateUseCase _userUpdateUseCase;
  final GetUserUseCase _userUseCase;

  UserUpdateController(this._userUpdateUseCase, this._userUseCase);

  User? user;

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  TextEditingController confPassCtrl = TextEditingController();

  bool isLoading = false;

  bool obscureTextPass = true;
  bool obscureTextPassCon = true;

  File? userImage;
  late String imageUrlUser;
  getImage() async {
    userImage = await ImagePic.showBottomSheetPic();
    update();
  }

  updateUser() async {
    isLoading = true;
    update();

    var result = await _userUpdateUseCase(
      name: nameCtrl.text,
      confirmPassword: confPassCtrl.text,
      password: passCtrl.text,
      image: userImage,
    );

    result.fold((failure) {
      if (failure.runtimeType == UnAuthenticatedFailure) {
        Get.offAllNamed(Routes.login);
      }
      isLoading = false;
      update();
      ToastManager.showError(mapFailureToMessage(failure));
    }, (right) {
      user = right;
      isLoading = false;
      update();
      ToastManager.showSuccess(LocaleKeys.successful);
      Get.offAllNamed(Routes.allCompilations);
    });

    isLoading = false;
    update();
  }

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

  @override
  void onInit() async {
    await userData();
    super.onInit();
  }
}
