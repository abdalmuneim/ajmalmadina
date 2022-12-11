import 'package:butcity/core/const/fields.dart';
import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/resources/font_manager.dart';
import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/core/widgets/user_data_view_with_compilation.dart';
import 'package:butcity/core/widgets/custom_network_image.dart';
import 'package:butcity/core/widgets/custom_text.dart';
import 'package:butcity/features/auth_feature/presentation/drawer/views/my_drawer_view.dart';
import 'package:butcity/features/compilations/presentation/my_compilations/controllers/my_compilations_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCompilationsView extends StatelessWidget {
  const MyCompilationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyCompilationsController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.myCompilations.tr),
          centerTitle: true,
          actions: [
            RotatedBox(
              quarterTurns: 2,
              child: IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.arrow_back)),
            )
          ],
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
                  : ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      padding: const EdgeInsets.all(10),
                      itemCount: controller.compilations.length,
                      itemBuilder: (context, index) {
                        final compilation = controller.compilations[index];
                        return InkWell(
                          onTap: () {
                            Get.toNamed(
                              Routes.comments,
                              arguments: {
                                Fields.complaintId: compilation.id.toString(),
                                Fields.compilations: compilation,
                              },
                            );
                          },
                          child: SizedBox(
                            width: double.infinity,
                            height: 240,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                /// image compilations
                                CustomNetworkImage(
                                    url: compilation.imageForWeb!),

                                /// user data
                                UserDataViewWithCompilation(
                                    user: controller.user!,
                                    compilation: compilation)
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
        drawer: MyDrawer(),
      );
    });
  }
}
