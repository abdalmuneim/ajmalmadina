import 'package:butcity/core/language/app_translations.dart';
import 'package:butcity/features/compilations/presentaion/compilations/controller/compilations_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompilationsController>(builder: (context) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          fit: BoxFit.cover,
          url,
          errorBuilder: (BuildContext context, _, stackTrace) => Center(
              child: Text(
            LocaleKeys.imageNotLoaded.tr,
          )),
          loadingBuilder: (context, Widget child, ImageChunkEvent? url) {
            if (url == null) {
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  value: url.expectedTotalBytes != null
                      ? url.cumulativeBytesLoaded / url.expectedTotalBytes!
                      : null,
                ),
              );
            }
          },
        ),
      );
    });
  }
}
