import 'package:flutter/material.dart';

class MyPainterCanvas extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var dx = size.width / 2;
    var dy = size.height / 2;
    var c = Offset(dx, dy);

    var radius = 40.0;
    var paint = Paint();
    canvas.drawCircle(c, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter o) {
    return true;
  }
}
