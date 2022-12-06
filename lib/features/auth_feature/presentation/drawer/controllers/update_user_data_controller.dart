import 'dart:io';

import 'package:butcity/core/error/failures.dart';
import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/resources/toast_manager.dart';
import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/core/widgets/image_pic.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/update_user_use_case.dart';
import 'package:get/get.dart';

class UpdateUserController extends GetxController {
  UpdateUserUseCase updateUserUseCase;
  UpdateUserController(this.updateUserUseCase);

  File? userImage;
  getImage() async {
    userImage = await ImagePic.getImage();
  }

  bool isLoading = false;
  updateUser() async {
    var result = await updateUserUseCase(name: "", image: userImage!);

    result.fold((failure) {
      isLoading = false;
      update();
      if (failure.runtimeType == UnAuthenticatedFailure) {
        Get.offAllNamed(Routes.login);
      }
      ToastManager.showError(mapFailureToMessage(failure));
    }, (right) {
      print('------------> $right');
      update();
    });
  }
}
