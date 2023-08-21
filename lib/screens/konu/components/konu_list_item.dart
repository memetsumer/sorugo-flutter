import 'package:badges/badges.dart' as my_badge;
import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class KonuListItem extends StatelessWidget {
  final String konu;
  final int cozumBekleniyor;
  final bool taramaBekleniyor;
  const KonuListItem({
    Key? key,
    required this.konu,
    required this.cozumBekleniyor,
    required this.taramaBekleniyor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: darkBackgroundColorSecondary,
            boxShadow: const [
              BoxShadow(
                blurRadius: 1,
                color: Color.fromRGBO(30, 41, 59, 1),
              )
            ],
            borderRadius: BorderRadius.circular(defaultPadding / 2),
          ),
          margin: const EdgeInsets.all(defaultPadding / 2),
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Text(
              konu,
              overflow: TextOverflow.fade,
              softWrap: false,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        if (cozumBekleniyor != 0) _buildCozumBekleniyor(cozumBekleniyor),
        if (taramaBekleniyor) _buildTaramaBekleniyor(),
      ],
    );
  }

  Positioned _buildTaramaBekleniyor() {
    return Positioned(
      top: 0,
      right: defaultPadding * 5,
      child: my_badge.Badge(
        elevation: 2,
        toAnimate: true,
        shape: my_badge.BadgeShape.square,
        badgeColor: Colors.purpleAccent,
        borderRadius: BorderRadius.circular(defaultPadding / 2),
        badgeContent: const Text(
          "Tarama Var!",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Positioned _buildCozumBekleniyor(int val) {
    return Positioned(
      top: 0,
      right: defaultPadding,
      child: my_badge.Badge(
        elevation: 2,
        toAnimate: true,
        shape: my_badge.BadgeShape.square,
        badgeColor: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(defaultPadding / 2),
        badgeContent:
            Text('Çöz: $val', style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
