import 'package:adora_baby/app/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/sp_calculator.dart';

MaterialColor mycolor = MaterialColor(
  const Color.fromRGBO(174, 5, 233, 1).value,
  const <int, Color>{
    50: Color.fromRGBO(247, 230, 253, 1),
    100: Color.fromRGBO(230, 178, 248, 1),
    200: Color.fromRGBO(128, 140, 245, 1),
    300: Color.fromRGBO(201, 88, 240, 1),
    400: Color.fromRGBO(190, 55, 237, 1),
    500: Color.fromRGBO(174, 5, 233, 1),
    600: Color.fromRGBO(158, 5, 212, 1),
    700: Color.fromRGBO(124, 4, 165, 1),
    800: Color.fromRGBO(96, 3, 128, 1),
    900: Color.fromRGBO(73, 2, 98, 1),
  },
);

final kThemeDataDark = ThemeData.dark();

final kThemeData = ThemeData(primarySwatch: mycolor).copyWith(
    primaryColor: const Color(0xffAE05E9),
    hintColor: Colors.grey[900],
    splashColor: const Color(0xffAE05E9).withOpacity(0.5),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      // iconTheme: IconThemeData(
      //   color: Color(0xff4ebfa3),
      // ),
    ),
    textTheme: const TextTheme().copyWith(
      //Heading1
      displayLarge: const TextStyle(
          color: Colors.black,
          fontFamily: "Playfair",
          fontSize: 64,
          fontWeight: FontWeight.w800,
          fontStyle: FontStyle.normal,
          letterSpacing: -0.02),

      //Heading2
      displayMedium: const TextStyle(
          color: Colors.black,
          fontFamily: "PLayfair",
          fontSize: 40,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          letterSpacing: -0.02),

      //Heading3
      displaySmall:  TextStyle(
          color: Colors.black,
          fontFamily: "Playfair",
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.01),

      //Big Copy/ Subtitle
      titleLarge: const TextStyle(
          color: Colors.black,
          fontFamily: "Poppins",
          fontSize: 24,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.04),

      //Strong
      titleMedium: const TextStyle(
          color: Colors.black,
          fontFamily: "Poppins",
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.04),

      //Emphasized
      titleSmall: const TextStyle(
          color: Colors.black,
          fontFamily: "Poppins",
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
          letterSpacing: 0.04),

      //Body Copy
      bodyLarge: const TextStyle(
          color: Colors.black,
          fontFamily: "Poppins",
          fontSize: 16,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.04),

      //Small Copy
      bodyMedium: const TextStyle(
          color: AppColors.mainColor,
          fontFamily: "Poppins",
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.08),


      //Caption
      bodySmall: const TextStyle(
          color: Colors.black,
          fontFamily: "Poppins",
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.12),

      //Pre-title
      labelLarge: const TextStyle(
          color: Colors.black,
          fontFamily: "Poppins",
          fontSize: 24,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
          letterSpacing: -0.01),

      //Button Text
      labelMedium: const TextStyle(
          color: Colors.white,
          fontFamily: "Poppins",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          letterSpacing: 0),

      //Card Body
      labelSmall: const TextStyle(
          color: Colors.black,
          fontFamily: "Poppins",
          fontSize: 16,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.04),
    ),
    colorScheme: const ColorScheme.light().copyWith(
      primary: const Color(0xffAE05E9),
      secondary: const Color(0xffAE05E9),
      error: const Color(0xffAE05E9),
    ),);
