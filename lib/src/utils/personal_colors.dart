import 'package:flutter/material.dart';

class MyPersonalColors {
  static Color primaria = HexColor("#030D4F");
  static Color fundo = HexColor("#E7EDEA");
  static Color cardColor = HexColor("#F1F1F1");
  static Color vermelho = HexColor("#FB0C06");
  static Color cinza = HexColor("#707070");
  static Color branco = HexColor("#FFFFFF");
  static Color verde = HexColor("#00AF27");
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
