import 'package:eaudemilano/styles/colors.dart';
import 'package:eaudemilano/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'Localization/app_localization_delegate.dart';
import 'Screens/intoScreen/LoginScreen.dart';
import 'Screens/intoScreen/SignUpScreen.dart';
import 'Screens/intoScreen/SplashScreen.dart';
import 'Screens/mainScreen/NavigationHome.dart';
import 'provider/changeIndexPage.dart';
import 'provider/locale_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([
    SystemUiOverlay.top,
    SystemUiOverlay.bottom,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Color(0xFF142c43), // Color for Android
  ));
  runApp(const EauDeMilanoApp());
}

class EauDeMilanoApp extends StatelessWidget {
  const EauDeMilanoApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
        ChangeNotifierProvider.value(
          value: ChangeIndex(),
        ),
//        ChangeNotifierProvider<UserDataProvider>(
//            create: (_) => UserDataProvider()),
//        ChangeNotifierProvider<BrandsProvider>(
//            create: (_) => BrandsProvider()),
      ],
      child: Consumer<LocaleProvider>(builder:
          (BuildContext context, LocaleProvider localeProvider, Widget child) {
        return MaterialApp(
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            locale: localeProvider.locale,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
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
                iconTheme: IconThemeData(color: primeColor, size: 16.0),
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
                    fontSize: 15,
                    color: Colors.grey[800],
                  ),
                  subtitle1: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 80,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFAFAFA),
                  ),
                  button: TextStyle(
                    fontFamily: 'Lato',
                    color: textButtonColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  headline1: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  headline2: TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                  ),
                  headline3: TextStyle(
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
                  headline6: TextStyle(
                    fontFamily: 'Lato',
                    color: textButtonColor,
                    fontSize: 12,
                  )),
            ),
            title: 'EAU DE MILANO',
            home: NavigationHome(),
            //SplashScreen(),
            routes: {
//              Splash.routName: (context) => Splash(),
//              NavigationHome.routName: (context) => NavigationHome(),
//              Login.routName: (context) => Login(),
//              ForgetPassword.routName: (context) => ForgetPassword(),
//              Register.routName: (context) => Register(),
//              Home.routName: (context) => Home(),
            });
      }),
    );
  }
}
