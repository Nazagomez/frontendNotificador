import 'package:flutter/material.dart';
import 'color_schemes.dart';

final lightTextTheme = TextTheme(
  titleLarge: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
    color: lightColorScheme.onSurface,
  ),
  bodyMedium: TextStyle(fontSize: 16, color: lightColorScheme.onSurface),
);

final darkTextTheme = TextTheme(
  titleLarge: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22,
    color: darkColorScheme.onSurface,
  ),
  bodyMedium: TextStyle(fontSize: 16, color: darkColorScheme.onSurface),
);
