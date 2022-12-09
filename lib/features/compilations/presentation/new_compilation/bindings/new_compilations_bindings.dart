import 'package:butcity/features/compilations/presentation/new_compilation/controller/new_compilation_controller.dart';
import 'package:butcity/injection.dart';
import 'package:get/get.dart';

class NewCompilationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewCompilationController>(() => NewCompilationController(
          newCompilationsUseCase: sl(),
          getCompilationTypeUseCase: sl(),
        ));
  }
}
