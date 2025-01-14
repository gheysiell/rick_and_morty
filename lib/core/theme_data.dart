import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_and_morty/shared/palette.dart';

ThemeData buildTheme() {
  ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Palette.primary,
    ),
    useMaterial3: true,
  );

  return themeData.copyWith(
    textTheme: GoogleFonts.nunitoTextTheme(
      themeData.textTheme,
    ),
  );
}
