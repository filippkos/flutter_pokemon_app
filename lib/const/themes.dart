import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/const/color_constants.dart';
import 'package:flutter_pokemon_app/const/text_themes.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.transparent,
    secondary: Colors.white,
    surface: Colors.white,
    onSurface: ColorConstants.abbey,
    surfaceVariant: ColorConstants.wildSand,
    onSurfaceVariant: ColorConstants.abbey,
    background: ColorConstants.wildSand,
    onBackground: ColorConstants.abbey,
    brightness: Brightness.light
  ),
  useMaterial3: true,
  textTheme: lightTextTheme()
);

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.transparent,
    secondary: ColorConstants.abbeyDark,
    surface: ColorConstants.abbey,
    onSurface: ColorConstants.heather,
    surfaceVariant: ColorConstants.heather,
    onSurfaceVariant: ColorConstants.abbey,
    background: ColorConstants.abbeyDark,
    onBackground: ColorConstants.abbey,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
  textTheme: darkTextTheme()
);