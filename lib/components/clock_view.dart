import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  const ClockView({Key? key}) : super(key: key);

  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: pi, end: pi - pi * 2),
        duration: Duration(seconds: 60),
        builder: (context, value, child) {
          return CustomPaint(
            painter: ClockPainter(value),
          );
        },
      ),
    );
  }
}
// creating the Clock Painter Class

class ClockPainter extends CustomPainter {
  double seconds = pi / 2;
  ClockPainter(this.seconds);

  @override
  void paint(Canvas canvas, Size size) {
    // cetting the Center point coordinates
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    /* Setting the Time coordinates */
    var secHeight = radius / 2;
    var minHeight = radius / 2 - 10;
    var hoursHeight = radius / 2 - 20;

    var seconds = Offset(centerX + sin(this.seconds) * secHeight,
        centerY + cos(this.seconds) * secHeight);
    var minutes = Offset(
        centerX + sin(pi / 4) * minHeight, centerY + cos(pi / 4) * minHeight);
    var hours = Offset(centerX + sin(pi / 3) * hoursHeight,
        centerY + cos(pi / 3) * hoursHeight);

    // Setting the Fillbrush paint
    var fillBrush = Paint()
      ..color = Color(0xFF444974)
      ..strokeCap = StrokeCap.round;

    var outlineBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16;

    var centerDotBrush = Paint()..color = Color(0xFFEAECFF);

    /* Setting the hands brush */

    var secHandBrush = Paint()
      ..color = Colors.orange.shade600
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 8
      ..strokeJoin = StrokeJoin.round;

    var minHandBrush = Paint()
      ..color = Colors.blue.shade600
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12
      ..strokeJoin = StrokeJoin.round;

    var hourHandBrush = Paint()
      ..color = Colors.pink.shade600
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12
      ..strokeJoin = StrokeJoin.round;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    // drawing the sec hand
    canvas.drawLine(center, seconds, secHandBrush);
    canvas.drawLine(center, minutes, minHandBrush);
    canvas.drawLine(center, hours, hourHandBrush);

    canvas.drawCircle(center, 16, centerDotBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
