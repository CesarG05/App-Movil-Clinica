import 'package:flutter/material.dart';

class BorderLinePainter extends CustomPainter {
  final double animationValue;
  final double width;
  final double height;
  final int segmentCount;

  BorderLinePainter({
    required this.animationValue,
    required this.width,
    required this.height,
    required this.segmentCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = Colors.teal
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;

    // Segmento con fade
    final Paint fadedPaint =
        paint
          ..shader = LinearGradient(
            colors: [
              Colors.teal.withValues(alpha: 0.0),
              Colors.teal,
              Colors.teal.withValues(alpha: 0.0),
            ],
            stops: [0.0, 0.5, 1.0],
          ).createShader(Rect.fromLTWH(0, 0, width, height));

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, width, height),
      Radius.circular(height),
    );

    final Path path = Path()..addRRect(rrect);

    for (final metric in path.computeMetrics()) {
      final double len = metric.length;
      final double segmentLength =
          len * (1 / (segmentCount * 2)); // largo del segmento
      final double step = len / segmentCount;

      for (int i = 0; i < segmentCount; i++) {
        final double offset = (animationValue * len + i * step) % len;
        final double end = offset + segmentLength;

        Path partial;
        if (end <= len) {
          partial = metric.extractPath(offset, end);
        } else {
          final part1 = metric.extractPath(offset, len);
          final part2 = metric.extractPath(0, end - len);
          partial =
              Path()
                ..addPath(part1, Offset.zero)
                ..addPath(part2, Offset.zero);
        }

        canvas.drawPath(partial, fadedPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant BorderLinePainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
