import 'package:eaudemilano/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:eaudemilano/Localization/app_localization_delegate.dart';

import 'package:flutter/services.dart';

import 'Provider/CartProvider.dart';
import 'Provider/FavouriteProvider.dart';
import 'Provider/HomeProvider.dart';
import 'Provider/SearchProvider.dart';
import 'Provider/UserProvider.dart';
import 'Provider/ViewProductProvider.dart';
import 'Provider/changeIndexPage.dart';
import 'Provider/LocaleProvider.dart';
import 'Screens/intoScreen/SplashScreen.dart';
import 'Screens/mainScreen/NavigationHome.dart';

const domain = "https://home-sleem.com/milano";
const apiPassword = "123456";
const photosPreUrl = "https://wekala.greencodet.com/storage/";

//Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//  await Firebase.initializeApp();
//
//  print("Handling a background message: ${message.messageId}");
//}
//AndroidNotificationChannel channel = AndroidNotificationChannel(
//  'high_importance_channel', // id
//  'High Importance Notifications', // title
//  importance: Importance.high,
//);
//FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized(

  );
  await Firebase.initializeApp(
  );

  //  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//  _firebaseMessaging.requestPermission(
//      sound: true, badge: true, alert: true
//  );
//
//  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//  await flutterLocalNotificationsPlugin
//      .resolvePlatformSpecificImplementation<
//      AndroidFlutterLocalNotificationsPlugin>()
//      ?.createNotificationChannel(channel);

  SystemChrome.setEnabledSystemUIOverlays([
    SystemUiOverlay.top,
    SystemUiOverlay.bottom,
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
//  Future onDidReceiveLocalNotification(
//      int id, String title, String body, String payload) async {
//    // display a dialog with the notification details, tap ok to go to another page
//    showDialog(
//      context: context,
//      builder: (BuildContext context) => CupertinoAlertDialog(
//        title: Text(title),
//        content: Text(body),
//        actions: [
//          CupertinoDialogAction(
//            isDefaultAction: true,
//            child: Text('Ok'),
//            onPressed: () async {
//              Navigator.of(context, rootNavigator: true).pop();
//              // await Navigator.push(
//              //   context,
//              //   MaterialPageRoute(
//              //     builder: (context) => SecondScreen(payload),
//              //   ),
//              // );
//            },
//          )
//        ],
//      ),
//    );
//  }

//  askForNotificationsPermission()async{
//    final status = await Permission.notification.request();
//    if (status == PermissionStatus.granted) {
//      print('Permission granted');
//    } else if (status == PermissionStatus.denied) {
//      print('Denied. Show a dialog with a reason and again ask for the permission.');
//    } else if (status == PermissionStatus.permanentlyDenied) {
//      print('permanentlyDenied. Show a dialog with a reason and again ask for the permission.');
//
//      // showAlertDialog(context,content: 'يجب الموافقة علي تصريح موقعك الحالي للإستكمال',onOk: ()=>Navigator.pop(context));
//    }
//  }

//  @override
//  void initState() {
//    super.initState();
//    askForNotificationsPermission();
//    var initialzationSettingsAndroid =
//    AndroidInitializationSettings('@mipmap/launcher_icon');
//    final IOSInitializationSettings initializationSettingsIOS =
//    IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//    var initializationSettings =
//    InitializationSettings(android: initialzationSettingsAndroid,iOS:initializationSettingsIOS );
//
//    flutterLocalNotificationsPlugin.initialize(initializationSettings);
//    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//      RemoteNotification notification = message.notification;
//      AndroidNotification android = message.notification?.android;
//      if (notification != null && android != null) {
//        flutterLocalNotificationsPlugin.show(
//            notification.hashCode,
//            notification.title,
//            notification.body,
//            NotificationDetails(
//              android: AndroidNotificationDetails(
//                channel.id,
//                channel.name,
//                // TODO add a proper drawable resource to android, for now using
//                //      one that already exists in example app.
//                icon: '@mipmap/launcher_icon',
//              ),
//            ));
//      }
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
        ChangeNotifierProvider.value(
          value: ChangeIndex(),
        ),
        ChangeNotifierProvider<UserDataProvider>(
            create: (_) => UserDataProvider()),
        ChangeNotifierProvider<HomeProvider>(
            create: (_) => HomeProvider()),
        ChangeNotifierProvider<CartProvider>(
            create: (_) => CartProvider()),
        ChangeNotifierProvider<FavouriteProvider>(
            create: (_) => FavouriteProvider()),
        ChangeNotifierProvider<SearchProvider>(
            create: (_) => SearchProvider()),
        ChangeNotifierProvider<ViewProductProvider>(
            create: (_) => ViewProductProvider()),
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
            Locale('ar'),
            Locale('en'),
          ],
          locale: localeProvider.locale,
          debugShowCheckedModeBanner: false,
          theme: themeApp,
          title: 'Eau De Milano',
          home: SplashScreen(),
//            routes: {
//              Splash.routName: (context) => Splash(),
//              NavigationHome.routName: (context) => NavigationHome(),
//              Login.routName: (context) => Login(),
//              ForgetPassword.routName: (context) => ForgetPassword(),
//              Register.routName: (context) => Register(),
//              Home.routName: (context) => Home(),
//              CartScreen.routName: (context) => CartScreen(),
//              CarsModels.routName: (context) => CarsModels(),
//              FixingPlaces.routName: (context) => FixingPlaces(),
//              ProductDetails.routName: (context) => ProductDetails(),
//              MyOrders.routName: (context) => MyOrders(),
//              PaymentScreens.routName: (context) => PaymentScreens(),
//              TermsParent.routName: (context) => TermsParent(),
//              SearchScreen.routName:(context)=>SearchScreen(),
//              ContactUs.routName: (context) => ContactUs(),
//              UserProfile.routName: (context) => UserProfile(),
//              OrderTracking.routName: (context) => OrderTracking(),
//              PreviousOrders.routName: (context) => PreviousOrders(),
//              FavouritesScreen.routName: (context) => FavouritesScreen(),
//              NotificationsScreen.routName: (context) => NotificationsScreen(),
//              AlarmsScreen.routName: (context) => AlarmsScreen(),
//              MoreScreen.routName: (context) => MoreScreen(),
//              CatalogueScreen.routName: (context) => CatalogueScreen(),
//              Stores.routName: (context) => Stores(),
//              StoreDetails.routName: (context) => StoreDetails(),
//              AlarmDetails.routName:(context)=>AlarmDetails(),
//              AddAlarm.routName:(context)=>AddAlarm(),
//              ChangePassword.routName:(context)=>ChangePassword(),
//              OrderDetails.routName:(context)=>OrderDetails(),
//              Verification.routName:(context)=>Verification(),
//              CarDetails.routName:(context)=>CarDetails(),
//            }
        );
      }),
    );
  }
}
