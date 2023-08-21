import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '/utils/constants.dart';
import '../../../models/sorular/sorular_manager.dart';
import 'ders_name_category_widget.dart';
import 'glassmorphic_category_widget.dart';

class SorularCategory extends StatefulWidget {
  const SorularCategory({Key? key}) : super(key: key);

  @override
  State<SorularCategory> createState() => _SorularCategoryState();
}

class _SorularCategoryState extends State<SorularCategory> {
  late String selectedDers;
  late String selectedTur;

  @override
  void initState() {
    selectedDers = 'Tümü';
    selectedTur = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(dbOnlyDersNames).listenable(),
        builder: (context, Box box, widget) {
          final dersler = box.values.toList();

          dersler.insert(0, {'name': 'Tümü', 'ayt': false});

          return SizedBox(
            height: defaultPadding * 5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              itemCount: dersler.length,
              itemBuilder: (context, index) {
                final ders = dersler[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDers = ders["name"]!;
                    });
                    HapticFeedback.lightImpact();

                    context
                        .read<SorularManager>()
                        .setQueryDersName(ders["name"]!);

                    context
                        .read<SorularManager>()
                        .setAyt(ders["ayt"] as bool ? true : false);

                    context.read<SorularManager>().setQueryTur('');
                  },
                  child: GlassmorphicCategoryWidget(
                    isSelected: selectedDers == ders["name"]!,
                    child: DersNameCategoryWidget(
                      name: ders["name"]!,
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
