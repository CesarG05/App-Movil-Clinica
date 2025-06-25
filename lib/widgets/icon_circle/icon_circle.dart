import 'package:flutter/material.dart';

class IconCircle extends StatelessWidget {
  const IconCircle({
    super.key,
    required this.diameterCircle,
    required this.colorBackgroud,
    required this.colorBorder,
    required this.widthBorder,
    required this.padding,
    required this.child,
  });

  final Widget child;
  final double diameterCircle;
  final Color colorBackgroud;
  final Color colorBorder;
  final double widthBorder;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameterCircle,
      height: diameterCircle,
      decoration: BoxDecoration(
        color: colorBackgroud,
        shape: BoxShape.circle,
        border: Border.all(color: colorBorder, width: widthBorder),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Center(child: child),
      ),
    );
  }
}
