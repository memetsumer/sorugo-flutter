import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as my_badge;
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants.dart';
import 'list_item_info.dart';

class SorularListItem extends StatelessWidget {
  final Map<String, dynamic> data;
  final int idx;
  final Widget child;
  final bool isLast;
  final VoidCallback onPressed;
  const SorularListItem({
    Key? key,
    required this.data,
    required this.idx,
    required this.child,
    required this.isLast,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final Color color;

    switch (data["importance"]) {
      case 'Düşük':
        color = const Color.fromARGB(163, 76, 175, 79);
        break;
      case 'Orta':
        color = const Color.fromARGB(154, 255, 214, 64);
        break;
      case 'Yüksek':
        color = const Color.fromARGB(158, 255, 0, 0);
        break;
      default:
        color = Colors.tealAccent;
    }

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? defaultPadding * 5 : 0),
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultPadding),
        boxShadow: [
          BoxShadow(
            color: darkGradientPurple.withOpacity(0.2),
            // spreadRadius: -10,
            blurRadius: 30,
            offset: const Offset(0, 18), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: 100,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultPadding),
                gradient: const LinearGradient(
                  colors: [
                    // const Color.fromARGB(255, 78, 36, 85),
                    // const Color.fromARGB(255, 66, 2, 53).withOpacity(0.3),

                    Color.fromARGB(74, 78, 36, 85),
                    Color.fromARGB(56, 38, 5, 44),

                    // defaultLightGrey
                  ],
                ),
                border: Border.all(
                  color: Colors.white24,
                  width: 0.7,
                ),
              ),
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: darkGradientPurple,
                  padding: EdgeInsets.zero,
                  // enableFeedback: true,

                  splashFactory: InkSparkle.splashFactory,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultPadding),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 100,
                    ),
                    Center(
                      child: SizedBox(
                        height: double.infinity,
                        width: size.width * 0.9 - 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: defaultPadding / 2,
                            ),
                            if (data['ders'] != "Geometri" &&
                                data["ders"] != "Edebiyat")
                              ListItemInfo(
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                  ),
                                  msg: (data['konuKind'] as String)
                                      .toUpperCase()),
                            ListItemInfo(
                              msg: data['ders'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            const SizedBox(
                              height: defaultPadding / 2,
                            ),
                            ListItemInfo(
                              msg: data['konu'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const Spacer(),
                    // const SizedBox(
                    //   width: defaultPadding / 2,
                    // )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: Container(
              width: 80,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 15),
                    blurRadius: 12,
                    color: Colors.black45,
                  )
                ],
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(defaultPadding / 2),
                  child: AspectRatio(aspectRatio: 0.75, child: child)),
            ),
          ),
          if (!data["hasCozum"] && !data["isCozumUzerinde"])
            Positioned(
              top: defaultPadding * 2.6,
              right: defaultPadding,
              child: my_badge.Badge(
                elevation: 2,
                toAnimate: true,
                shape: my_badge.BadgeShape.square,
                badgeColor: const Color.fromARGB(159, 255, 112, 159),
                borderRadius: BorderRadius.circular(defaultPadding / 2),
                badgeContent: Text(
                  'Çözüm Bekleniyor!',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          if (data["hasCozum"] || data["isCozumUzerinde"])
            Positioned(
              top: defaultPadding * 2.6,
              right: defaultPadding,
              child: my_badge.Badge(
                elevation: 2,
                toAnimate: true,
                shape: my_badge.BadgeShape.square,
                badgeColor: const Color.fromARGB(173, 76, 175, 79),
                borderRadius: BorderRadius.circular(defaultPadding / 2),
                badgeContent: Text(
                  'Çözüldü',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          Positioned(
            top: defaultPadding * 4.5,
            right: defaultPadding,
            child: my_badge.Badge(
              elevation: 2,
              toAnimate: true,
              shape: my_badge.BadgeShape.square,
              badgeColor: color,
              borderRadius: BorderRadius.circular(defaultPadding / 2),
              badgeContent: Text(
                data["importance"],
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
