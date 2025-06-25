import 'package:demo_app/widgets/nav_bar/components/custom_paint.dart';
import 'package:demo_app/widgets/nav_bar/components/color.dart';
import 'package:demo_app/widgets/nav_bar/components/text_style.dart';
import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final bool isActive;
  final VoidCallback onTap;
  final double widthContainer;

  const NavButton({
    super.key,
    required this.label,
    required this.iconPath,
    required this.isActive,
    required this.onTap,
    required this.widthContainer,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: widthContainer / 6,
        child: Stack(
          children: [
            // Notch
            Align(
              alignment: Alignment.topCenter,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: isActive ? 50 : 0,
                width: isActive ? 50 : 0,
                child:
                    isActive
                        ? CustomPaint(painter: ButtonNotch())
                        : const SizedBox(),
              ),
            ),

            // Icono y texto
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Animación de color + escala
                    TweenAnimationBuilder<Color?>(
                      tween: ColorTween(
                        begin: isActive ? black : selectColor,
                        end: isActive ? selectColor : black,
                      ),
                      duration: const Duration(milliseconds: 500),
                      builder: (context, color, child) {
                        return AnimatedScale(
                          scale: isActive ? 1.2 : 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutBack,
                          child: Image.asset(
                            iconPath,
                            color: color,
                            width: 18,
                            height: 18,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 5),
                    // Texto animado
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 500),
                      style: bntText.copyWith(
                        color: isActive ? selectColor : black,
                      ),
                      child: Text(label),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
