import 'package:flutter/material.dart';

import '../../../models/adapters/ders/ders_adapter.dart';
import '../../konu/konu_screen.dart';

class KonularList extends StatelessWidget {
  final List<dynamic> konular;
  final Ders ders;
  const KonularList({
    Key? key,
    required this.konular,
    required this.ders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: konular.length,
      itemBuilder: (context, index) => ListTile(
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
      ),
    );
  }
}
