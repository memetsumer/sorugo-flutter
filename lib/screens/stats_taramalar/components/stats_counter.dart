import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../utils/constants.dart';

class StatsCounter extends StatelessWidget {
  final int value;
  final String bottomTitle;
  final String? topTitle;
  final int max;
  const StatsCounter({
    Key? key,
    required this.value,
    required this.bottomTitle,
    required this.max,
    this.topTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double min = 0;

    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        infoProperties: InfoProperties(
            mainLabelStyle: const TextStyle(
              color: Colors.white,
              shadows: [
                BoxShadow(
                  color: sliderMainLabelColor,
                  blurRadius: 8,
                ),
              ],
              fontSize: 50.0,
              fontWeight: FontWeight.w100,
            ),
            bottomLabelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                ),
            bottomLabelText: bottomTitle,
            topLabelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: sliderLabelColor,
                  fontWeight: FontWeight.w200,
                ),
            topLabelText: topTitle,
            modifier: (double value) {
              final volume = value.toInt();
              return '$volume';
            }),
        customWidths: CustomSliderWidths(
          trackWidth: 1,
          progressBarWidth: 4,
          shadowWidth: 30,
        ),
        customColors: CustomSliderColors(
          dotColor: Colors.white.withOpacity(0.1),
          trackColor: const Color(0xFF303030),
          progressBarColors: [
            const Color.fromARGB(255, 114, 53, 124),
            const Color.fromARGB(255, 105, 3, 85),
            Colors.deepOrange.withOpacity(0.9),
          ],
          shadowColor: darkGradientPurple.withOpacity(0.9),
          dynamicGradient: true,
          shadowMaxOpacity: 0.1,
        ),
        startAngle: 180,
        angleRange: 360,
        size: 300,
      ),
      min: min,
      max: max.toDouble() + 20,
      initialValue: value.toDouble(),
    );
  }
}
