import 'package:flutter_pokemon_app/const/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokemon_app/gen/fonts.gen.dart';

TextTheme lightTextTheme() {
  return TextTheme(
    displayMedium: TextStyle(
      color: ColorConstants.abbey,
      fontSize: 40,
      fontFamily: FontFamily.paytoneOne,
      fontWeight: FontWeight.w800,
    ),
    headlineLarge: TextStyle(
      color: ColorConstants.abbey,
      fontSize: 24,
      fontFamily: FontFamily.plusJakartaSans,
      fontWeight: FontWeight.w900
    ),
    headlineMedium: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontFamily: FontFamily.plusJakartaSans,
      fontWeight: FontWeight.w800
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontFamily: FontFamily.plusJakartaSans,
      fontWeight: FontWeight.w500
    ),
    titleLarge: TextStyle(
      color: ColorConstants.abbey,
      fontSize: 22,
      fontFamily: FontFamily.paytoneOne,
      fontWeight: FontWeight.w400
    ),
    titleMedium: TextStyle(
      color: ColorConstants.gold,
      fontSize: 15,
      fontFamily: FontFamily.plusJakartaSans,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      color: ColorConstants.heather,
      fontSize: 15,
      fontFamily: FontFamily.plusJakartaSans,
      fontWeight: FontWeight.w500
    ),
    labelLarge: TextStyle(
      color: Colors.black,
      backgroundColor: ColorConstants.gold,
      fontSize: 20,
      fontFamily: FontFamily.plusJakartaSans,
      fontWeight: FontWeight.w800
    ),
    labelMedium: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontFamily: FontFamily.plusJakartaSans,
      fontWeight: FontWeight.w800
    ),
    labelSmall: TextStyle(
      fontSize: 13,
      fontFamily: FontFamily.plusJakartaSans,
      fontWeight: FontWeight.w600
    ),
    bodyMedium: TextStyle(
      color: ColorConstants.abbey,
      fontSize: 15,
      fontFamily: FontFamily.plusJakartaSans,
      fontWeight: FontWeight.w500
    )
  );
}

TextTheme darkTextTheme() {
  return TextTheme(
    displayMedium: TextStyle(
      color: ColorConstants.heather,
      fontSize: 40,
      fontFamily: FontFamily.paytoneOne,
      fontWeight: FontWeight.w800,
    ),
    headlineLarge: TextStyle(
      color: ColorConstants.abbey,
      fontSize: 24,
      fontFamily: FontFamily.plusJakartaSans,
      fontWeight: FontWeight.w900
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontFamily: FontFamily.plusJakartaSans,
      fontWeight: FontWeight.w500
    ),
    titleLarge: TextStyle(
      color: ColorConstants.heather,
      fontSize: 22,
      fontFamily: FontFamily.paytoneOne,
      fontWeight: FontWeight.w400
    ),
    titleMedium: TextStyle(
      color: ColorConstants.gold,
      fontSize: 15,
      fontFamily: FontFamily.plusJakartaSans,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      color: ColorConstants.heather,
      fontSize: 15,
      fontFamily: FontFamily.plusJakartaSans,
      fontWeight: FontWeight.w500
    ),
    labelLarge: TextStyle(
      color: Colors.black,
      backgroundColor: ColorConstants.gold,
      fontSize: 20,
      fontFamily: FontFamily.plusJakartaSans,
      fontWeight: FontWeight.w800
    ),
    labelMedium: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontFamily: FontFamily.plusJakartaSans,
      fontWeight: FontWeight.w800
    ),
    labelSmall: TextStyle(
      fontSize: 13,
      fontFamily: FontFamily.plusJakartaSans,
      fontWeight: FontWeight.w600
    ),
    bodyMedium: TextStyle(
      color: ColorConstants.heather,
      fontSize: 15,
      fontFamily: FontFamily.plusJakartaSans,
      fontWeight: FontWeight.w500
    )
  );
}