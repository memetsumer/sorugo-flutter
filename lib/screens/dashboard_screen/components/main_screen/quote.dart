import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/constants.dart';

class QuoteWidget extends StatelessWidget {
  final List<Map<String, dynamic>> quotes;
  const QuoteWidget({
    Key? key,
    required this.quotes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rand = Random().nextInt(quotes.length);

    final String? quote = quotes[rand]['quote'];
    final String? author = quotes[rand]['author'];

    return quote != null
        ? Container(
            padding: const EdgeInsets.symmetric(
                vertical: defaultPadding, horizontal: defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeIn(
                  delay: const Duration(milliseconds: 500),
                  child: Text(
                    quote,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poiretOne(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: defaultPadding / 2),
                if (author != null) ...[
                  Row(
                    children: [
                      const Spacer(),
                      FadeInRight(
                        delay: const Duration(milliseconds: 750),
                        child: Text(
                          "-$author",
                          style: GoogleFonts.poiretOne(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]
                //make a quote widget
              ],
            ),
          )
        : const SizedBox(
            height: defaultPadding,
          );
  }
}
