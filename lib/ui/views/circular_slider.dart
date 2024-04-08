import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';

class CircularSlider<T extends num> extends StatefulWidget {
  final T radius;
  final T value;
  final T maxValue;

  const CircularSlider(
      {super.key,
      required this.radius,
      required this.value,
      required this.maxValue});

  @override
  State<CircularSlider> createState() => _CircularSliderState<T>();
}

class _CircularSliderState<T> extends State<CircularSlider> {
  double castedRadius = 0;
  double castedValue = 0;
  double castedMaxValue = 0;
  double progress = 0;

  @override
  void initState() {
    super.initState();

    castedRadius = widget.radius.toDouble();
    castedValue = widget.value.toDouble();
    castedMaxValue = widget.maxValue.toDouble();
    progress = castedValue / castedMaxValue;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size(castedRadius, castedRadius),
          painter: LinePainter(
            progress: progress,
            path: circlePath(castedRadius),
            lineWidth: 11,
            lineColor: Colors.white24,
          ),
        ),
        CustomPaint(
          size: Size(castedRadius, castedRadius),
          painter: LinePainter(
            progress: progress,
            path: arcPath(
              castedRadius,
              progress,
            ),
            lineWidth: 6,
            isGradientEnabled: true,
          ),
        ),
      ],
    );
  }

  Path circlePath(double radius) {
    return Path()
      ..addOval(Rect.fromCircle(
        center: Offset(radius / 2, radius / 2),
        radius: radius,
      ));
  }

  Path arcPath(double radius, double progress) {
    return Path()
      ..addArc(
        Rect.fromCircle(center: Offset(radius / 2, radius / 2), radius: radius),
        -pi / 2,
        -(2 * pi) * progress,
      );
  }
}

class LinePainter extends CustomPainter {
  final double progress;
  final Path path;
  final double lineWidth;
  final Color? lineColor;
  final bool isGradientEnabled;

  LinePainter({
    required this.progress,
    required this.path,
    required this.lineWidth,
    this.lineColor,
    this.isGradientEnabled = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var shader = isGradientEnabled ? gradientShader(size) : null;
    final Paint _paint = Paint()
      ..shader = shader
      ..color = lineColor ?? Colors.white
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, _paint);
  }

  Shader gradientShader(Size size) {
    var rect = Offset.zero & size;
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [ColorConstants.gradientBlue, ColorConstants.gradientGreen],
    ).createShader(rect);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
