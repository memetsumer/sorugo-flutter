import 'package:flutter/material.dart';

import '../../../models/adapters/ders/ders_adapter.dart';
import '../../konu/konu_screen.dart';

class KonularListItem extends StatelessWidget {
  final List<dynamic> konular;
  final Ders ders;
  final int index;
  const KonularListItem({
    Key? key,
    required this.konular,
    required this.ders,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => KonuScreen(
                    dersObj: ders,
                    title: konular[index]["name"],
                    konu: konular[index],
                  ))),
      title: Text(
        konular[index]["name"],
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 18,
      ),
      dense: true,
    );
  }
}
