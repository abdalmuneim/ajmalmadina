import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/resources/assets_manager.dart';
import 'package:butcity/core/resources/font_manager.dart';
import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/core/widgets/custom_text.dart';
import 'package:butcity/features/aboutapp/view/about_app_view.dart';
import 'package:butcity/features/auth_feature/presentation/drawer/views/drawer_item.dart';
import 'package:butcity/features/compilations/presentaion/compilations/view/compilations_view.dart';
import 'package:butcity/features/auth_feature/presentation/drawer/controllers/my_drawer_controller.dart';
import 'package:butcity/injection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  final ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyDrawerController>(
        init: MyDrawerController(
          logOutUseCase: sl(),
          getUserUseCase: sl(),
        ),
        builder: (controller) {
          return Stack(
            children: [
              Drawer(
                child: ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// user name
                            CustomText(
                              text: controller.user?.name ?? "",
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeightManager.bold,
                            ),

                            /// edit button
                            IconButton(
                              onPressed: () {
                                Get.toNamed(Routes.userUpdate);
                              },
                              padding: const EdgeInsets.all(15),
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      accountEmail: CustomText(
                        text: controller.user?.email ?? "",
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeightManager.bold,
                      ),
                      currentAccountPicture: controller.user?.imageForWeb !=
                              null
                          ? CircleAvatar(
                              backgroundImage:
                                  NetworkImage(controller.user!.imageForWeb),
                            )
                          : const CircleAvatar(),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AssetsManager.backPerson),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    DrawerItem(
                      title: LocaleKeys.compilations.tr,
                      icon: Icons.api,
                      onTap: () {
                        Get.to(const CompilationsView());
                      },
                    ),
                    DrawerItem(
                      title: LocaleKeys.addCompilations.tr,
                      icon: Icons.add_moderator_outlined,
                      onTap: () {
                        Get.to(Routes.newCompilations);
                      },
                    ),
                    const Divider(),
                    DrawerItem(
                      title: LocaleKeys.aboutApp.tr,
                      icon: Icons.info,
                      onTap: () {
                        Get.to(const AboutAppView());
                      },
                    ),
                    DrawerItem(
                      title: LocaleKeys.logout.tr,
                      icon: Icons.logout,
                      onTap: () => controller.logOut(),
                    )
                  ],
                ),
              ),
              if (controller.isLoading)
                Container(
                  width: context.width,
                  height: context.height,
                  color: Colors.grey.withOpacity(.7),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 50,
                      height: 50,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          );
        });
  }
}
