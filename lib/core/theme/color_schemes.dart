import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF002366);

const Color kLightBackground = Color(0xFFFFFFFF);
const Color kDarkBackground = Color(0xFF121212);

const Color kLightCardBackground = Color(0xFFE3E9F3);
const Color kDarkCardBackground = Color(0xFF1E1E1E);

final lightColorScheme = ColorScheme.fromSeed(
  seedColor: kPrimaryColor,
  brightness: Brightness.light,
  surface: kLightBackground,
  surfaceContainerHighest: kLightCardBackground,
);

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: kPrimaryColor,
  brightness: Brightness.dark,
  surface: kDarkBackground,
  surfaceContainerHighest: kDarkCardBackground,
);
