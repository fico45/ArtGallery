import 'package:artgallery/view/widgets/background/my_painter_canvas.dart';
import 'package:artgallery/view/widgets/background/particle.dart';
import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({Key? key}) : super(key: key);

  @override
  _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: MyPainterCanvas(),
        child: Container(),
      ),
    );
  }
}
