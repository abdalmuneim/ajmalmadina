import 'package:butcity/features/auth_feature/presentation/bindings/user_update_binding.dart';
import 'package:butcity/features/auth_feature/presentation/drawer/views/user_update_view.dart';
import 'package:butcity/features/auth_feature/presentation/login/bindings/login_bindings.dart';
import 'package:butcity/features/auth_feature/presentation/login/view/login_view.dart';
import 'package:butcity/features/auth_feature/presentation/register/bindings/register_binding.dart';
import 'package:butcity/features/auth_feature/presentation/register/view/register_view.dart';
import 'package:butcity/features/auth_feature/presentation/splash/bindings/splash_binding.dart';
import 'package:butcity/features/auth_feature/presentation/splash/views/splash_view.dart';
import 'package:butcity/features/compilations/presentation/all_compilations/bindings/all_compilations_binding.dart';
import 'package:butcity/features/compilations/presentation/all_compilations/view/all_compilations_view.dart';
import 'package:butcity/features/compilations/presentation/comments/bindings/comment_binding.dart';
import 'package:butcity/features/compilations/presentation/my_compilations/bindings/my_compilations_bindings.dart';
import 'package:butcity/features/compilations/presentation/comments/view/comment_view.dart';
import 'package:butcity/features/compilations/presentation/new_compilation/bindings/new_compilations_bindings.dart';
import 'package:butcity/features/compilations/presentation/new_compilation/view/new_compilations_view.dart';
import 'package:butcity/features/compilations/presentation/my_compilations/view/my_compilations_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static String INITIAL = Routes.splash;

  static final routes = [
    /// splash
    GetPage(
      name: _Paths.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),

    /// all compilation
    GetPage(
      name: _Paths.allCompilations,
      page: () => const AllCompilationsView(),
      binding: AllCompilationsBinding(),
    ),

    /// my compilation
    GetPage(
      name: _Paths.myCompilations,
      page: () => const MyCompilationsView(),
      binding: MyCompilationsBinding(),
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

    /// new compilation
    GetPage(
      name: _Paths.newCompilations,
      page: () => const NewCompilationsView(),
      binding: NewCompilationBinding(),
    ),

    /// update user
    GetPage(
      name: _Paths.userUpdate,
      page: () => UpdateUserDataView(),
      binding: UpdateUserBinding(),
    ),

    /// comments
    GetPage(
      name: _Paths.comments,
      page: () => const CommentView(),
      binding: CommentBinding(),
    ),
  ];
}
