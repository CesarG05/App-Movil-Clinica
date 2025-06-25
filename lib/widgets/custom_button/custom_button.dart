import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color backgroundColor;
  final Widget? icon;
  final Text text;
  final double borderRadius;
  final Border? border;
  final double verticalPadding;
  final double horizontalPadding;

  const CustomButton({
    super.key,
    required this.onTap,
    this.backgroundColor = Colors.transparent,
    this.icon,
    required this.text,
    this.borderRadius = 12.0,
    this.border,
    this.verticalPadding = 12.0,
    this.horizontalPadding = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        splashColor: Colors.grey.withAlpha(50),
        highlightColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: border,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 8)],
              text,
            ],
          ),
        ),
      ),
    );
  }
}
