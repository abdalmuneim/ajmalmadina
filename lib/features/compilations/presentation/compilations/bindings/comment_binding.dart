import 'package:butcity/features/compilations/presentation/compilations/controllers/comment_controller.dart';
import 'package:butcity/injection.dart';
import 'package:get/get.dart';

class CommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentController>(() => CommentController(
          sl(),
          sl(),
          sl(),
        ));
  }
}
