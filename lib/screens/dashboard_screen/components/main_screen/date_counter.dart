import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../../utils/constants.dart';

class Counter extends StatelessWidget {
  const Counter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const double max = 365;
    const double min = 0;

    return ValueListenableBuilder(
      valueListenable: Hive.box(dbSettings).listenable(),
      builder: (context, Box box, _) {
        DateTime? val = box.get("date");

        if (val == null) {
          return SizedBox(
            width: size.width * 0.4,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Center(
            child: SleekCircularSlider(
          appearance: CircularSliderAppearance(
              infoProperties: InfoProperties(
                  topLabelStyle:
                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color.fromARGB(185, 255, 255, 255),
                            fontWeight: FontWeight.w200,
                          ),
                  topLabelText: "Sınava",
                  mainLabelStyle: const TextStyle(
                    color: Colors.white,
                    shadows: [
                      BoxShadow(
                        color: sliderMainLabelColor,
                        blurRadius: 12,
                      )
                    ],
                    fontSize: 30.0,
                    fontWeight: FontWeight.w100,
                  ),
                  bottomLabelStyle:
                      Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color.fromARGB(185, 255, 255, 255),
                            fontWeight: FontWeight.w200,
                          ),
                  bottomLabelText: "Kaldı",
                  modifier: (double value) {
                    final volume = value.toInt();
                    return '$volume gün';
                  }),
              customWidths: CustomSliderWidths(
                  trackWidth: 1, progressBarWidth: 4, shadowWidth: 30),
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
              size: size.width * 0.46),
          min: min,
          max: max,
          initialValue:
              math.max(0, daysBetween(DateTime.now(), val)).toDouble(),
        ));
      },
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
