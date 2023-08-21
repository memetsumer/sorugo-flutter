import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../../models/sorular/soru_manager.dart';
import '../../../utils/constants.dart';

class ImportanceSoruPicker extends StatefulWidget {
  const ImportanceSoruPicker({Key? key}) : super(key: key);

  @override
  State<ImportanceSoruPicker> createState() => _ImportanceSoruPickerState();
}

class _ImportanceSoruPickerState extends State<ImportanceSoruPicker> {
  final List<String> importanceSoruList = ['Düşük', 'Orta', 'Yüksek'];

  late String _importance;

  @override
  void initState() {
    _importance = context.read<SoruManager>().importanceSoru;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: importanceSoruList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();

              setState(() {
                _importance = importanceSoruList[index];
                context.read<SoruManager>().setImportanceSoru(_importance);
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 10),
              constraints: const BoxConstraints(minWidth: 70),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultPadding),
                gradient: _importance == importanceSoruList[index]
                    ? const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 78, 36, 85),
                          Color.fromARGB(255, 66, 2, 53),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )
                    : LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                            Colors.white.withOpacity(0.05),
                            Colors.white.withOpacity(0.1),
                          ]),
                border: Border.all(
                  color: Colors.white24,
                  width: 1,
                ),
                boxShadow: _importance == importanceSoruList[index]
                    ? [
                        BoxShadow(
                          color: darkGradientPurple.withOpacity(0.8),
                          blurRadius: 15,
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.8),
                          blurRadius: 15,
                        ),
                      ],
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Center(
                  child: Text(
                    importanceSoruList[index],
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
