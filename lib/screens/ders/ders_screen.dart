import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../utils/constants.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../models/adapters/ders/ders_adapter.dart';
import 'components/net_ekle_widget.dart';
import 'components/typed_ders.dart';

class DersScreen extends StatefulWidget {
  final String newDersName;

  const DersScreen({
    Key? key,
    required this.newDersName,
  }) : super(key: key);

  @override
  State<DersScreen> createState() => _DersScreenState();
}

class _DersScreenState extends State<DersScreen> {
  @override
  void initState() {
    FirebaseAnalytics.instance.logScreenView(
      screenName: 'DersScreen',
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isGeometri = widget.newDersName == "Geometri";

    String dersName = widget.newDersName;

    return Scaffold(
      body: FutureBuilder(
        future: Hive.lazyBox<Ders>(dbDersler).get(dersName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          Ders dersObj = snapshot.data as Ders;

          final konularTYT = dersObj.konular
              .where((element) => element["kind"] == "tyt")
              .toList();
          final konularAYT = dersObj.konular
              .where((element) => element["kind"] == "ayt")
              .toList();

          final isTYTNotEmpty = konularTYT.isNotEmpty;
          final isAYTNotEmpty = konularAYT.isNotEmpty;

          return DefaultTabController(
            length: isAYTNotEmpty && isTYTNotEmpty ? 2 : 1,
            child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                // These are the slivers that show up in the "outer" scroll view.
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverAppBar(
                      title: Text(
                        widget.newDersName,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 22),
                      ),
                      forceElevated: innerBoxIsScrolled,
                      elevation: 0,
                      iconTheme: IconThemeData(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                      actions: [
                        if (!isGeometri)
                          NetEkleWidget(
                              dersObj: dersObj, isAYTNotEmpty: isAYTNotEmpty),
                      ],
                      centerTitle: false,
                      backgroundColor: darkBackgroundColor,
                      bottom: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        unselectedLabelColor: Colors.grey,
                        labelColor: Colors.white70,
                        indicatorColor: Colors.white70,
                        indicatorWeight: 1,
                        tabs: [
                          if (isTYTNotEmpty)
                            Tab(
                              child: Text(
                                "TYT",
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          if (isAYTNotEmpty)
                            Tab(
                              child: Text(
                                !isGeometri ? "AYT" : "Geometri",
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  if (isTYTNotEmpty)
                    TypedDers(
                        dersObj: dersObj,
                        type: "tyt",
                        isAYTNotEmpty: isAYTNotEmpty,
                        isTYTNotEmpty: isTYTNotEmpty,
                        konularAYT: konularTYT),
                  if (isAYTNotEmpty)
                    TypedDers(
                      dersObj: dersObj,
                      type: "ayt",
                      isAYTNotEmpty: isAYTNotEmpty,
                      isTYTNotEmpty: isTYTNotEmpty,
                      konularAYT: konularAYT,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
