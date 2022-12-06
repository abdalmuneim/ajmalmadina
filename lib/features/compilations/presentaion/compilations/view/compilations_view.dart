import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/resources/font_manager.dart';
import 'package:butcity/core/routes/app_pages.dart';
import 'package:butcity/core/widgets/custom_network_image.dart';
import 'package:butcity/core/widgets/custom_text.dart';
import 'package:butcity/features/auth_feature/presentation/drawer/views/my_drawer_view.dart';
import 'package:butcity/features/compilations/presentaion/compilations/controller/compilations_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class CompilationsView extends StatelessWidget {
  const CompilationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompilationsController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.compilations.tr),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () => Get.offAllNamed(Routes.newCompilations),
          child: const Icon(
            Icons.add,
          ),
        ),
        body: controller.isLoading
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
                      return SizedBox(
                        width: double.infinity,
                        height: 240,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            /// image compilations
                            CustomNetworkImage(url: compilation.imageForWeb!),

                            /// user data
                            Positioned(
                              bottom: 10,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: IntrinsicHeight(
                                    child: ListTile(
                                      /// user image
                                      leading: DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(500),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.black,
                                                  blurRadius: 5,
                                                  offset: Offset(0, 0)),
                                            ]),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(500),
                                          child: Image.network(
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                            controller.user!.imageForWeb,
                                          ),
                                        ),
                                      ),

                                      /// user name
                                      title: Text(
                                        controller.user!.name,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                  color: Colors.black,
                                                  blurRadius: 10,
                                                  offset: Offset(0, 0)),
                                            ]),
                                      ),

                                      /// compilation date time
                                      subtitle: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.calendar_month,
                                              color: Colors.yellow,
                                              shadows: [
                                                Shadow(
                                                    color: Colors.black,
                                                    blurRadius: 10,
                                                    offset: Offset(0, 0)),
                                              ],
                                            ),
                                            Text(
                                              DateTime.tryParse(controller
                                                          .user!.createdAt) ==
                                                      null
                                                  ? ''
                                                  : intl.DateFormat.yMd('AR')
                                                      .add_jm()
                                                      .format(DateTime.tryParse(
                                                          controller.user!
                                                              .createdAt)!),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  shadows: [
                                                    Shadow(
                                                        color: Colors.black,
                                                        blurRadius: 20,
                                                        offset: Offset(0, 0)),
                                                  ]),
                                            ),
                                          ]),

                                      /// compilation location
                                      trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              compilation.location ?? '',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  shadows: [
                                                    Shadow(
                                                        color: Colors.black,
                                                        blurRadius: 10,
                                                        offset: Offset(0, 0)),
                                                  ]),
                                            ),
                                            const Icon(
                                              Icons.location_on_sharp,
                                              color: Colors.yellow,
                                              shadows: [
                                                Shadow(
                                                    color: Colors.black,
                                                    blurRadius: 10,
                                                    offset: Offset(0, 0)),
                                              ],
                                            )
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                            )

                            /// add comments Here
                          ],
                        ),
                      );
                    },
                  ),
        drawer: MyDrawer(),
      );
    });
  }
}
