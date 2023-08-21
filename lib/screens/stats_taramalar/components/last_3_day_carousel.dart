import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import 'stats_counter.dart';

class Last3DayCarouselWidget extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const Last3DayCarouselWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (data[0]["count"] <= 0 &&
          data[1]["count"] <= 0 &&
          data[2]["count"] <= 0) {
        return const Padding(
          padding: EdgeInsets.all(defaultPadding * 2),
          child: Text(
            "Son 3 günlük taramalarınızın burada gözükmesi için veri ekleyin.",
            textAlign: TextAlign.center,
          ),
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 230,
              width: double.infinity,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  aspectRatio: 1,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  reverse: false,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: data
                    .map(
                      (data) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: defaultPadding,
                            bottom: defaultPadding,
                          ),
                          child: StatsCounter(
                            value: data["count"],
                            max: max(
                              (data["count"] as int) * 2,
                              max((data["count"] as int) * 2,
                                  (data["count"] as int) * 2),
                            ),
                            bottomTitle: data["date"] as String,
                          ),
                        );
                      },
                    )
                    .toList()
                    .cast(),
              ),
            ),
          ],
        );
      }
    });
  }
}
