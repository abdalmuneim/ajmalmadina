import 'package:butcity/core/resources/toast_manager.dart';
import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/login_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final LoginUseCase _loginUseCase;

  final TextEditingController emailCtrl = TextEditingController(text: '');
  final TextEditingController passwordCtrl = TextEditingController(text: '');

  bool isLoading = false;
  bool obscureText = true;

  LoginController(this._loginUseCase);

  void login() async {
    isLoading = true;
    update();

    final response =
        await _loginUseCase(email: emailCtrl.text, password: passwordCtrl.text);
    isLoading = false;

    response.fold((failure) {
      update();
      ToastManager.showError(failure.message);
    }, (result) {
      Get.offAllNamed(Routes.allCompilations, arguments: result);
    });
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }
}
