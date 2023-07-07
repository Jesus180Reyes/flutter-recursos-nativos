import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.indigo,
      // textTheme: TextTheme(
      //   titleLarge: GoogleFonts.montserratAlternates(),
      //   titleMedium: GoogleFonts.montserratAlternates(fontSize: 35),
      // ),
    );
  }
}
