import 'package:butcity/core/const/fields.dart';
import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/resources/font_manager.dart';
import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/core/widgets/user_data_view_with_compilation.dart';
import 'package:butcity/core/widgets/custom_network_image.dart';
import 'package:butcity/core/widgets/custom_text.dart';
import 'package:butcity/features/auth_feature/presentation/drawer/views/my_drawer_view.dart';
import 'package:butcity/features/compilations/presentation/all_compilations/controllers/all_compilations_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCompilationsView extends StatelessWidget {
  const AllCompilationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllCompilationsController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.allCompilations.tr),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () => Get.toNamed(Routes.newCompilations),
          child: const Icon(
            Icons.add,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => controller.getCompilations(),
          child: controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : controller.compilations.isEmpty
                  ? Center(
                      child: CustomText(
                        text: LocaleKeys.noCompilations.tr,
                        color: Colors.blueAccent,
                        fontSize: 25,
                        fontWeight: FontWeightManager.bold,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: controller.compilations
                            .map((compilation) => Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.comments,
                                          arguments: {
                                            Fields.complaintId:
                                                compilation.id.toString(),
                                            Fields.compilations: compilation,
                                          },
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 5),
                                        width: double.infinity,
                                        height: 240,
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            /// image compilations
                                            compilation.imageForWeb != null
                                                ? CustomNetworkImage(
                                                    url: compilation
                                                        .imageForWeb!,
                                                  )
                                                : const SizedBox(),

                                            /// user data
                                            UserDataViewWithCompilation(
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              user: compilation.user!,
                                              compilation: compilation,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ))
                            .toList(),
                      ),
                    ),
        ),
        drawer: MyDrawer(),
      );
    });
  }
}
