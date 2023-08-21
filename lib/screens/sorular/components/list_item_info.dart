import 'package:flutter/material.dart';

class ListItemInfo extends StatelessWidget {
  final String msg;
  final TextStyle? style;

  const ListItemInfo({Key? key, required this.msg, this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Text(
            msg,
            overflow: TextOverflow.fade,
            softWrap: false,
            style: style,
          ),
        ),
      ],
    );
  }
}
