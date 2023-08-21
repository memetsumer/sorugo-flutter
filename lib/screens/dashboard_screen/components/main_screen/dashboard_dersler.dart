import 'package:flutter/material.dart';
import 'package:flutter_yks_app/screens/ders/ders_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../models/app_provider.dart';
import '../../../../utils/constants.dart';
import '../content_card.dart';

class DashboardDersler extends StatefulWidget {
  const DashboardDersler({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardDersler> createState() => _DashboardDerslerState();
}

class _DashboardDerslerState extends State<DashboardDersler> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        bool isFirstTime = context.read<AppProvider>().getFirstTime;

        if (isFirstTime) {
          Future.delayed(
            const Duration(milliseconds: 500),
            () => setState(
              () {},
            ),
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(dbOnlyDersNames).listenable(),
      builder: (context, Box box, widget) {
        var dersler = box.values.toList();

        if (dersler.isEmpty) {
          return const SizedBox(
            height: 180,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return SizedBox(
          height: defaultPadding * 5,
          child: ListView.builder(
            itemCount: dersler.length,
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ContentCard(
                title: dersler[index]['name'],
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DersScreen(
                      newDersName: dersler[index]["name"],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
