import 'package:flutter/material.dart';
import 'package:flutter_yks_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import '../../../models/denemeler/deneme_manager.dart';

class NetForm extends StatefulWidget {
  final String? titleName;
  final String dersName;
  final int soruCount;

  const NetForm({
    Key? key,
    this.titleName,
    required this.dersName,
    required this.soruCount,
  }) : super(key: key);

  @override
  State<NetForm> createState() => _NetFormState();
}

class _NetFormState extends State<NetForm> {
  Map<String, int> dogruVeYanlis = {
    'dogru': 0,
    'yanlis': 0,
    'total': 0,
  };

  @override
  void initState() {
    setState(() {
      dogruVeYanlis['total'] = widget.soruCount;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> netler =
        context.read<DenemeManager>().restoreNetData(widget.dersName);
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: defaultPadding / 2, horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.titleName != null)
            Text(
              widget.titleName!,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
            ),
          const SizedBox(height: 8.0),
          Text(
            "Doğru",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                ),
          ),
          SpinBox(
            incrementIcon: const Icon(
              Icons.add,
              size: 40,
            ),
            decrementIcon: const Icon(
              Icons.remove,
              size: 40,
            ),
            readOnly: true,
            showCursor: false,
            onChanged: (double x) {
              setState(() {
                dogruVeYanlis['dogru'] = x.toInt();
              });
              context
                  .read<DenemeManager>()
                  .addNetData(widget.dersName, dogruVeYanlis);
            },
            spacing: 2,
            textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 40,
                  // fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
            min: 0,
            max: widget.soruCount.toDouble() -
                dogruVeYanlis['yanlis']!.toDouble(),
            value: netler["dogru"]!.toDouble(),
            decimals: 0,
            step: 1,
            acceleration: 1,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            validator: (text) => int.parse(text!) >
                    widget.soruCount.toDouble() - dogruVeYanlis['yanlis']!
                ? 'Invalid'
                : null,
          ),
          Text(
            "Yanlış",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                ),
          ),
          SpinBox(
            readOnly: true,
            incrementIcon: const Icon(
              Icons.add,
              size: 40,
            ),
            decrementIcon: const Icon(
              Icons.remove,
              size: 40,
            ),
            onChanged: (double x) {
              setState(() {
                dogruVeYanlis['yanlis'] = x.toInt();
              });
              context
                  .read<DenemeManager>()
                  .addNetData(widget.dersName, dogruVeYanlis);
            },
            spacing: 4,
            min: 0,
            max: widget.soruCount.toDouble() -
                dogruVeYanlis['dogru']!.toDouble(),
            value: netler["yanlis"]!.toDouble(),
            decimals: 0,
            step: 1,
            acceleration: 1,
            textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 40,
                  // fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            validator: (text) => int.parse(text!) >
                    widget.soruCount.toDouble() - dogruVeYanlis['dogru']!
                ? 'Invalid'
                : null,
          ),
        ],
      ),
    );
  }
}
