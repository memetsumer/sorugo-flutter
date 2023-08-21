import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../utils/constants.dart';

class StatusSleekItem extends StatelessWidget {
  final double value;
  final String topLabel;
  final String bottomLabel;
  final bool ccw;
  final double startAngle;
  StatusSleekItem(
      {Key? key,
      required this.value,
      required this.topLabel,
      required this.bottomLabel,
      required this.ccw,
      required this.startAngle})
      : super(key: key);

  final customWidth10 =
      CustomSliderWidths(trackWidth: 1, progressBarWidth: 4, shadowWidth: 30);
  final customColors10 = CustomSliderColors(
      dotColor: Colors.white.withOpacity(0.5),
      trackColor: const Color(0xFF303030),
      progressBarColors: [
        const Color.fromARGB(255, 114, 53, 124),
        const Color.fromARGB(255, 105, 3, 85),
        Colors.deepOrange.shade900,
      ],
      dynamicGradient: true,
      shadowColor: const Color.fromARGB(255, 114, 53, 124),
      shadowMaxOpacity: 0.1);

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
          customWidths: customWidth10,
          customColors: customColors10,
          startAngle: startAngle,
          angleRange: 240,
          infoProperties: InfoProperties(
              bottomLabelStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w200),
              bottomLabelText: bottomLabel,
              topLabelStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w200),
              topLabelText: topLabel,
              mainLabelStyle: const TextStyle(
                  color: Colors.white,
                  shadows: [
                    BoxShadow(
                      color: sliderMainLabelColor,
                      blurRadius: 12,
                    ),
                  ],
                  fontSize: 24.0,
                  fontWeight: FontWeight.w100),
              modifier: (double value) {
                final volume = value.toInt();
                return '$volume %';
              }),
          size: 135.0,
          counterClockwise: ccw,
          animDurationMultiplier: 3),
      min: 0,
      max: 100,
      initialValue: value,
    );
  }
}
