import 'package:flutter/material.dart';
import 'package:rick_and_morty/shared/palette.dart';

class InputStyles {
  static OutlineInputBorder borderSearch = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: Palette.grayExtraLight,
      width: 1,
    ),
  );
}
