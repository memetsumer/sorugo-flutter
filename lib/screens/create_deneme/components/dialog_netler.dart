import 'package:flutter/material.dart';
import '/utils/constants.dart';

import '../../../models/adapters/deneme/deneme_adapter.dart';

import 'package:provider/provider.dart';
import '../../../models/denemeler/deneme_manager.dart';
import 'net_form.dart';

class DialogNetler extends StatefulWidget {
  const DialogNetler({Key? key}) : super(key: key);

  @override
  State<DialogNetler> createState() => _DialogNetlerState();
}

class _DialogNetlerState extends State<DialogNetler> {
  Map<String, Map<String, int>> netler = {};

  List<Map<String, dynamic>> denemeSorulari = [];

  @override
  Widget build(BuildContext context) {
    Deneme? deneme = context.watch<DenemeManager>().getDeneme;

    if (deneme == null) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.2,
        decoration: const BoxDecoration(
          color: darkBackgroundColorSecondary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(defaultPadding * 2),
            topRight: Radius.circular(defaultPadding * 2),
          ),
        ),
        child: const Center(
          child: Text("Lütfen Önce Deneme Türünü Seç!"),
        ),
      );
    }

    if (deneme.dersler == null || deneme.dersler!.isEmpty) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
          color: darkBackgroundColorSecondary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(defaultPadding * 2),
            topRight: Radius.circular(defaultPadding * 2),
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
            child: _buildPanelPicker(context, [
              {
                "name": deneme.name,
                "total": deneme.total,
              },
            ])),
      );
    }

    List<Map<String, dynamic>> denemeDersleri = deneme.dersler ?? [];

    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
        color: darkBackgroundColorSecondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(defaultPadding * 2),
          topRight: Radius.circular(defaultPadding * 2),
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
          child: _buildPanelPicker(context, denemeDersleri)),
    );
  }

  Widget _buildPanelPicker(
      BuildContext context, List<Map<String, dynamic>> denemeDersleri) {
    return ListView(
      children: [
        ...denemeDersleri.map((e) {
          return NetForm(
            titleName: e["name"],
            dersName: e["name"],
            soruCount: e["total"],
          );
        }).toList(),
        const SizedBox(height: defaultPadding),
      ],
    );
  }
}
