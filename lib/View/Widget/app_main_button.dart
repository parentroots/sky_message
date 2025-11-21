import 'package:flutter/material.dart';

class AppMainButton extends StatelessWidget {
  const AppMainButton({
    super.key,
    required this.height,
    required this.width,
    required this.isGradiant,
    required this.onTap,
    required this.marginVerticel,
    required this.marginHorizontal,
    required this.bgColor,
    required this.radius,
    required this.child,
  });

  final Color bgColor;
  final double height;
  final double width;
  final bool isGradiant;
  final VoidCallback onTap;
  final double marginVerticel;
  final double marginHorizontal;
  final double radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Text(
          "",
          style: TextStyle(),
        ),
      ),
    );
  }
}
