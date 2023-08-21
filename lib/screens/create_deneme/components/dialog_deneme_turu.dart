import 'package:flutter/material.dart';
import '/utils/constants.dart';
import '/models/adapters/deneme/deneme_adapter.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../models/denemeler/deneme_manager.dart';

import 'package:provider/provider.dart';

class DialogDenemeTurleri extends StatefulWidget {
  const DialogDenemeTurleri({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogDenemeTurleri> createState() => _DialogDenemeTurleriState();
}

class _DialogDenemeTurleriState extends State<DialogDenemeTurleri> {
  Deneme? selectedDeneme;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Deneme>(dbDenemeler).listenable(),

        //db den gelen deneme değerlerini gir
        builder: (context, Box<Deneme> box, _) {
          List<Deneme> denemeler = box.values.toList();

          return ListView(
            children: [
              ...denemeler.map(
                (e) {
                  final name = e.name;
                  final length = name.length;
                  final kind = e.kind;
                  final suffix = name.substring(length - 3, length);

                  final suffixUpdated = suffix == 'TYT' || suffix == 'AYT'
                      ? ''
                      : kind == 'ayt'
                          ? 'AYT'
                          : 'TYT';

                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedDeneme = e;
                      });
                      context.read<DenemeManager>().setSelectedDeneme(e);
                      context.read<DenemeManager>().resetAllNetData();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Text(
                        "$name $suffixUpdated",
                      ),
                    ),
                  );
                },
              ).toList(),
            ],
          );
        },
      ),
    );
  }
}
