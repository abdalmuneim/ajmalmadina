import 'package:butcity/features/compilations/presentation/all_compilations/controllers/all_compilations_controller.dart';
import 'package:butcity/injection.dart';
import 'package:get/get.dart';

class AllCompilationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllCompilationsController>(() => AllCompilationsController(
          sl(),
          sl(),
        ));
  }
}
