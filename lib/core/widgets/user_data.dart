import 'package:butcity/core/resources/font_manager.dart';
import 'package:butcity/core/widgets/custom_text.dart';
import 'package:butcity/features/auth_feature/domain/entities/user.dart';
import 'package:butcity/features/compilations/domain/entities/compilation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class UserData extends StatelessWidget {
  const UserData({
    Key? key,
    required this.compilation,
    required this.user,
  }) : super(key: key);

  final Compilation compilation;
  final User user;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: IntrinsicHeight(
        child: Column(
          children: [
            /// user data
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// user image
                Row(
                  children: [
                    DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 5,
                                  offset: Offset(0, 0)),
                            ]),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            compilation.user!.imageForWeb,
                          ),
                        )),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// user name
                        CustomText(
                          text: compilation.user!.name,
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeightManager.bold,
                        ),

                        /// compilation date time
                        Row(
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
                            const SizedBox(width: 5),
                            CustomText(
                              text: DateTime.tryParse(compilation.createdAt!) ==
                                      null
                                  ? ''
                                  : intl.DateFormat.yMd('ar')
                                      .add_Hm()
                                      .add_E()
                                      .format(DateTime.tryParse(
                                          compilation.createdAt!)!),
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                /// compilation location
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 100,
                      child: CustomText(
                        text: compilation.location ?? '',
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        color: Colors.black,
                      ),
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
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
