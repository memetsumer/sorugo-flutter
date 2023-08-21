import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

class SorugoAppTheme {
  static TextTheme textTheme = TextTheme(
    bodyLarge: GoogleFonts.poppins(
      fontSize: 15.0,
      color: Colors.white.withOpacity(0.8),
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 13.0,
      color: Colors.white.withOpacity(0.8),
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: Colors.white.withOpacity(0.8),
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 19.0,
      color: Colors.white.withOpacity(0.8),
      fontWeight: FontWeight.w400,
    ),
  );

  static final theme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackgroundColor,
    primaryColor: Colors.white,
    textTheme: textTheme,
    colorScheme:
        const ColorScheme.dark().copyWith(background: darkBackgroundColor),
  );
}
