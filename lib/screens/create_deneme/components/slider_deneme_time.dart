import 'package:flutter/material.dart';
import 'package:flutter_yks_app/utils/constants.dart';

import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '/models/denemeler/deneme_manager.dart';

class SliderDenemeTime extends StatelessWidget {
  const SliderDenemeTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customWidth03 =
        CustomSliderWidths(trackWidth: 1, progressBarWidth: 5, shadowWidth: 20);
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
        bottomLabelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        bottomLabelText: 'Süre',
        mainLabelStyle: const TextStyle(
          color: Colors.white,
          shadows: [
            BoxShadow(
              color: sliderMainLabelColor,
              blurRadius: 12,
            )
          ],
          fontSize: 30.0,
          fontWeight: FontWeight.w200,
        ),
        modifier: (double value) {
          final dk = value.toInt();
          return '$dk dk';
        });
    final CircularSliderAppearance appearance03 = CircularSliderAppearance(
        customWidths: customWidth03,
        customColors: customColors03,
        infoProperties: info03,
        size: 160.0,
        startAngle: 150,
        angleRange: 340);
    return SleekCircularSlider(
      onChangeStart: (double value) {},
      onChangeEnd: (double value) {
        context.read<DenemeManager>().setDenemeSure(value);
      },
      innerWidget: null,
      appearance: appearance03,
      min: 0,
      max: 220,
      initialValue: context.read<DenemeManager>().getDenemeSure,
    );
  }
}

class SliderDenemeTimeDetail extends StatelessWidget {
  final double value;
  const SliderDenemeTimeDetail({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customWidth03 = CustomSliderWidths(
      trackWidth: 1,
      progressBarWidth: 4,
      shadowWidth: 50,
    );
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
        // shadowColor: Color.fromARGB(94, 159, 159, 159),
        dynamicGradient: true,
        shadowMaxOpacity: 0.05);

    final info03 = InfoProperties(
        bottomLabelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        bottomLabelText: 'Süre',
        mainLabelStyle: const TextStyle(
          color: Colors.white,
          shadows: [
            BoxShadow(
              color: sliderMainLabelColor,
              blurRadius: 12,
            )
          ],
          fontSize: 30.0,
          fontWeight: FontWeight.w200,
        ),
        modifier: (double value) {
          final dk = value.toInt();
          return '$dk dk';
        });
    final CircularSliderAppearance appearance03 = CircularSliderAppearance(
      customWidths: customWidth03,
      customColors: customColors03,
      infoProperties: info03,
      size: 160.0,
      startAngle: 150,
      angleRange: 340,
    );
    return SleekCircularSlider(
      innerWidget: null,
      appearance: appearance03,
      min: 0,
      max: 230,
      initialValue: value,
    );
  }
}
