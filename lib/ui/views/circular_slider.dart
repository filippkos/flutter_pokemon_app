import 'dart:math';
import 'package:flutter/material.dart';

class CircularSlider extends StatefulWidget {
  final double radius;
  final double progres;

  const CircularSlider(
      {super.key, required this.radius, required this.progres});

  @override
  State<CircularSlider> createState() => _CircularSliderState();
}

class _CircularSliderState extends State<CircularSlider> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CustomPaint(
        painter: LinePainter(
          progress: 1,
          path: circlePath(widget.radius),
          lineWidth: 11,
          lineColor: Colors.black12
        )
      ),
      CustomPaint(
        painter: LinePainter(
          progress: 1,
          path: arcPath(
            widget.radius,
            widget.progres,
          ),
          lineWidth: 6,
          lineColor: Colors.white
        )
      ),
    ]);
  }

  Path circlePath(double radius) {
    return Path()
      ..addOval(
        Rect.fromCircle(
          center: const Offset(0, 0),
          radius: radius,
        )
      );
  }

  Path arcPath(double radius, double progress) {
    return Path()
      ..addArc(
        Rect.fromCircle(
          center: const Offset(0, 0),
          radius: radius),
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

  LinePainter(
    {required this.progress,
    required this.path,
    required this.lineWidth,
    this.lineColor}
  );

  @override
  void paint(Canvas canvas, Size size) {
    final Paint _paint = Paint()
      ..color = lineColor ?? Colors.amber
      ..strokeWidth = lineWidth
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
