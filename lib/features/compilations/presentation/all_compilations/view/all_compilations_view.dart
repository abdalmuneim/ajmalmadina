import 'package:butcity/core/const/fields.dart';
import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/resources/font_manager.dart';
import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/core/widgets/custom_network_image.dart';
import 'package:butcity/core/widgets/custom_text.dart';
import 'package:butcity/core/widgets/like_button.dart';
import 'package:butcity/core/widgets/user_data.dart';
import 'package:butcity/features/auth_feature/presentation/drawer/views/my_drawer_view.dart';
import 'package:butcity/features/compilations/presentation/all_compilations/controllers/all_compilations_controller.dart';
import 'package:intl/intl.dart' as intl;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

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
                            .map(
                              (compilation) => Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// user data
                                    UserData(
                                      compilation: compilation,
                                      user: compilation.user!,
                                    ),
                                    const SizedBox(height: 10),

                                    /// description
                                    ReadMoreText(
                                      '${compilation.description!}   ',
                                      trimLines: 1,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: LocaleKeys.readMore.tr,
                                      trimExpandedText: LocaleKeys.readLess.tr,
                                      moreStyle: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      lessStyle: const TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),

                                    const SizedBox(height: 10),

                                    /// image compilations
                                    compilation.imageForWeb != null
                                        ? CustomNetworkImage(
                                            url: compilation.imageForWeb!,
                                          )
                                        : const SizedBox(),
                                    const SizedBox(height: 10),

                                    /// comments
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        /// agree icon
                                        LikeButtonWidgets(
                                            nameIcon: LocaleKeys.agree.tr,
                                            likeCount: 0,
                                            icon: Icons.back_hand_outlined),

                                        /// comment icon
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () => Get.toNamed(
                                                Routes.comments,
                                                arguments: {
                                                  Fields.complaintId:
                                                      compilation.id.toString(),
                                                  Fields.compilations:
                                                      compilation,
                                                },
                                              ),
                                              icon: const Icon(
                                                Icons.comment,
                                                size: 30,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            CustomText(
                                              text: LocaleKeys.comments.tr,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
        ),
        drawer: MyDrawer(),
      );
    });
  }
}
