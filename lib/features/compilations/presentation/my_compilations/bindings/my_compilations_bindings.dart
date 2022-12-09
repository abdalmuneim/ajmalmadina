import 'package:butcity/injection.dart';
import 'package:get/get.dart';

import '../controllers/my_compilations_controller.dart';

class MyCompilationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyCompilationsController>(() => MyCompilationsController(
          sl(),
          sl(),
        ));
  }
}
