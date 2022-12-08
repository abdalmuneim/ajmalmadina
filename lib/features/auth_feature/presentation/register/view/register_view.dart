import 'dart:io';

import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/resources/assets_manager.dart';
import 'package:butcity/core/resources/values_manager.dart';
import 'package:butcity/core/widgets/custom_text.dart';
import 'package:butcity/core/widgets/custom_text_form_field.dart';
import 'package:butcity/features/auth_feature/presentation/register/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  File? _file;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (controller) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
                child: Column(
                  children: [
                    const SizedBox(height: 50),

                    /// top content
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: LocaleKeys.createAccount.tr,
                          color: Colors.blueAccent,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_forward_ios_sharp))
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// logo
                    Container(
                      width: 100,
                      height: 100,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: Image.asset(AssetsManager.logo),
                    ),
                    const SizedBox(height: 50),

                    /// upload image
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s100),
                                    ),
                                  ),
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(200, 50)),
                                  textStyle: MaterialStateProperty.all<
                                          TextStyle>(
                                      const TextStyle(color: Colors.black))),
                          child: CustomText(
                            text: LocaleKeys.tackPhoto.tr,
                          ),
                        ),
                        if (controller.userImage == null)
                          const SizedBox()
                        else
                          CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                Image.file(controller.userImage!).image,
                          )
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
                      textEditingController: controller.emailCtrl,
                      borderRadius: 20,
                      prefixIcon: const Icon(Icons.mail),
                      labelText: LocaleKeys.email.tr,
                      hintText: LocaleKeys.hintEmail.tr,
                    ),
                    const SizedBox(height: 30),

                    /// text form field password
                    CustomTextFormField(
                      obscureText: controller.obscureTextPass,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.confirmPasswordValidation2.tr;
                        } else if (value.length < 6) {
                          return LocaleKeys.confirmPasswordValidation.tr;
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.confirmPasswordValidation2.tr;
                        } else if (value.length < 6) {
                          return LocaleKeys.confirmPassValidate.tr;
                        }
                        return null;
                      },
                      borderRadius: 20,
                      textEditingController: controller.confPassCtrl,
                      labelText: LocaleKeys.confirmPassword.tr,
                      hintText: '********',
                      prefixIcon: const Icon(Icons.lock),
                    ),
                    const SizedBox(height: 70),

                    /// register button
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

                                    controller.register();
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
                                text: LocaleKeys.create.tr,
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
