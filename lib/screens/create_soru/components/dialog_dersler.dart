import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../models/adapters/ders/ders_adapter.dart';
import '../../../models/sorular/soru_manager.dart';
import '../../../utils/constants.dart';

class DialogDersler extends StatefulWidget {
  const DialogDersler({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogDersler> createState() => _DialogDerslerState();
}

class _DialogDerslerState extends State<DialogDersler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColorSecondary,
      body: _buildPanelPicker(context),
    );
  }

  Widget _buildPanelPicker(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(dbOnlyDersNames).listenable(),
      builder: (context, Box box, widget) {
        final dersler = box.values.toList();
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Text("Dersler",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 21)),
            ),
            ...dersler
                .map(
                  (e) => InkWell(
                    onTap: () async {
                      Hive.lazyBox<Ders>(dbDersler).get(e["name"]).then(
                          (value) => {
                                context
                                    .read<SoruManager>()
                                    .setSelectedDers(value!)
                              });

                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Text(
                        e["name"],
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ],
        );
      },
    );
  }
}
