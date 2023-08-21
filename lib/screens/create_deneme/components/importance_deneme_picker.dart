import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../../models/denemeler/deneme_manager.dart';
import '/utils/constants.dart';

class ImportanceDenemePicker extends StatefulWidget {
  const ImportanceDenemePicker({Key? key}) : super(key: key);

  @override
  State<ImportanceDenemePicker> createState() => _ImportanceDenemePickerState();
}

class _ImportanceDenemePickerState extends State<ImportanceDenemePicker> {
  late String _importance;

  @override
  void initState() {
    _importance = context.read<DenemeManager>().importanceDeneme;
    super.initState();
  }

  final List<String> importanceDenemeList = ['Kolay', 'Orta', 'Zor'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: importanceDenemeList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();

              setState(() {
                _importance = importanceDenemeList[index];
                context
                    .read<DenemeManager>()
                    .setImportanceDeneme(importanceDenemeList[index]);
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              constraints: const BoxConstraints(maxWidth: 80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultPadding),
                gradient: _importance == importanceDenemeList[index]
                    ? const LinearGradient(colors: [
                        Color.fromARGB(255, 78, 36, 85),
                        Color.fromARGB(255, 66, 2, 53),
                      ])
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
                boxShadow: _importance == importanceDenemeList[index]
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
              child: Center(
                child: Text(
                  importanceDenemeList[index],
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 13,
                        color: Colors.white,
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
