// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/register_use_case.dart';
import 'package:butcity/core/resources/toast_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/language/app_translations.dart';

class RegisterController extends GetxController {
  TextEditingController nameCtrl = TextEditingController(text: '');
  TextEditingController emailCtrl = TextEditingController(text: '');
  TextEditingController passCtrl = TextEditingController(text: '');
  TextEditingController confPassCtrl = TextEditingController(text: '');
  final RegisterUseCase _registerUseCase;
  String nameError = '';
  String emailError = '';
  String passwordError = '';
  String confirmPasswordError = '';
  String nameOrEmailOrPassOrConfirmPasswordError = '';

  bool isLoading = false;
  RegisterController(this._registerUseCase);
  bool obscureTextPass = true;
  bool obscureTextPassCon = true;

  /// on change Name for text Form filed
  void changeNameText(String value) {
    if (value.isEmpty) {
      nameError = LocaleKeys.incorrectNameAddress.tr;
      update();
    } else {
      nameError = '';
      update();
    }
  }

  /// on change Email for text Form filed
  void changeEmailText(String value) {
    if (!value.isEmail || value.isEmpty) {
      emailError = LocaleKeys.incorrectEmailAddress.tr;
      update();
    } else {
      emailError = '';
      update();
    }
  }

  /// on change Pass text Form filed
  void changePassText(String value) {
    if (passwordError.isNotEmpty) {
      passwordError = '';
      update();
    }
  }

  void changeObscureTextPass() {
    obscureTextPass = !obscureTextPass;
  }

  void changeObscureTextPassCon() {
    obscureTextPassCon = !obscureTextPassCon;
  }

  /// on change ConfirmPass for text Form filed
  void changeConfPassText(String value) {
    if (confirmPasswordError.isEmpty) {
      confirmPasswordError = LocaleKeys.validateError.tr;
      update();
    } else if (value != passCtrl.text) {
      confirmPasswordError = LocaleKeys.confirmPassValidate.tr;
      update();
    } else {
      confirmPasswordError = '';
      update();
    }
  }

  /// Register Function post data
  void register() async {
    isLoading = true;
    update();
    final response = await _registerUseCase(
        confirmPassword: confPassCtrl.text,
        email: emailCtrl.text,
        name: nameCtrl.text,
        password: passCtrl.text);
    isLoading = false;

    response.fold((failure) {
      update();
      ToastManager.showError(failure.message);
    }, (result) {
      Get.offAllNamed(Routes.compilations, arguments: result);
    });
  }
}
