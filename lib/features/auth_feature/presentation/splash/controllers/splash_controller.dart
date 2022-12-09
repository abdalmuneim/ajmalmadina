// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/get_user_use_case.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  GetUserUseCase getUserUseCase;
  SplashController({
    required this.getUserUseCase,
  });

  bool isLoading = false;

  Future<void> getUserData() async {
    isLoading = true;
    update();

    var getUserData = await getUserUseCase();
    getUserData.fold((failure) {
      Get.offAllNamed(Routes.login);
    }, (result) {
      Get.offAllNamed(Routes.allCompilations, arguments: result);
    });

    isLoading = false;
    update();
  }

  @override
  void onInit() async {
    await getUserData();
    super.onInit();
  }
}
