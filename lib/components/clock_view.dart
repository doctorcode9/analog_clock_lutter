import 'dart:math';

import 'package:analog_clock/utils/time.dart';
import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  ClockView(this.time, {Key? key}) : super(key: key);
  DataTime time;
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: CustomPaint(
        painter:
            ClockPainter(widget.time.hour, widget.time.min, widget.time.sec),
      ),
    );
  }
}
// creating the Clock Painter Class

class ClockPainter extends CustomPainter {
  int? seconds;
  int? minutes;
  int? hours;
  ClockPainter(this.hours, this.minutes, this.seconds);

  @override
  void paint(Canvas canvas, Size size) {
    //setting the time conversion
    double secRad = ((pi / 2) - (pi / 30) * this.seconds!) % (2 * pi);
    double minRad = ((pi / 2) - (pi / 30) * this.minutes!) % (2 * pi);
    double hourRad = ((pi / 2) - (pi / 6) * this.hours!) % (2 * pi);

    // cetting the Center point coordinates
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    /* Setting the Time coordinates */
    var secHeight = radius / 2;
    var minHeight = radius / 2 - 10;
    var hoursHeight = radius / 2 - 20;

    var seconds = Offset(
        centerX + secHeight * cos(secRad), centerY - secHeight * sin(secRad));
    var minutes = Offset(
        centerX + cos(minRad) * minHeight, centerY - sin(minRad) * minHeight);
    var hours = Offset(centerX + cos(hourRad) * hoursHeight,
        centerY - sin(hourRad) * hoursHeight);

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
