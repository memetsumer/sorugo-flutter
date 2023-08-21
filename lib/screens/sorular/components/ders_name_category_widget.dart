import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class DersNameCategoryWidget extends StatelessWidget {
  final String name;
  const DersNameCategoryWidget({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(
        minWidth: size.width * 0.2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultPadding),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding / 2),
        child: Center(
          child: Text(
            name,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
