import 'package:butcity/features/auth_feature/presentation/drawer/controllers/user_update_controller.dart';
import 'package:butcity/injection.dart';
import 'package:get/get.dart';

class UpdateUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserUpdateController>(
      () => UserUpdateController(sl(), sl()),
    );
  }
}
