import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/core/widgets/custom_network_image.dart';
import 'package:butcity/core/widgets/custom_text.dart';
import 'package:butcity/features/compilations/domain/entities/comment.dart';
import 'package:butcity/features/compilations/presentation/comments/controllers/comment_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class CommentView extends StatelessWidget {
  const CommentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                /// image
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0, .5),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 250,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            /// image compilations
                            CustomNetworkImage(
                                borderRadius: 0.0,
                                url: controller.compilation!.imageForWeb!),

                            /// user data
                            controller.user == null
                                ? const SizedBox()
                                : Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: IntrinsicHeight(
                                        child: Column(
                                          children: [
                                            /// user data
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                /// user image
                                                Row(
                                                  children: [
                                                    const SizedBox(width: 10),
                                                    DecoratedBox(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        500),
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .black,
                                                                  blurRadius: 5,
                                                                  offset:
                                                                      Offset(0,
                                                                          0)),
                                                            ]),
                                                        child: CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                            controller
                                                                    .compilation!
                                                                    .user
                                                                    ?.imageForWeb ??
                                                                controller.user!
                                                                    .imageForWeb,
                                                          ),
                                                        )),
                                                    const SizedBox(width: 10),

                                                    /// user name
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          controller
                                                                  .compilation!
                                                                  .user
                                                                  ?.name ??
                                                              controller
                                                                  .user!.name,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  shadows: [
                                                                Shadow(
                                                                    color: Colors
                                                                        .black,
                                                                    blurRadius:
                                                                        10,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            0)),
                                                              ]),
                                                        ),

                                                        /// compilation date time
                                                        Row(children: [
                                                          const Icon(
                                                            Icons
                                                                .calendar_month,
                                                            color:
                                                                Colors.yellow,
                                                            shadows: [
                                                              Shadow(
                                                                  color: Colors
                                                                      .black,
                                                                  blurRadius:
                                                                      10,
                                                                  offset:
                                                                      Offset(0,
                                                                          0)),
                                                            ],
                                                          ),
                                                          Text(
                                                            DateTime.tryParse(controller
                                                                        .compilation!
                                                                        .createdAt!) ==
                                                                    null
                                                                ? ''
                                                                : intl.DateFormat
                                                                        .yMd(
                                                                            'ar')
                                                                    .add_Hm()
                                                                    .add_E()
                                                                    .format(DateTime.tryParse(controller
                                                                        .compilation!
                                                                        .createdAt!)!),
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16,
                                                                    shadows: [
                                                                  Shadow(
                                                                      color: Colors
                                                                          .black,
                                                                      blurRadius:
                                                                          20,
                                                                      offset:
                                                                          Offset(
                                                                              0,
                                                                              0)),
                                                                ]),
                                                          ),
                                                        ]),
                                                      ],
                                                    ),
                                                  ],
                                                ),

                                                /// compilation location
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: 100,
                                                      child: Text(
                                                        controller.compilation!
                                                                .location ??
                                                            '',
                                                        maxLines: 2,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            shadows: [
                                                              Shadow(
                                                                  color: Colors
                                                                      .black,
                                                                  blurRadius:
                                                                      10,
                                                                  offset:
                                                                      Offset(0,
                                                                          0)),
                                                            ]),
                                                      ),
                                                    ),
                                                    const Icon(
                                                      Icons.location_on_sharp,
                                                      color: Colors.yellow,
                                                      shadows: [
                                                        Shadow(
                                                            color: Colors.black,
                                                            blurRadius: 10,
                                                            offset:
                                                                Offset(0, 0)),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                            Positioned(
                              top: 2,
                              right: 2,
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                                child: IconButton(
                                  onPressed: () => Get.back(),
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                            text: controller.compilation!.description!),
                      ),
                    ],
                  ),
                ),

                /// comments
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => controller.onRefresh(),
                    child: controller.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : controller.comments.isNotEmpty
                            ? ListView.builder(
                                reverse: false,
                                itemCount: controller.comments.length,
                                itemBuilder: (context, index) {
                                  Comment comment = controller.comments[index];
                                  return Card(
                                    margin: const EdgeInsets.all(8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.circle,
                                            color: Colors.green,
                                          ),

                                          /// content
                                          Expanded(
                                            child: ListTile(
                                              title: CustomText(
                                                text: comment.content ?? "",
                                                fontSize: 25,
                                              ),

                                              /// comment date time
                                              subtitle: CustomText(
                                                text: DateTime.tryParse(comment
                                                            .createdAt!) ==
                                                        null
                                                    ? ''
                                                    : intl.DateFormat.yMd('AR')
                                                        .add_jm()
                                                        .format(DateTime
                                                            .tryParse(comment
                                                                .createdAt!)!),
                                                color: Colors.black,
                                                textAlign: TextAlign.end,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                controller: controller.listScrollController,
                              )
                            : Center(
                                child: CustomText(
                                  text: LocaleKeys.noComments.tr,
                                  fontSize: 30,
                                ),
                              ),
                  ),
                ),

                /// add comment
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          controller.addComment();
                        },
                        icon: const RotatedBox(
                            quarterTurns: 2,
                            child: Icon(
                              Icons.send,
                              color: Colors.green,
                            )),
                      ),
                    ),

                    /// add comments text form felid
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          maxLines: 5,
                          minLines: 1,
                          controller: controller.addCommentText,
                          onChanged: (value) => controller.onChange(value),
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: controller.addCommentTextError.isEmpty
                                    ? Colors.green
                                    : Colors.red,
                                width: controller.addCommentTextError.isEmpty
                                    ? 1
                                    : 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: controller.addCommentTextError.isEmpty
                                    ? Colors.green
                                    : Colors.red,
                                width: controller.addCommentTextError.isEmpty
                                    ? 1
                                    : 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: controller.addCommentTextError.isEmpty
                                    ? Colors.green
                                    : Colors.red,
                                width: controller.addCommentTextError.isEmpty
                                    ? 1
                                    : 2,
                              ),
                            ),
                            hintText: LocaleKeys.addComment.tr,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
