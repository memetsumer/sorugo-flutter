import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class StatusItem extends StatelessWidget {
  final String title;
  final Map<String, int> data;

  const StatusItem({Key? key, required this.title, required this.data})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
      const SizedBox(
        height: defaultPadding,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "   TYT :    ",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          Text(
            data["tyt"].toString(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
        ],
      ),
      const SizedBox(
        height: defaultPadding,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "   AYT :    ",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          Text(
            data["ayt"].toString(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    ]);
  }
}
