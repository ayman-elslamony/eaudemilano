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
import 'Screens/subScreens/ShowItemScreen.dart';
import 'provider/changeIndexPage.dart';
import 'provider/locale_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([
    SystemUiOverlay.top,
  SystemUiOverlay.bottom,
  ]);
////  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
////    statusBarColor: Color(0xFF142c43), // Color for Android
////  ));
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
          value: ChangeIndex()
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
            theme: themeApp,
            title: 'EAU DE MILANO',
            home: NavigationHome(),
            //ShowItemScreen(),
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
