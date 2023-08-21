import 'package:flutter/material.dart';
import '/screens/components/sorugo_card.dart';

import '../../../utils/constants.dart';

class StatusCard extends StatelessWidget {
  final String message;
  final String data;
  final double? maxWidth;
  const StatusCard({
    Key? key,
    required this.message,
    required this.data,
    this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SorugoCard(
      elevation: 0,
      constraints: BoxConstraints(maxWidth: maxWidth ?? width * 0.4),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Expanded(
                child: Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.9),
                      ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ]),
            Row(
              children: [
                Expanded(
                  child: Text(
                    data,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 23,
                        color: Colors.white,
                        shadows: const [
                          BoxShadow(
                            color: Color.fromARGB(127, 255, 255, 255),
                            blurRadius: 8,
                          )
                        ]),
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
