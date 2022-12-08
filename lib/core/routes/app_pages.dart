import 'package:butcity/features/aboutapp/view/about_app_view.dart';
import 'package:butcity/features/auth_feature/presentation/bindings/update_user_data_binding.dart';
import 'package:butcity/features/auth_feature/presentation/drawer/views/update_user_data_view.dart';
import 'package:butcity/features/auth_feature/presentation/login/bindings/login_bindings.dart';
import 'package:butcity/features/auth_feature/presentation/login/view/login_view.dart';
import 'package:butcity/features/auth_feature/presentation/register/bindings/register_binding.dart';
import 'package:butcity/features/auth_feature/presentation/register/view/register_view.dart';
import 'package:butcity/features/auth_feature/presentation/splash/bindings/splash_binding.dart';
import 'package:butcity/features/auth_feature/presentation/splash/views/splash_view.dart';
import 'package:butcity/features/compilations/presentaion/compilations/bindings/comment_binding.dart';
import 'package:butcity/features/compilations/presentaion/compilations/bindings/compilations_bindings.dart';
import 'package:butcity/features/compilations/presentaion/compilations/view/comment_view.dart';
import 'package:butcity/features/compilations/presentaion/new_compilation/bindings/new_compilations_bindings.dart';
import 'package:butcity/features/compilations/presentaion/new_compilation/view/new_compilations_view.dart';
import 'package:butcity/features/compilations/presentaion/compilations/view/compilations_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static String INITIAL = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.compilations,
      page: () => const CompilationsView(),
      binding: CompilationsBinding(),
    ),

    /// Login page
    GetPage(
      name: _Paths.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),

    /// register page
    GetPage(
      name: _Paths.register,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),

    GetPage(
      name: _Paths.newCompilations,
      page: () => const NewCompilationsView(),
      binding: NewCompilationBinding(),
    ),

    GetPage(
      name: _Paths.userUpdate,
      page: () =>   UpdateUserDataView(),
      binding: UpdateUserBinding(),
    ),
    GetPage(
      name: _Paths.comments,
      page: () => const CommentView(),
      binding: CommentBinding(),
    ),
  ];
}
