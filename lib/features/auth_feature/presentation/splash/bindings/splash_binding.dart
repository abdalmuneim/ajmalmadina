import 'package:butcity/features/auth_feature/presentation/splash/controllers/splash_controller.dart';
import 'package:butcity/injection.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(
        getUserUseCase: sl(),
      ),
    );
  }
}
