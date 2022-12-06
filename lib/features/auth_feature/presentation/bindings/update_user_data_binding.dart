import 'package:butcity/features/auth_feature/presentation/drawer/controllers/update_user_data_controller.dart';
import 'package:butcity/injection.dart';
import 'package:get/get.dart';

class UpdateUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateUserController>(
      () => UpdateUserController(sl()),
    );
  }
}
