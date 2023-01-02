import 'package:butcity/core/error/failures.dart';
import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/resources/toast_manager.dart';
import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/features/auth_feature/domain/entities/user.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/get_user_use_case.dart';
import 'package:butcity/features/compilations/domain/entities/compilation.dart';
import 'package:butcity/features/compilations/domain/usecases/my_compilations_use_case.dart';
import 'package:get/get.dart';

class MyCompilationsController extends GetxController {
  final MyCompilationsUseCase _myCompilationsUseCase;
  final GetUserUseCase _getUserUseCase;

  MyCompilationsController(
    this._myCompilationsUseCase,
    this._getUserUseCase,
  );

  bool isLoading = false;

  User? user;

  List<Compilation> _compilations = [];
  List<Compilation> get compilations => _compilations;

  /// get compilation
  Future getCompilations() async {
    isLoading = true;
    update();
    final response = await _myCompilationsUseCase();

    response.fold((failure) {
      isLoading = false;
      update();
      if (failure.runtimeType == UnAuthenticatedFailure) {
        Get.offAllNamed(Routes.login);
      }

      ToastManager.showError(failure.message);
    }, (right) {
      _compilations = right;
      isLoading = false;
      update();
    });
  }

  /// get user data
  userData() async {
    var result = await _getUserUseCase();

    result.fold((failure) {
      isLoading = false;
      update();
      if (failure.runtimeType == UnAuthenticatedFailure) {
        Get.offAllNamed(Routes.login);
      }
      ToastManager.showError(mapFailureToMessage(failure));
    }, (right) {
      user = right;
      update();
    });
  }

  @override
  void onInit() async {
    await getCompilations();
    await userData();
    super.onInit();
  }
}
