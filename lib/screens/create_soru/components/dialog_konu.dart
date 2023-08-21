import 'package:flutter/material.dart';
import 'package:flutter_yks_app/utils/constants.dart';
import 'package:provider/provider.dart';

import '../../../models/sorular/soru_manager.dart';

class DialogKonu extends StatefulWidget {
  const DialogKonu({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogKonu> createState() => _DialogKonuState();
}

class _DialogKonuState extends State<DialogKonu> {
  late List<Map<String, String>> _statefulKonular;
  Exam exam = Exam.both;

  @override
  void initState() {
    _statefulKonular = context.read<SoruManager>().getSelectedKonular;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColorSecondary,
      body: _buildPanelPicker(context),
    );
  }

  Widget _buildPanelPicker(BuildContext context) {
    return _statefulKonular.isEmpty
        ? const Center(
            child: Text("Lütfen İlk Önce Ders Seç!"),
          )
        : ListView(
            children: [
              if (context
                      .read<SoruManager>()
                      .getSelectedKonular
                      .any((element) => element["kind"] == "ayt") &&
                  (context.read<SoruManager>().selectedDers!.name !=
                          "Geometri" &&
                      context.read<SoruManager>().selectedDers!.name !=
                          "Edebiyat")) ...[
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Text(
                    "Sınav Türü",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 21),
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    Text(Exam.tyt.name.toUpperCase()),
                    Radio(
                        value: Exam.tyt,
                        groupValue: exam,
                        onChanged: (e) {
                          context.read<SoruManager>().resetSelectedKonu();

                          setState(() {
                            _statefulKonular = context
                                .read<SoruManager>()
                                .getSelectedKonular
                                .where((element) => element["kind"] == "tyt")
                                .toList();
                          });

                          setState(() {
                            exam = Exam.tyt;
                          });
                        }),
                    const Spacer(),
                    Text(Exam.ayt.name.toUpperCase()),
                    Radio(
                      value: Exam.ayt,
                      groupValue: exam,
                      onChanged: (e) {
                        context.read<SoruManager>().resetSelectedKonu();

                        setState(() {
                          _statefulKonular = context
                              .read<SoruManager>()
                              .getSelectedKonular
                              .where((element) => element["kind"] == "ayt")
                              .toList();
                        });

                        setState(() {
                          exam = Exam.ayt;
                        });
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Text(
                  "Konular",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 21),
                ),
              ),
              ..._statefulKonular
                  .map(
                    (e) => SelectKonuListItem(
                      konu: e,
                    ),
                  )
                  .toList(),
            ],
          );
  }
}

class SelectKonuListItem extends StatelessWidget {
  final Map<String, String> konu;
  const SelectKonuListItem({
    Key? key,
    required this.konu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<SoruManager>().setSelectedKonu(konu["name"] as String);
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Text(
          "${konu['name']}",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}

enum Exam { tyt, ayt, both }
