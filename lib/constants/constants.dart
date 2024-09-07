import 'package:flutter/material.dart';

const lightPrimaryColor = Color(0xff8a51d1);
const darkPrimaryColor = Color(0xff000000);

class Constants{
  static const kPrimary = Color(0xff8a51d1);

  static const MaterialColor kSwatchColor = MaterialColor(
      0xff8A51d1,
      <int, Color>{
        50: Color(0xff9662d6), //10%
        100: Color(0xffa174da), //20%
        200: Color(0xffad85df), //30%
        300: Color(0xffb997e3), //40%
        400: Color(0xffc5a8e8), //50%
        500: Color(0xffd0b9ed), //60%
        600: Color(0xffdccbf1), //70%
        700: Color(0xffe8dcf6), //80%
        800: Color(0xfff3eefa), //90%
        900: Color(0xffffffff), //100%
      }
  );

  static int? juzIndex;
  static int? surahIndex;
}