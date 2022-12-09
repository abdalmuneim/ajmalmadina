import 'package:butcity/core/widgets/custom_text.dart';
import 'package:butcity/features/auth_feature/domain/entities/user.dart';
import 'package:butcity/features/compilations/domain/entities/compilation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class UserDataViewWithCompilation extends StatelessWidget {
  const UserDataViewWithCompilation(
      {super.key, required this.user, required this.compilation});
  final User user;
  final Compilation compilation;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IntrinsicHeight(
            child: Column(
              children: [
                /// user data
                ListTile(
                  /// user image
                  leading: DecoratedBox(
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
                          user.imageForWeb,
                        ),
                      )),

                  /// user name
                  title: Text(
                    user.name,
                    style: const TextStyle(color: Colors.white, shadows: [
                      Shadow(
                          color: Colors.black,
                          blurRadius: 10,
                          offset: Offset(0, 0)),
                    ]),
                  ),

                  /// compilation date time
                  subtitle: Row(children: [
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
                      DateTime.tryParse(user.createdAt) == null
                          ? ''
                          : intl.DateFormat.yMd('AR')
                              .add_jm()
                              .format(DateTime.tryParse(user.createdAt)!),
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
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                    Text(
                      compilation.location ?? '',
                      style: const TextStyle(color: Colors.white, shadows: [
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
                const SizedBox(height: 10),

                /// description compilation
                Container(
                  color: Colors.black38,
                  child: CustomText(
                    text: compilation.description ?? "",
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
