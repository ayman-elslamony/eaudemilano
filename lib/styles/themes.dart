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
  appBarTheme:const  AppBarTheme(
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
    iconTheme: IconThemeData(color: primeColor, size: 16.0),
  ),
  floatingActionButtonTheme:const  FloatingActionButtonThemeData(
    backgroundColor: primeColor,
  ),
  bottomNavigationBarTheme:const  BottomNavigationBarThemeData(
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
  tabBarTheme:const  TabBarTheme(
    labelStyle:  TextStyle(
      fontFamily: 'Lato', color: Colors.white,
      fontSize: 15.0,
//      height: 16.8,
      fontWeight: FontWeight.w400,
    ),
    unselectedLabelStyle:  TextStyle(
      fontFamily: 'CairoBold', color: Colors.white,
      fontSize: 15.0,
//      height: 16.8,
      fontWeight: FontWeight.w400,
    ),
  ),
//              dialogTheme: DialogTheme(
//                  contentTextStyle: TextStyle(
//                    fontFamily: 'Lato',
//                    fontSize: 19,
//                    color: Color(0xFF060606),
//                    fontWeight: FontWeight.w700,
//                  ),
//                  titleTextStyle: TextStyle(
//                    fontFamily: 'Lato',
//                    fontSize: 19,
//                    color: Color(0xFF060606),
//                    fontWeight: FontWeight.w700,
//                  )),
  textTheme: ThemeData.dark().textTheme.copyWith(
      bodyText1: TextStyle(
        fontFamily: 'Lato',
        fontSize: 15,
        color: Colors.grey[800],
      ),
      subtitle1:const  TextStyle(
        fontFamily: 'Lato',
        fontSize: 80,
        fontWeight: FontWeight.w700,
        color: Color(0xFFFAFAFA),
      ),
      button:const  TextStyle(
        fontFamily: 'Lato',
        color: textButtonColor,
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
      headline1:const  TextStyle(
        fontFamily: 'Lato',
        fontSize: 19,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      headline2:const  TextStyle(
        fontFamily: 'Lato',
        fontWeight: FontWeight.w700,
        fontSize: 18,
        color: Colors.white,
        // fontWeight: FontWeight.bold,
      ),
      headline3:const  TextStyle(
        fontFamily: 'Lato',
        fontSize: 16,
        color: Colors.white,
      ),
      headline4: TextStyle(
        fontFamily: 'Lato',
        fontSize: 14,
        color: Colors.grey[800],
      ),
      headline5: TextStyle(
        fontFamily: 'Lato',
        fontSize: 13,
        color: Colors.grey[800],
      ),
      headline6:const  TextStyle(
        fontFamily: 'Lato',
        color: textButtonColor,
        fontSize: 12,
      )),
);

