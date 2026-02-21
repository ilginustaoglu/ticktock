import 'package:flutter/material.dart';

/// Selectable colors for calendar events (and task accent).
class CalendarColors {
  CalendarColors._();

  static const List<int> eventColorHexes = [
    0xFF1A73E8, // mavi (primary)
    0xFF34A853, // yeşil
    0xFFEA4335, // kırmızı
    0xFFFBBC04, // sarı
    0xFF9C27B0, // mor
    0xFF00BCD4, // cyan
    0xFFFF5722, // turuncu
    0xFF795548, // kahve
    0xFF607D8B, // gri-mavi
  ];

  static const int defaultEventColorHex = 0xFF1A73E8;

  static Color colorFromHex(int hex) => Color(hex);

  static int hexFromColor(Color color) => color.value;
}
