// ignore_for_file: file_names, unnecessary_this, unnecessary_string_interpolations, use_rethrow_when_possible, non_constant_identifier_names, unnecessary_brace_in_string_interps, prefer_final_fields, prefer_const_constructors, use_key_in_widget_constructors

//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:eaudemilano/Helper/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:eaudemilano/provider/changeIndexPage.dart';
import 'HomeScreen.dart';

class NavigationHome extends StatefulWidget {
  static const String routName = '/NavigationHome_Screen';

  @override
  _NavigationHomeState createState() => _NavigationHomeState();
}

class _NavigationHomeState extends State<NavigationHome> {
  List<Widget> mainWidgets = [
    HomeScreen(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
  ];

  var _locale;
  Map passedData = {};
  var _isInit = true;
  var products;

//  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//  @override
//  void didChangeDependencies() {
//
//    super.didChangeDependencies();
//    if (_isInit) {
//      passedData = ModalRoute.of(context).settings.arguments;
//
//      mainWidgets = [
//        Home(),
//        Stores(
//          status: passedData != null ? passedData['status'] : '',
//        ),
//        CartScreen(),
//        AlarmsScreen(),
//        MoreScreen(),
//      ];
//      // _firebaseMessaging.getToken().then((fcmToken) => print('FCM Token : $fcmToken'));
//      _isInit = false;
//    }
//  }

  var homeData;

//  @override
//  void initState() {
//    super.initState();

//    _locale =
//        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
//
//    Provider.of<HomeProvider>(context, listen: false)
//        .getHomeData(context: context, locale: _locale)
//        .then((value) {
//      homeData = Provider.of<HomeProvider>(context, listen: false).homeData;
//      Provider.of<CartProvider>(context, listen: false)
//          .getCartData(context, _locale)
//          .then((value) {
//        products = Provider.of<CartProvider>(context, listen: false)
//            .cart
//            .products
//            .length;
//      });
//    });
//  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    // var stage = Provider.of<HomeProvider>(context).homeStage;

//    final cartProducts = Provider.of<CartProvider>(context).cart;
    return Consumer<ChangeIndex>(
        builder: (context, changeIndex, child) => WillPopScope(
              onWillPop: () async {
                SystemNavigator.pop();
                return false;
              },
              child: Scaffold(
                backgroundColor: Colors.white,
                body: mainWidgets[changeIndex.index],
                extendBody: true,
                bottomNavigationBar: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
                    child: BottomNavigationBar(
                      elevation: 0.0,
                      items: [
                        BottomNavigationBarItem(
                          icon: Container(
                            height: 53,
                            child: ImageIcon(
                              AssetImage('images/homeGrey.png'),
                              size: 25,
                            ),
                          ),
                          label: '',
                          activeIcon: Container(
                            height: 53,
                            decoration: BoxDecoration(
                              border: Border(top: BorderSide(color: Colors.white,width: 2))
                            ),
                            child: ImageIcon(
                              AssetImage('images/home.png'),
                              size: 25,
                            ),
                          ),
                        ),
                        BottomNavigationBarItem(
                          label: '',
                          icon: Container(
                            height: 53,
                            child: ImageIcon(
                              AssetImage('images/shoppingCartGrey.png'),
                              size: 25,
                            ),
                          ),
                          activeIcon: Container(
                            height: 53,
                            decoration: BoxDecoration(
                                border: Border(top: BorderSide(color: Colors.white,width: 2))
                            ),
                            child: ImageIcon(
                              AssetImage('images/shoppingCart.png'),
                              size: 25,
                            ),
                          ),
                        ),
                        BottomNavigationBarItem(
                          label: '',
                          icon: Container(
                            height: 53,
                            child: ImageIcon(
                              AssetImage('images/searchGrey.png'),
                              size: 25,
                            ),
                          ),
                          activeIcon: Container(
                            height: 53,
                            decoration: BoxDecoration(
                                border: Border(top: BorderSide(color: Colors.white,width: 2))
                            ),
                            child: ImageIcon(
                              AssetImage('images/search.png'),
                              size: 25,
                            ),
                          ),
                        ),
                        BottomNavigationBarItem(
                          label: '',
                          icon: Container(
                            height: 53,
                            child: ImageIcon(
                              AssetImage('images/favouriteGrey.png'),
                              size: 25,
                            ),
                          ),
                          activeIcon: Container(
                            height: 53,
                            decoration: BoxDecoration(
                                border: Border(top: BorderSide(color: Colors.white,width: 2))
                            ),
                            child: ImageIcon(
                              AssetImage('images/favourite.png'),
                              size: 25,
                            ),
                          ),
                        ),
                      ],
                      enableFeedback: true,
                      unselectedItemColor: Colors.grey,
                      selectedItemColor: Colors.white,
                      showUnselectedLabels: true,
                      currentIndex: changeIndex.index,
                      onTap: changeIndex.changeIndexFunction,
                      type: BottomNavigationBarType.fixed,
                      selectedIconTheme: IconThemeData(size: 25),
                      unselectedIconTheme:
                          IconThemeData(color: Colors.grey, size: 25),
// selectedItemColor: Theme.of(context).primaryColor,
                      selectedLabelStyle: TextStyle(
                        fontSize: 0,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 0,
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
