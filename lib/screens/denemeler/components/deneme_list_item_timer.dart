import 'package:flutter/material.dart';

import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class DenemeListItemTimer extends StatelessWidget {
  final String sure;

  const DenemeListItemTimer({
    Key? key,
    required this.sure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customWidth03 =
        CustomSliderWidths(trackWidth: 1, progressBarWidth: 2, shadowWidth: 20);
    final customColors03 = CustomSliderColors(
      trackColors: [
        const Color(0xFFFFF8CB).withOpacity(0.7),
        const Color(0xFFB9FFFF).withOpacity(0.7),
      ],
      progressBarColors: [
        const Color.fromARGB(255, 255, 109, 155),
        const Color.fromARGB(255, 255, 255, 255),
        const Color.fromARGB(255, 237, 136, 255),
      ],
      dynamicGradient: true,
      shadowMaxOpacity: 0.05,
    );

    final info03 = InfoProperties(
        bottomLabelStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: const Color.fromARGB(255, 175, 16, 255),
              fontWeight: FontWeight.w700,
            ),
        mainLabelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 17.0,
          fontWeight: FontWeight.w200,
        ),
        modifier: (double value) {
          final dk = value.toInt();
          return '$dk dk';
        });
    final CircularSliderAppearance appearance03 = CircularSliderAppearance(
        customWidths: customWidth03,
        customColors: customColors03,
        animationEnabled: false,
        infoProperties: info03,
        size: 130.0,
        startAngle: 150,
        angleRange: 340);
    return SizedBox(
      width: 100,
      child: SleekCircularSlider(
        innerWidget: null,
        appearance: appearance03,
        min: 0,
        max: 230,
        initialValue: double.parse(sure),
      ),
    );
  }
}
