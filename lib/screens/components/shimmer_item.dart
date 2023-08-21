import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/constants.dart';

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
      child: Container(
          alignment: Alignment.center,
          height: 130,
          decoration: BoxDecoration(
              color: darkBackgroundColorSecondary,
              borderRadius: BorderRadius.circular(defaultPadding)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(defaultPadding),
                    child: AspectRatio(
                        aspectRatio: 0.8,
                        child: Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 33, 33, 33),
                            highlightColor:
                                const Color.fromARGB(255, 78, 36, 85),
                            child: Container(
                              height: 100,
                              width: 100,
                              color: Colors.grey.shade300,
                            )))),
                const SizedBox(width: defaultPadding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      _buildShimmer(context, 150),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      _buildShimmer(context, 150),
                      const Spacer(),
                      _buildShimmer(context, 100),
                      const SizedBox(
                        height: 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Shimmer _buildShimmer(context, double width) {
    return Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 33, 33, 33),
        highlightColor: const Color.fromARGB(255, 78, 36, 85),
        child: Container(
          height: defaultPadding,
          width: width,
          color: Colors.grey.shade600,
        ));
  }
}
