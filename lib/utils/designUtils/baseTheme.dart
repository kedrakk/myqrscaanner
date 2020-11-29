import 'package:flutter/material.dart';
import 'package:myqrscanner/utils/designUtils/myColors.dart';

class MyThemeData{

  static ThemeData ligthTheme(){
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: MyColors.primaryColor,
      primaryColorBrightness: Brightness.light,
      accentColor: MyColors.primaryColor,
      primaryIconTheme: IconThemeData(color: MyColors.whiteColor,size: 16),
      accentIconTheme: IconThemeData(color: MyColors.whiteColor,size: 16),
      textTheme: TextTheme(body1: TextStyle(color: MyColors.blackColor)),
      appBarTheme: AppBarTheme(textTheme: TextTheme(title: TextStyle(color: MyColors.whiteColor))),
    );  
  }

  static ThemeData darkTheme(){
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: MyColors.greyColor,
      primaryColorBrightness: Brightness.dark,
      accentColor: MyColors.yellowColor,
      primaryIconTheme: IconThemeData(color: MyColors.whiteColor,size: 16),
      accentIconTheme: IconThemeData(color: MyColors.whiteColor,size: 16),
      textTheme: TextTheme(body1: TextStyle(color: MyColors.whiteColor)),
      appBarTheme: AppBarTheme(textTheme: TextTheme(title: TextStyle(color: MyColors.whiteColor))),
    );  
  }

}