import 'package:flutter/material.dart';

import '/screens/sorular/components/photo_detail.dart';
import '../../../utils/constants.dart';

class Soru extends StatelessWidget {
  final Widget child;
  final String url;
  const Soru({
    Key? key,
    required this.child,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
      child: AspectRatio(
        aspectRatio: 0.75,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhotoDetail(
                                url: url,
                              )));
                },
                child: Stack(
                  children: [
                    child,
                  ],
                ))),
      ),
    );
  }
}
