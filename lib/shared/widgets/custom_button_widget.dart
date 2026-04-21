import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.hieght,
    required this.width,
    this.backgroundColor,
    this.gradient,
    required this.borderRadius,
    required this.onTap,
    required this.child,
  });
  final double hieght;
  final double width;
  final Color? backgroundColor;
  final Gradient? gradient;
  final double borderRadius;
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: hieght,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          gradient: gradient,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: child,
      ),
    );
  }
}
