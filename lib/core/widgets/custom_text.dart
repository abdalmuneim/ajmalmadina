import 'package:butcity/core/resources/font_manager.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.text,
    this.fontSize = 18,
    this.color = Colors.black,
    this.fontWeight = FontWeightManager.regular,
  }) : super(key: key);
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
          ),
    );
  }
}
