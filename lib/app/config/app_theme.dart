import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final kThemeData = ThemeData().copyWith(
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
          fontFamily: "Encode Sans",
          fontSize: 64,
          fontWeight: FontWeight.w800,
          fontStyle: FontStyle.normal,
          letterSpacing: -0.02),

      //Heading2
      displayMedium: const TextStyle(
          color: Colors.black,
          fontFamily: "Encode Sans",
          fontSize: 40,
          fontWeight: FontWeight.w800,
          fontStyle: FontStyle.normal,
          letterSpacing: -0.02),

      //Heading3
      displaySmall: const TextStyle(
          color: Colors.black,
          fontFamily: "Encode Sans",
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
          color: Colors.black,
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
          color: Colors.black,
          fontFamily: "Poppins",
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.normal,
          letterSpacing: 0.04),

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
      primary: Color(0xffAE05E9),
      secondary: Color(0xffAE05E9),
      error: Color(0xffAE05E9),
    ));
