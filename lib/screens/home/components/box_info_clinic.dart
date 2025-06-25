import 'package:demo_app/screens/home/components/line_painter.dart';
import 'package:demo_app/widgets/icon_circle/icon_circle.dart';
import 'package:flutter/material.dart';

class AnimatedBoxInfoClinic extends StatefulWidget {
  final double widthScreen;
  final double heightScreen;

  const AnimatedBoxInfoClinic({
    super.key,
    required this.widthScreen,
    required this.heightScreen,
  });

  @override
  State<AnimatedBoxInfoClinic> createState() => _AnimatedBoxInfoClinicState();
}

class _AnimatedBoxInfoClinicState extends State<AnimatedBoxInfoClinic>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final double boxWidth = 240;
  final double boxHeight = 70;

  final double sizeLogo = 70;
  final String nameClinic = 'Clinica FisioFort';
  final String ruteLogo = 'assets/images/icons/clinica.png';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.widthScreen,
      height: boxHeight + sizeLogo,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          // Nombre Clínica
          Positioned(
            bottom: 0,
            child: SizedBox(
              width: boxWidth - 20,
              height: boxHeight,
              child: Center(
                child: Text(
                  nameClinic,
                  style: TextStyle(
                    fontSize: nameClinic.length > 20 ? 16 : 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.teal,
                  ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
          ),

          // Línea animada alrededor del borde
          Positioned(
            bottom: 0,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                return CustomPaint(
                  painter: BorderLinePainter(
                    animationValue: _controller.value,
                    width: boxWidth,
                    height: boxHeight + sizeLogo / 4,
                    segmentCount: 2,
                  ),
                  child: SizedBox(
                    width: boxWidth,
                    height: boxHeight + sizeLogo / 4,
                  ),
                );
              },
            ),
          ),

          // Logo Clínica
          Positioned(
            top: 5,
            child: IconCircle(
              diameterCircle: sizeLogo,
              colorBackgroud: Colors.white,
              colorBorder: Colors.teal,
              widthBorder: 2.0,
              padding: 10.0,
              child: Image.asset(ruteLogo),
            ),
          ),
        ],
      ),
    );
  }
}
