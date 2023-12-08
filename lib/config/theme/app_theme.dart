import 'package:flutter/material.dart';

const Color _customColor = Color(0xFFFECE2E);

const List<Color> _colorThemes = [
  _customColor,
  Colors.purple,
  Colors.red,
  Colors.green,
  Colors.lightGreen,
  Colors.lightBlue,
  Colors.yellow,
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0 && selectedColor < _colorThemes.length,
            "Colors must be in 0 to list.size");

  ThemeData theme() {
    return ThemeData(
        useMaterial3: true, colorSchemeSeed: _colorThemes[selectedColor]);
  }
}
