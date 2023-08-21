import 'package:flutter/material.dart';

import '../../../models/adapters/ders/ders_adapter.dart';
import '../../../utils/constants.dart';

import 'ders_stat_widget.dart';
import 'konular_list_item.dart';

class TypedDers extends StatelessWidget {
  const TypedDers({
    Key? key,
    required this.dersObj,
    required this.isAYTNotEmpty,
    required this.isTYTNotEmpty,
    required this.konularAYT,
    required this.type,
  }) : super(key: key);

  final Ders dersObj;
  final bool isAYTNotEmpty;
  final bool isTYTNotEmpty;
  final String type;
  final List<Map<String, String>> konularAYT;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            key: PageStorageKey<String>(type),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverToBoxAdapter(
                child: DersStatsWidget(
                    dersObj: dersObj,
                    type: type,
                    isAYTNotEmpty: isAYTNotEmpty,
                    isTYTNotEmpty: isTYTNotEmpty),
              ),
              SliverFixedExtentList(
                itemExtent: 48.0,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return KonularListItem(
                        konular: konularAYT, ders: dersObj, index: index);
                  },
                  childCount: konularAYT.length,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: defaultPadding * 3,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
