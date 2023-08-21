import 'package:flutter/material.dart';
import 'package:flutter_yks_app/screens/components/cached_img.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';

class HighlightedUser extends StatelessWidget {
  final int rank;
  final Map<String, dynamic> data;
  final double photoRadius;
  final double rankSize;
  const HighlightedUser({
    Key? key,
    required this.rank,
    required this.data,
    required this.photoRadius,
    required this.rankSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          rank.toString(),
          style: GoogleFonts.pressStart2p(
            color: Colors.white,
            fontSize: rankSize,
          ),
        ),
        const SizedBox(
          height: defaultPadding / 2,
        ),
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.amber,
                blurRadius: 30,
                spreadRadius: 1,
              ),
            ],
          ),
          // color: Colors.amber.withOpacity(0.2),
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: photoRadius,
            child: data['photoUrl'] != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(photoRadius),
                    child: CachedImg(
                      imgUrl: data["photoUrl"],
                    ))
                : FaIcon(
                    FontAwesomeIcons.user,
                    color: Colors.white.withOpacity(0.8),
                    size: photoRadius,
                  ),
          ),
        ),
        const SizedBox(
          height: defaultPadding * 2,
        ),
        SizedBox(
          width: defaultPadding * 6,
          child: Center(
            child: Text(
              data["name"],
              style: GoogleFonts.pressStart2p(
                color: Colors.white,
                fontSize: 12,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        Text(
          data["score"].toString(),
          style: GoogleFonts.pressStart2p(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
