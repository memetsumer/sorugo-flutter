import 'package:flutter/material.dart';
import 'package:flutter_yks_app/utils/premium_function.dart';
import 'package:provider/provider.dart';

import '../../../models/adapters/ders/ders_adapter.dart';
import '../../../models/denemeler/deneme_manager.dart';
import '../../../utils/constants.dart';
import 'net_ekle_dialog.dart';

class NetEkleWidget extends StatefulWidget {
  const NetEkleWidget({
    Key? key,
    required this.dersObj,
    required this.isAYTNotEmpty,
  }) : super(key: key);

  final Ders dersObj;
  final bool isAYTNotEmpty;

  @override
  State<NetEkleWidget> createState() => _NetEkleWidgetState();
}

class _NetEkleWidgetState extends State<NetEkleWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: defaultPadding),
      child: TextButton(
        onPressed: () => premiumFunction(
            context,
            mounted,
            () =>
                netEklePremium(context, widget.dersObj, widget.isAYTNotEmpty)),
        child: Text(
          "Net Ekle",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.blueAccent),
        ),
      ),
    );
  }

  void netEklePremium(BuildContext context, Ders dersObj, bool isAYTNotEmpty) {
    context.read<DenemeManager>().resetDersNetData();
    netEkle(context, dersObj, isAYTNotEmpty);
  }
}
