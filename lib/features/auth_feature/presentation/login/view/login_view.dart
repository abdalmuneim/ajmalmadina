import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/resources/assets_manager.dart';
import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/core/widgets/custom_text.dart';
import 'package:butcity/core/widgets/custom_text_form_field.dart';
import 'package:butcity/features/auth_feature/presentation/login/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: LocaleKeys.loginToApp.tr,
                          color: Colors.blueAccent,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    /// logo
                    Container(
                      width: 90,
                      height: 90,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset(AssetsManager.logo),
                    ),
                    const SizedBox(height: 100),

                    /// form email
                    CustomTextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.validateEmail2.tr;
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value)) {
                          return LocaleKeys.validateEmail.tr;
                        }
                        return null;
                      },
                      borderRadius: 20,
                      textEditingController: controller.emailCtrl,
                      prefixIcon: const Icon(Icons.mail),
                      labelText: LocaleKeys.email.tr,
                      hintText: LocaleKeys.hintEmail.tr,
                    ),
                    const SizedBox(height: 30),

                    /// form password
                    CustomTextFormField(
                      borderRadius: 20,
                      obscureText: controller.obscureText,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.confirmPasswordValidation2.tr;
                        } else if (value.length < 6) {
                          return LocaleKeys.confirmPasswordValidation.tr;
                        }
                        return null;
                      },
                      textEditingController: controller.passwordCtrl,
                      labelText: LocaleKeys.password.tr,
                      hintText: '*******',
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    const SizedBox(height: 70),

                    /// button login
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
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  controller.login();
                                }
                              },
                              color: Colors.blueAccent,
                              child: CustomText(
                                text: LocaleKeys.login.tr,
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                          ),
                    const SizedBox(height: 30),

                    /// button register
                    InkWell(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();

                        Get.toNamed(Routes.register);
                      },
                      child: Text(
                        LocaleKeys.createAccount.tr,
                        style: const TextStyle(
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    )
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
