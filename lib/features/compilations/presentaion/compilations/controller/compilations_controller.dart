import 'package:butcity/core/error/failures.dart';
import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/features/auth_feature/domain/entities/user.dart';
import 'package:butcity/features/auth_feature/domain/use_cases/get_user_use_case.dart';
import 'package:butcity/features/compilations/domain/entities/compilation.dart';
import 'package:butcity/features/compilations/domain/usecases/get_compilations_use_case.dart';
import 'package:butcity/core/resources/toast_manager.dart';
import 'package:get/get.dart';

class CompilationsController extends GetxController {
  final GetCompilationsUseCase _getCompilationsUseCase;
  final GetUserUseCase _getUserUseCase;

  CompilationsController(this._getCompilationsUseCase, this._getUserUseCase);

  User? user;
  bool isLoading = false;
  List<Compilation> _compilations = [];

  List<Compilation> get compilations => _compilations;

  Future getCompilations() async {
    isLoading = true;
    update();
    final response = await _getCompilationsUseCase();

    response.fold((l) {
      isLoading = false;
      update();
      if (l.runtimeType == UnAuthenticatedFailure) {
        Get.offAllNamed(Routes.login);
      }

      ToastManager.showError(l.message);
    }, (r) {
      _compilations = r;
      isLoading = false;
      update();
    });
  }

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
    userData();
    super.onInit();
  }
}
