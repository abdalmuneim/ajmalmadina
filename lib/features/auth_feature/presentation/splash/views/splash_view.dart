import 'package:butcity/features/auth_feature/presentation/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (controller) {
        return Scaffold(
          body: controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),
        );
      },
    );
  }
}
