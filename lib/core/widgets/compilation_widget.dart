import 'package:butcity/features/auth_feature/domain/entities/user.dart';
import 'package:butcity/features/compilations/domain/entities/compilation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class CompilationsWidget extends StatelessWidget {
  const CompilationsWidget(
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
            child: ListTile(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(500),
                  child: Image.network(
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    user.imageForWeb,
                  ),
                ),
              ),

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
              subtitle: Row(mainAxisSize: MainAxisSize.min, children: [
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
          ),
        ),
      ),
    );
  }
}
