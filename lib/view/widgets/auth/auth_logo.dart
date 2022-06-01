import 'package:flutter/material.dart';

class AnimatedLogo extends StatefulWidget {
  AnimatedLogo({Key? key}) : super(key: key);

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 120),
      vsync: this,
    );
    _controller.repeat(reverse: true);
    super.initState();
    _controller.addListener(() {});
    _textController.addListener(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    late final Animation<double> logoRotation = Tween(begin: -0.03, end: 0.03)
        .animate(_controller)
      ..addStatusListener((status) {});

    late final Animation<double> textRotation = Tween(begin: 0.03, end: -0.03)
        .animate(_controller)
      ..addStatusListener((status) {});
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        AnimatedBuilder(
            animation: logoRotation,
            builder: (BuildContext context, _) {
              return Transform(
                alignment: FractionalOffset.bottomCenter,
                transform: Matrix4.rotationZ(logoRotation.value),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        width: 2),
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Art',
                      style: TextStyle(
                        fontFamily: 'VarelaRound',
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        //fontFamily: "VarelaRound-regular",
                      ),
                    ),
                  ),
                ),
              );
            }),
        Positioned(
          right: -70,
          bottom: 160,
          child: AnimatedBuilder(
              animation: textRotation,
              builder: (BuildContext context, _) {
                return Transform(
                  transform: Matrix4.rotationZ(
                    textRotation.value,
                  ),
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              Theme.of(context).colorScheme.tertiaryContainer,
                          width: 2),
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Gallery',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'VarelaRound',
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          //fontFamily: "VarelaRound-regular",
                        ),
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
