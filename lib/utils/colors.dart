import 'package:flutter/material.dart';

final colors = <String, Color>{
  "blurple": const Color(0xFF5865F2),
  "darkblurple": const Color(0xFF141897),
  "green": const Color(0xFF57F287),
  "yellow": const Color(0xFFFEE75C),
  "fuchsia": const Color(0xFFEB459E),
  "red": const Color(0xFFED4245),
  "black": const Color(0xFF000000),
  "white": const Color(0xFFFFFFFF),
  "charcoal": const Color(0xFF1C1D22),
  "lightgrey": const Color(0xFF32323C),
};

class ThemeColor {
  static Color primary = colors["blurple"]!;
  static Color secondary = colors["green"]!;
  static Color accent = colors["yellow"]!;
  static Color error = colors["red"]!;
  static Color background = colors["charcoal"]!;
  static Color button = colors["darkblurple"]!;
  static Color input = colors["lightgrey"]!;
}