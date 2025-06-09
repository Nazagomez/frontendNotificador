import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF6C63FF);
const Color kLightBackground = Color(0xFFF9FAFB);
const Color kDarkBackground = Color(0xFF121212);

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: kPrimaryColor,
  brightness: Brightness.light,
  surface: kLightBackground,
);

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: kPrimaryColor,
  brightness: Brightness.dark,
  surface: kDarkBackground,
);
