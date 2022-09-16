import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WordStockTheme {
  static ThemeData light() {
    return ThemeData(
      textTheme: GoogleFonts.sawarabiGothicTextTheme(),
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: const Color.fromARGB(255, 151, 181, 238),
    );
  }
}
