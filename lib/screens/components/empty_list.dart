import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/utils/constants.dart';

class EmptyListScreen extends StatelessWidget {
  final String message;
  final String img;
  const EmptyListScreen({
    Key? key,
    required this.img,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height > 700
                ? MediaQuery.of(context).size.height * 0.35
                : MediaQuery.of(context).size.height * 0.35,
            child: Image.asset(
              img,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            message,
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.height > 700 ? 17 : 15,
            ),
          ),
        ),
        const Spacer(),
        const Spacer(),
      ],
    );
  }
}
