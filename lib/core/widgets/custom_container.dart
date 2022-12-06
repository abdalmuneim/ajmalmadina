import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    this.paddingHor = 0.0,
    this.paddingVer = 0.0,
    this.marginVer = 0.0,
    this.marginHor = 0.0,
    this.alignment = Alignment.center,
    required this.child,
    this.radius = 10,
    this.width = 1,
    this.height = 1,
    this.border = false,
    this.color = const Color(0xffFFFFFF),
  }) : super(key: key);
  final double paddingHor;
  final double paddingVer;
  final Color color;
  final double marginVer;
  final double marginHor;
  final Widget child;
  final double radius;
  final double width;
  final double height;
  final bool border;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / width,
      height: MediaQuery.of(context).size.height / height,
      padding:
          EdgeInsets.symmetric(horizontal: paddingHor, vertical: paddingVer),
      margin: EdgeInsets.symmetric(horizontal: marginHor, vertical: marginVer),
      alignment: alignment,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
          border: border ? Border.all(width: 1.5, color: Colors.green) : null,
          boxShadow: [
            BoxShadow(
              blurRadius: 5.0,
              spreadRadius: 0.2,
              offset: const Offset(1, 3),
              color: Colors.green.withOpacity(.5),
            ),
          ]),
      child: child,
    );
  }
}
