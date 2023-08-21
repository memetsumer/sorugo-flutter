import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import '../../../models/denemeler/deneme_manager.dart';
import '../../../utils/constants.dart';

class NetFormDers extends StatefulWidget {
  final String dersName;
  final int soruCount;

  const NetFormDers({
    Key? key,
    required this.dersName,
    required this.soruCount,
  }) : super(key: key);

  @override
  State<NetFormDers> createState() => _NetFormDersState();
}

class _NetFormDersState extends State<NetFormDers> {
  @override
  Widget build(BuildContext context) {
    Map<String, int> netler = context.read<DenemeManager>().getDersNetData;
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: defaultPadding),
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
              context.read<DenemeManager>().setDersNetDogru(x.toInt());
            },
            spacing: 2,
            min: 0,
            max: widget.soruCount.toDouble() -
                (context.watch<DenemeManager>().getDersNetData["yanlis"] as int)
                    .toDouble(),
            value: netler["dogru"]!.toDouble(),
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
                    widget.soruCount.toDouble() -
                        (context.watch<DenemeManager>().getDersNetData["yanlis"]
                                as int)
                            .toDouble()
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
            incrementIcon: const Icon(
              Icons.add,
              size: 40,
            ),
            decrementIcon: const Icon(
              Icons.remove,
              size: 40,
            ),
            readOnly: true,
            onChanged: (double x) {
              context.read<DenemeManager>().setDersNetYanlis(x.toInt());
            },
            spacing: 4,
            min: 0,
            max: widget.soruCount.toDouble() -
                (context.watch<DenemeManager>().getDersNetData["dogru"] as int)
                    .toDouble(),
            value: netler["yanlis"]!.toDouble(),
            decimals: 0,
            step: 1,
            acceleration: 1,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 40,
                  // fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
            validator: (text) => int.parse(text!) >
                    widget.soruCount.toDouble() -
                        (context.watch<DenemeManager>().getDersNetData["dogru"]
                                as int)
                            .toDouble()
                ? 'Invalid'
                : null,
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
