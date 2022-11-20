import 'package:adora_baby/utils/sp_calculator.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary50 = Color.fromRGBO(247, 230, 253, 1);
  static const Color primary100 = Color.fromRGBO(230, 178, 248, 1);
  static const Color primary200 = Color.fromRGBO(128, 140, 245, 1);
  static const Color primary300 = Color.fromRGBO(201, 88, 240, 1);
  static const Color primary400 = Color.fromRGBO(190, 55, 237, 1);
  static const Color primary500 = Color.fromRGBO(174, 5, 233, 1);
  static const Color primary600 = Color.fromRGBO(158, 5, 212, 1);
  static const Color primary700 = Color.fromRGBO(124, 4, 165, 1);
  static const Color primary800 = Color.fromRGBO(96, 3, 128, 1);
  static const Color primary900 = Color.fromRGBO(73, 2, 98, 1);
  static const Color linear1 = Color.fromRGBO(127,0,255,1);
  static const Color linear2 = Color.fromRGBO(255,0,255,1);
  static const Color mainColor = Color.fromRGBO(181, 103, 233, 1);


  static const Color secondary50 = Color.fromRGBO(253, 242, 243, 1);
  static const Color secondary100 = Color.fromRGBO(249, 214, 217, 1);
  static const Color secondary200 = Color.fromRGBO(247, 194, 198, 1);
  static const Color secondary300 = Color.fromRGBO(243, 167, 173, 1);
  static const Color secondary400 = Color.fromRGBO(241, 149, 157, 1);
  static const Color secondary500 = Color.fromRGBO(237, 123, 132, 1);
  static const Color secondary600 = Color.fromRGBO(216, 112, 120, 1);
  static const Color secondary700 = Color.fromRGBO(168, 87, 94, 1);
  static const Color secondary800 = Color.fromRGBO(130, 68, 73, 1);
  static const Color secondary900 = Color.fromRGBO(100, 52, 55, 1);

  static const Color success50 = Color.fromRGBO(244, 253, 235, 1);
  static const Color success100 = Color.fromRGBO(220, 248, 192, 1);
  static const Color success200 = Color.fromRGBO(203, 244, 161, 1);
  static const Color success300 = Color.fromRGBO(179, 239, 118, 1);
  static const Color success400 = Color.fromRGBO(164, 236, 92, 1);
  static const Color success500 = Color.fromRGBO(141, 231, 51, 1);
  static const Color success600 = Color.fromRGBO(128, 210, 46, 1);
  static const Color success700 = Color.fromRGBO(100, 164, 36, 1);
  static const Color success800 = Color.fromRGBO(78, 127, 28, 1);
  static const Color success900 = Color.fromRGBO(59, 97, 21, 1);

  static const Color error500 = Color.fromRGBO(231, 51, 51, 1);

  static const Color warning500 = Color.fromRGBO(231, 125, 54, 1);
}

class LightTheme {
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color whiteHover = Color.fromRGBO(253, 252, 254, 1);
  static const Color whiteActive = Color.fromRGBO(250, 245, 252, 1);

  static const Color light = Color.fromRGBO(253, 252, 254, 1);
  static const Color lightHover = Color.fromRGBO(250, 245, 252, 1);
  static const Color lightActive = Color.fromRGBO(247, 239, 251, 1);

  static const Color normal = Color.fromRGBO(252, 249, 253, 1);
  static const Color normalHover = Color.fromRGBO(248, 241, 151, 1);
  static const Color normalActive = Color.fromRGBO(243, 234, 249, 1);
  static const Color dark = Color.fromRGBO(250, 246, 252, 1);
}

class AppText {
  static final heading4 = TextStyle(
      color: Color(0xff1D242D),
      fontSize: getResponsiveFont(16),
      fontFamily: 'Poppins',
      letterSpacing: 0.04,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400);
}

class DarkTheme {
  static const Color lighter = Color.fromRGBO(255, 255, 255, 1);
  static const Color lightHover = Color.fromRGBO(253, 252, 254, 1);
  static const Color lightActive = Color.fromRGBO(250, 245, 252, 1);

  static const Color normal = Color.fromRGBO(253, 252, 254, 1);
  static const Color normalHover = Color.fromRGBO(250, 245, 252, 1);
  static const Color normalActive = Color.fromRGBO(247, 239, 251, 1);

  static const Color dark = Color.fromRGBO(252, 249, 253, 1);
  static const Color darkHover = Color.fromRGBO(248, 241, 151, 1);
  static const Color darkActive = Color.fromRGBO(243, 234, 249, 1);
}