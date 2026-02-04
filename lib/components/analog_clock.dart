import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class CustomAnalogClock extends StatefulWidget {
  const CustomAnalogClock({super.key});

  @override
  State<CustomAnalogClock> createState() => _CustomAnalogClockState();
}

class _CustomAnalogClockState extends State<CustomAnalogClock> {
  late Timer _timer;
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Update clock every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _dateTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: ClockPainter(_dateTime),
        size: Size(180, 180),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  final DateTime dateTime;

  ClockPainter(this.dateTime);

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = min(centerX, centerY);

    Paint fillBrush = Paint()..color = Color.fromARGB(255, 255, 255, 255);
    Paint outlineBrush = Paint()
      ..color = Color(0xFFeceff4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;

    // Draw clock circle
    canvas.drawCircle(Offset(centerX, centerY), radius - 10, fillBrush);
    canvas.drawCircle(Offset(centerX, centerY), radius - 10, outlineBrush);

    // ================= Draw Tick Marks (12, 3, 6, 9) =================
    Paint tickBrush = Paint()
      ..color = Color(0xFF3c3b3f)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 4; i++) {
      double angle = (pi / 2) * i;
      double outerX = centerX + (radius - 35) * cos(angle - pi / 2);
      double outerY = centerY + (radius - 35) * sin(angle - pi / 2);

      double innerX = centerX + (radius - 28) * cos(angle - pi / 2);
      double innerY = centerY + (radius - 28) * sin(angle - pi / 2);

      canvas.drawLine(
        Offset(innerX, innerY),
        Offset(outerX, outerY),
        tickBrush,
      );
    }

    // ================== Hour hand ==================
    double hourX =
        centerX +
        40 *
            cos(
              (dateTime.hour % 12 + dateTime.minute / 60) * 30 * pi / 180 -
                  pi / 2,
            );
    double hourY =
        centerY +
        40 *
            sin(
              (dateTime.hour % 12 + dateTime.minute / 60) * 30 * pi / 180 -
                  pi / 2,
            );

    canvas.drawLine(
      Offset(centerX, centerY),
      Offset(hourX, hourY),
      Paint()
        ..color = Color(0xFF646e82)
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round,
    );

    // ================== Minute hand ==================
    double minX = centerX + 50 * cos(dateTime.minute * 6 * pi / 180 - pi / 2);
    double minY = centerY + 50 * sin(dateTime.minute * 6 * pi / 180 - pi / 2);

    canvas.drawLine(
      Offset(centerX, centerY),
      Offset(minX, minY),
      Paint()
        ..color = Color(0xFF646e82)
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round,
    );

    // ================== Second hand ==================
    double secX = centerX + 60 * cos(dateTime.second * 6 * pi / 180 - pi / 2);
    double secY = centerY + 60 * sin(dateTime.second * 6 * pi / 180 - pi / 2);

    canvas.drawLine(
      Offset(centerX, centerY),
      Offset(secX, secY),
      Paint()
        ..color = Colors.red
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );

    // ================== Center Dot ==================
    canvas.drawCircle(
      Offset(centerX, centerY),
      8,
      Paint()..color = Color(0xFF646e82),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
