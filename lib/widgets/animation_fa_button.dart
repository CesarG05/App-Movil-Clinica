import 'package:flutter/material.dart';

class CustomAnimationFAButton extends StatelessWidget {
  final bool isExpand;
  final VoidCallback onTap;

  const CustomAnimationFAButton({
    super.key,
    required this.isExpand,
    required this.onTap,
  });

  static const _duration = Duration(milliseconds: 400);
  static const _minSize = 50.0;
  static const _maxSize = 180.0;
  static const _iconSize = 26.0;

  @override
  Widget build(BuildContext context) {
    final position = _minSize / 2 - _iconSize / 2;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: _duration,
        width: isExpand ? _minSize : _maxSize,
        height: _minSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_minSize),
          color: Colors.teal[600],
        ),
        child: Stack(
          children: [
            Positioned(
              left: position,
              top: position,
              child: Icon(
                Icons.person_add,
                size: _iconSize,
                color: Colors.white,
              ),
            ),
            Positioned(
              left: position + _minSize * 0.75,
              top: position,
              child: Text(
                'Nuevo paciente',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
