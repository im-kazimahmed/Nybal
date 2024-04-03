import 'package:flutter/material.dart';

var mainClr = const Color(0xFFfffafb);

///
class AppColors {
  ///
  static const Color blueColor = Color(0xFF27B2CC);
  static const Color pink = Color(0xFFFF4550);
  static const Color pinkButton = Color(0xFFCC1262);
  static const Color whiteColor = Colors.white;
  static const Color darkColor = Colors.black;
  ///
  static Color pink100 = pink.withOpacity(.1);
  ///
  static Color pink300 = pink.withOpacity(.3);
  ///
  static Color pink400 = pink.withOpacity(.4);

  static const Color appBarPurple = Color(0xff261A32);

}

class TextStyles {
  TextStyles._();

  static TextStyle get logo => const TextStyle(
    fontFamily: Fonts.product,
    color: Color(0xFF45405B),
    fontSize: 22.0, //22.0
    fontWeight: FontWeight.bold,
    letterSpacing: 1.0,
  );

  static TextStyle get menu_item => const TextStyle(
    fontFamily: Fonts.product,
    fontSize: 12.0, //12,.0
    letterSpacing: 1.0,
    color: Color(0xFF45405B),
  );

  static TextStyle get heading => const TextStyle(
    fontFamily: Fonts.nexa_bold,
    color: Color(0xFF45405B),
    fontSize: 45.0, //45.0
    fontWeight: FontWeight.bold,
    letterSpacing: 1.0,
  );

  static TextStyle get sub_heading => const TextStyle(
    color: Color(0xFF45405B),
    fontFamily: Fonts.product,
    fontSize: 17.0, //17.0
    letterSpacing: 1.2,
  );

  static TextStyle get company => const TextStyle(
    fontFamily: Fonts.product,
    color: Color(0xFF45405B),
    height: 1.5,
    fontSize: 15.0, //15.0
    letterSpacing: 1.0,
  );

  static TextStyle get body => const TextStyle(
    fontFamily: Fonts.product,
    color: Color(0xFF85819C),
    height: 1.5,
    fontSize: 12.0, //12.0
    letterSpacing: 1.0,
  );

  static TextStyle get body1 => const TextStyle(
    fontFamily: Fonts.product,
    color: Color(0xFF85819C),
    height: 1.5,
    fontSize: 10.0, //10.0
    letterSpacing: 1.0,
  );

  static TextStyle get chip => const TextStyle(
    fontFamily: Fonts.product,
    color: Color(0xFF85819C),
    height: 1.5,
    fontSize: 12.0, //12.0
    letterSpacing: 1.0,
  );
}

class Fonts {
  Fonts._();

  static const String product = 'ProductSans';
  static const String nexa_light = 'NexaLight';
  static const String nexa_bold = 'NexaBold';

}