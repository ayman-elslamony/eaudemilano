import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData themeApp = ThemeData(
  fontFamily: 'Lato',
  primaryColor: primeColor,
  accentColor: secondaryColor,
  canvasColor: Colors.transparent,
  splashColor: Colors.transparent,
  focusColor: Colors.transparent,
  scaffoldBackgroundColor: Colors.black54,
  cardColor: secondaryColor,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: AppBarTheme(
//    titleSpacing: 20.0,
    elevation: 0.0,
    color: Color(0xFF060606),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black54,
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
      fontFamily: 'Lato',
      color: Colors.white,
      fontSize: 17.0,
//      height: 19.2,
      fontWeight: FontWeight.w700,
    ),
    iconTheme: IconThemeData(color: Colors.white, size: 16.0),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primeColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: primeColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Color(0xFF060606),
    selectedLabelStyle: TextStyle(
      fontFamily: 'Lato',
      color: Colors.white,
      fontSize: 15.0,
//      height: 16.8,
      fontWeight: FontWeight.w400,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: 'Lato',
      color: Colors.white,
      fontSize: 15.0,
//      height: 16.8,
      fontWeight: FontWeight.w400,
    ),
  ),
  tabBarTheme: TabBarTheme(
    labelStyle: TextStyle(
      fontFamily: 'Lato', color: Colors.white,
      fontSize: 15.0,
//      height: 16.8,
      fontWeight: FontWeight.w400,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: 'CairoBold', color: Colors.white,
      fontSize: 15.0,
//      height: 16.8,
      fontWeight: FontWeight.w400,
    ),
  ),
  dialogTheme: DialogTheme(
      contentTextStyle: TextStyle(
        fontFamily: 'Lato',
        fontSize: 19,
        color: Color(0xFF060606),
        fontWeight: FontWeight.w700,
      ),
      titleTextStyle: TextStyle(
        fontFamily: 'Lato',
        fontSize: 19,
        color: Color(0xFF060606),
        fontWeight: FontWeight.w700,
      )),
  textTheme: ThemeData.dark().textTheme.copyWith(
    bodyText1: TextStyle(
      fontFamily: 'Lato',
      fontSize: 14,
      color: Colors.grey[800],
    ),
    subtitle1: TextStyle(
      fontFamily: 'Lato',
      fontSize: 18,
      color: Colors.white,
    ),
    button: TextStyle(
      fontFamily: 'Lato',
      color: textButtonColor,
      fontSize: 19,
      fontWeight: FontWeight.w700,
    ),
//    headline1: TextStyle(
//      fontFamily: 'Lato',
//      fontSize: 11,
//      height: 1.5,
//      color: Colors.grey[600],
//      // fontWeight: FontWeight.bold,
//    ),
//    headline2: TextStyle(
//      fontFamily: 'CairoBold',
//      fontSize: 13,
//      color: Colors.grey[800],
//      // fontWeight: FontWeight.bold,
//    ),
//    headline3: TextStyle(
//      fontFamily: 'CairoBold',
//      fontSize: 15,
//      color: Colors.grey[800],
//    ),
//    headline4: TextStyle(
//      fontFamily: 'CairoBold',
//      fontSize: 17,
//      color: Colors.grey[800],
//    ),
//    headline5: TextStyle(
//      fontFamily: 'CairoBold',
//      fontSize: 18,
//      color: Colors.grey[800],
//    ),
//    headline6:
  ),
);

