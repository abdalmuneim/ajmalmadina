import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/features/auth_feature/presentation/drawer/controllers/update_user_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateUserDataView extends StatelessWidget {
  const UpdateUserDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateUserController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.userUpdate.tr),
        ),
        body: const Center(child: Text('سوف نقوم بإضافه هذه الميزه قريبا')),
      );
    });
  }
}
