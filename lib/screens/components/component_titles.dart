import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class ComponentTitle extends StatelessWidget {
  final String desc;
  final double margTop, margBot;
  final double? margLeft;

  const ComponentTitle(
      {Key? key,
      required this.desc,
      required this.margTop,
      required this.margBot,
      this.margLeft})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: defaultPadding * margTop,
        bottom: defaultPadding * margBot,
      ),
      child: Text(desc),
    );
  }
}
