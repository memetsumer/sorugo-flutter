import 'dart:math';

import 'package:flutter/material.dart';

class FlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;
  const FlipCard({required this.front, required this.back, Key? key})
      : super(key: key);

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  bool isFront = true;
  bool isFrontStart = true;
  double dragPosition = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    controller.addListener(() {
      setState(() {
        dragPosition = animation.value;
        setImageSide();
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final angle = dragPosition / 180 * pi;
    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.002)
      ..rotateY(angle);
    return GestureDetector(
      onHorizontalDragStart: (details) {
        controller.stop();
        isFrontStart = isFront;
      },
      onHorizontalDragUpdate: (details) => setState(() {
        dragPosition -= details.delta.dx;
        dragPosition %= 360;

        setImageSide();
      }),
      onHorizontalDragEnd: (details) {
        final velocity = details.velocity.pixelsPerSecond.dx.abs();

        if (velocity >= 50) {
          isFront = !isFrontStart;
        }

        final double end = isFront ? (dragPosition > 180 ? 360 : 0) : 180;
        animation =
            Tween<double>(begin: dragPosition, end: end).animate(controller);

        controller.forward(from: 0);
      },
      child: Transform(
          transform: transform,
          alignment: Alignment.center,
          child: isFront
              ? widget.front
              : Transform(
                  transform: Matrix4.identity()..rotateY(pi),
                  alignment: Alignment.center,
                  child: widget.back,
                )),
    );
  }

  void setImageSide() {
    if (dragPosition <= 90 || dragPosition >= 270) {
      isFront = true;
    } else {
      isFront = false;
    }
  }
}
