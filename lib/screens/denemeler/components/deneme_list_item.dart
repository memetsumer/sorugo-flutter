import 'package:flutter/material.dart';
import '../deneme_detail_screen.dart';
import '/screens/denemeler/components/deneme_list_item_timer.dart';

import '../../../utils/constants.dart';
import 'deneme_list_item_title_card.dart';

class DenemeListItem extends StatelessWidget {
  final Map<String, dynamic> data;

  final bool isLast;
  const DenemeListItem({
    Key? key,
    required this.data,
    required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final name = data["denemeTuru"];
    final length = name.length;
    final kind = data["ayt"];
    final suffix = name.substring(length - 3, length);

    final suffixUpdated = suffix == 'TYT' || suffix == 'AYT'
        ? ''
        : kind
            ? 'AYT'
            : 'TYT';

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? defaultPadding * 5 : 0),
      height: 135,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultPadding),
        boxShadow: [
          BoxShadow(
            color: darkGradientPurple.withOpacity(0.1),
            // spreadRadius: -10,
            blurRadius: 30,
            offset: const Offset(0, 18), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: DenemeListItemButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DenemeDetailScreen(
                        data: data,
                        title: "${data['denemeTuru']} $suffixUpdated");
                  },
                ),
              ),
              child: Container(
                height: 110,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultPadding),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(74, 78, 36, 85),
                    Color.fromARGB(56, 38, 5, 44),
                  ]),
                  border: Border.all(
                    color: Colors.white24,
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.only(
                  top: defaultPadding,
                  bottom: defaultPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    DenemeListItemTimer(sure: data["sure"].toString()),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Net",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            )),
                        Text(data["net"].toString(),
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    const SizedBox(
                      width: defaultPadding / 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Doğru",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.greenAccent,
                            )),
                        Text(data["dogru"].toString(),
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.greenAccent,
                            )),
                      ],
                    ),
                    const SizedBox(
                      width: defaultPadding / 2,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Yanlış",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.redAccent,
                            )),
                        Text(data["yanlis"].toString(),
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.redAccent,
                            )),
                      ],
                    ),
                    const SizedBox(
                      width: defaultPadding * 2,
                    ),
                    const SizedBox(
                      width: defaultPadding / 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 0,
              left: 0,
              child: Row(
                children: [
                  DenemeTitleCard(
                    child: Text(
                      "${data['denemeTuru']} $suffixUpdated",
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                  ),
                  DenemeTitleCard(
                    child: Text(
                      data["title"],
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                  ),
                  DenemeTitleCard(
                    child: Text(
                      data["importance"],
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textWidthBasis: TextWidthBasis.longestLine,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class DenemeListItemButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  const DenemeListItemButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
      child: child,
    );
  }
}
