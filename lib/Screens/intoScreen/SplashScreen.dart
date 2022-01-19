// ignore_for_file: file_names, unnecessary_this, unnecessary_string_interpolations, use_rethrow_when_possible, non_constant_identifier_names, unnecessary_brace_in_string_interps, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:eaudemilano/Helper/Helper.dart';
import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Provider/LocaleProvider.dart';
import 'package:eaudemilano/Provider/UserProvider.dart';
import 'package:eaudemilano/Screens/mainScreen/NavigationHome.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  static const String routName = '/Splash_Screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  AnimationController _controller;
  var _locale;

  _navigateToNextScreen() async {

    Provider.of<UserDataProvider>(context,listen: false).getUserData().then((_){
          Timer(Duration(milliseconds: 1000), () async {
      navigateAndFinish(context, LoginScreen());
      if (Helper.token != null){
        Navigator.push(context, PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => NavigationHome(),
          transitionDuration: Duration(milliseconds: 1000),
        ));
      }
      else{
        Navigator.push(context, PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => LoginScreen(),//LoginScreen(),
          transitionDuration: Duration(milliseconds: 1000),
        ));
      }
    });
    });

  }

  @override
  void initState() {
    super.initState();
    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    getCurrentLanguage().then((_) {
      Provider.of<UserDataProvider>(context, listen: false)
          .getUserData()
          .then((_) {
        _navigateToNextScreen();
      });
    });
  }
  String currentLanguage;
  String language;
  Future getCurrentLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String language = prefs.getString('language');
    if (language != null) {
      Provider.of<LocaleProvider>(context, listen: false)
          .setLocale(Locale(language))
          .then((value) {
        _locale = Provider.of<LocaleProvider>(context, listen: false).locale;
      });
    } else {
      _locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    }
  }




  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/backgroundImage.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              color: Colors.white60,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: media.width * 0.4,
                    height: media.height * 0.2,
                    child: Image.asset('images/logoEauDeMilano.png')),
                SizedBox(
                  height: media.height * 0.05,
                ),
                loaderApp()
              ],
            )),
      ),
    );
  }
}
