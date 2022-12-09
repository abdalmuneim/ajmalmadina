// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:butcity/core/error/failures.dart';
import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/features/auth_feature/domain/entities/user.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/get_user_use_case.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/logout_use_case.dart';
import 'package:butcity/core/resources/toast_manager.dart';
import 'package:get/get.dart';

class MyDrawerController extends GetxController {
  LogOutUseCase logOutUseCase;
  GetUserUseCase getUserUseCase;

  MyDrawerController({
    required this.logOutUseCase,
    required this.getUserUseCase,
  });

  bool isLoading = false;

  logOut() async {
    isLoading = true;
    update();
    var result = await logOutUseCase();

    result.fold((failure) {
      isLoading = false;
      update();
      if (failure.runtimeType == UnAuthenticatedFailure) {
        Get.offAllNamed(Routes.login);
      }
      ToastManager.showError(mapFailureToMessage(failure));
    }, (right) {
      isLoading = false;
      update();
      Get.offAllNamed(Routes.login);
    });
  }

  User? user;

  userData() async {
    var result = await getUserUseCase();

    result.fold((failure) {
      isLoading = false;
      update();
      if (failure.runtimeType == UnAuthenticatedFailure) {
        Get.offAllNamed(Routes.login);
      }
      ToastManager.showError(mapFailureToMessage(failure));
    }, (right) {
      user = right;
      update();
    });
  }

  @override
  Future<void> onInit() async {
    await userData();
    super.onInit();
  }
}
