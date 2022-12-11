import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/resources/values_manager.dart';
import 'package:butcity/core/widgets/custom_text.dart';
import 'package:butcity/core/widgets/custom_text_form_field.dart';
import 'package:butcity/features/auth_feature/presentation/drawer/controllers/user_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateUserDataView extends StatelessWidget {
  UpdateUserDataView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserUpdateController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.editAccount.tr),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// upload image
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            /// button get image
                            ElevatedButton(
                              onPressed: () => controller.getImage(),
                              style: Theme.of(context)
                                  .elevatedButtonTheme
                                  .style
                                  ?.copyWith(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppSize.s100),
                                        ),
                                      ),
                                      minimumSize: MaterialStateProperty.all(
                                          const Size(200, 50)),
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle>(
                                              const TextStyle(
                                                  color: Colors.black))),
                              child: CustomText(
                                text: LocaleKeys.tackPhoto.tr,
                              ),
                            ),
                          ],
                        ),

                        /// user image
                        if (controller.user?.imageForWeb != null)
                          if (controller.userImage == null)
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(controller.user!.imageForWeb),
                            )
                          else
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                controller.userImage!,
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              ),
                            )
                        else
                          const CircleAvatar(),
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// text form field name
                    CustomTextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.validationName.tr;
                        }
                        return null;
                      },
                      borderRadius: 20,
                      textEditingController: controller.nameCtrl,
                      prefixIcon: const Icon(Icons.person),
                      labelText: LocaleKeys.name.tr,
                      hintText: LocaleKeys.name.tr,
                    ),
                    const SizedBox(height: 30),

                    /// text form field email
                    CustomTextFormField(
                      borderRadius: 20,
                      textEditingController: controller.emailCtrl,
                      enabled: false,
                      prefixIcon: const Icon(Icons.mail),
                      labelText: LocaleKeys.email.tr,
                      hintText: LocaleKeys.hintEmail.tr,
                    ),
                    const SizedBox(height: 30),

                    /// text form field password
                    CustomTextFormField(
                      obscureText: controller.obscureTextPass,
                      borderRadius: 20,
                      textEditingController: controller.passCtrl,
                      labelText: LocaleKeys.password.tr,
                      hintText: '********',
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    const SizedBox(height: 30),

                    /// text form field confirm password
                    CustomTextFormField(
                      obscureText: controller.obscureTextPassCon,
                      borderRadius: 20,
                      textEditingController: controller.confPassCtrl,
                      labelText: LocaleKeys.confirmPassword.tr,
                      hintText: '********',
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    const SizedBox(height: 70),

                    /// update button
                    controller.isLoading
                        ? const CircularProgressIndicator()
                        : Container(
                            height: 50,
                            width: double.infinity,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: MaterialButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (controller.passCtrl.text ==
                                      controller.confPassCtrl.text) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    controller.updateUser();
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: Text(
                                      LocaleKeys.confirmPasswordVal.tr,
                                    )));
                                  }
                                }
                              },
                              color: Colors.blueAccent,
                              child: CustomText(
                                text: LocaleKeys.edit.tr,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
