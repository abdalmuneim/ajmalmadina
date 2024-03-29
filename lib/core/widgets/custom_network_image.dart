import 'package:butcity/core/language/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage(
      {super.key, required this.url, this.borderRadius = 10});
  final String? url;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        fit: BoxFit.cover,
        height: 240,
        width: double.infinity,
        url ?? "",
        errorBuilder: (BuildContext context, _, stackTrace) {
          return Center(
              child: Text(
            LocaleKeys.imageNotLoaded.tr,
          ));
        },
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
  }
}
