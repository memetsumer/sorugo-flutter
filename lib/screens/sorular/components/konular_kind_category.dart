import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yks_app/screens/sorular/components/ders_name_category_widget.dart';
import 'package:flutter_yks_app/screens/sorular/components/glassmorphic_category_widget.dart';
import 'package:provider/provider.dart';

import '/utils/constants.dart';
import '../../../models/sorular/sorular_manager.dart';

class KonuKindCategory extends StatefulWidget {
  const KonuKindCategory({Key? key}) : super(key: key);

  @override
  State<KonuKindCategory> createState() => _KonuKindCategoryState();
}

class _KonuKindCategoryState extends State<KonuKindCategory> {
  List<Map<String, String>> kind = [
    {'name': 'AYT', 'code': 'ayt'},
    {'name': 'TYT', 'code': 'tyt'},
  ];

  @override
  Widget build(BuildContext context) {
    bool ayt = context.watch<SorularManager>().getAyt;

    if (context.watch<SorularManager>().getQueryDersName == 'Tümü' ||
        !ayt ||
        context.watch<SorularManager>().getQueryDersName == 'Edebiyat') {
      return const SizedBox.shrink();
    }

    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: SizedBox(
        height: defaultPadding * 4.5,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: kind.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                context
                    .read<SorularManager>()
                    .setQueryTur(kind[index]["code"] as String);
                HapticFeedback.lightImpact();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: defaultPadding, horizontal: 0),
                child: GlassmorphicCategoryWidget(
                  isSelected: context.watch<SorularManager>().getQueryTur ==
                      kind[index]["code"],
                  child: DersNameCategoryWidget(
                    name: kind[index]["name"] as String,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
