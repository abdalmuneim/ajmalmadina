import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/resources/values_manager.dart';
import 'package:butcity/core/widgets/custom_text.dart';
import 'package:butcity/core/widgets/custom_text_form_field.dart';
import 'package:butcity/core/widgets/my_location.dart';
import 'package:butcity/features/compilations/presentation/new_compilation/controller/new_compilation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewCompilationsView extends StatefulWidget {
  const NewCompilationsView({Key? key}) : super(key: key);

  @override
  State<NewCompilationsView> createState() => _NewCompilationsViewState();
}

class _NewCompilationsViewState extends State<NewCompilationsView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewCompilationController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(LocaleKeys.addNewCompilations.tr),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    enabledBorder: false,
                    textEditingController: controller.descriptionCtr,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.validateError.tr;
                      } else if (value.length <= 20) {
                        return LocaleKeys.validateDecLength.tr;
                      } else {}
                      return null;
                    },
                    filled: false,
                    hintText: LocaleKeys.hintDescription.tr,
                    labelText: LocaleKeys.enterDescription.tr,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 20.0),

                  /// take compilation photo
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
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                    const TextStyle(color: Colors.black))),
                        child: CustomText(
                          text: LocaleKeys.tackPhoto.tr,
                        ),
                      ),
                      if (controller.image != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            controller.image!,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          ),
                        ),
                    ],
                  ),

                  if (controller.imageError.isNotEmpty)
                    const SizedBox(height: AppSize.s8),
                  if (controller.imageError.isNotEmpty)
                    Text(
                      controller.imageError,
                    ),
                  const SizedBox(height: 20.0),

                  /// Your location
                  controller.position != null
                      ? MyLocation(
                          lat: double.tryParse(controller.lat) ?? 45,
                          long: double.tryParse(controller.long) ?? 45,
                        )
                      : Column(
                          children: [
                            IconButton(
                              onPressed: () => controller.getLocation(),
                              icon: const Icon(
                                Icons.my_location_rounded,
                                color: Colors.green,
                                size: 45,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            CustomText(
                              text: LocaleKeys.getLocation.tr,
                              color: Colors.green,
                            ),
                          ],
                        ),
                  if (controller.locationError.isNotEmpty)
                    const SizedBox(height: AppSize.s8),
                  if (controller.locationError.isNotEmpty)
                    Text(
                      controller.locationError,
                    ),
                  const SizedBox(height: 20.0),

                  /// choses compilation type
                  Card(
                    child: ListTile(
                      title: Text(LocaleKeys.compilationsType.tr),
                      trailing: controller.compilationTypes.isEmpty
                          ? TextButton(
                              onPressed: () => controller.getCompilationsType(),
                              child: CustomText(
                                text: LocaleKeys.chosesCompilationsType.tr,
                                color: Colors.blue,
                              ),
                            )
                          : DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint:
                                    Text(LocaleKeys.chosesCompilationsType.tr),
                                items: controller.compilationTypes
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e.name ??
                                              LocaleKeys
                                                  .chosesCompilationsType.tr,
                                        ),
                                      ),
                                    )
                                    .toList(),
                                value: controller.selectedCompilationType,
                                onChanged: (value) =>
                                    controller.selectCompilationType(value),
                              ),
                            ),
                    ),
                  ),
                  if (controller.typeError.isNotEmpty)
                    const SizedBox(height: AppSize.s8),
                  if (controller.typeError.isNotEmpty)
                    Text(
                      controller.typeError,
                    ),
                  const SizedBox(height: 40),

                  /// post compilations button
                  ElevatedButton(
                    style: const ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(Size(170, 50))),
                    onPressed: !controller.isLoading
                        ? () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (_formKey.currentState!.validate()) {
                              controller.addCompilation();
                            }
                          }
                        : () {},
                    child: controller.isLoading
                        ? const LinearProgressIndicator()
                        : Text(LocaleKeys.addNewCompilations.tr),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  final _formKey = GlobalKey<FormState>();
}
