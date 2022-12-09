import 'package:butcity/injection.dart';
import 'package:get/get.dart';

import '../controllers/compilations_controller.dart';

class CompilationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompilationsController>(() => CompilationsController(
          sl(),
          sl(),
        ));
  }
}
