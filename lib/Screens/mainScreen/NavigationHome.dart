//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Provider/CartProvider.dart';
import 'package:eaudemilano/Provider/FavouriteProvider.dart';
import 'package:eaudemilano/Provider/HomeProvider.dart';
import 'package:eaudemilano/Provider/changeIndexPage.dart';
import 'package:eaudemilano/Provider/LocaleProvider.dart';
import 'package:eaudemilano/Screens/subScreens/CheckoutScreen.dart';
import 'package:eaudemilano/styles/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';
import 'CartScreen.dart';
import 'FavouriteScreen.dart';
import 'HomeScreen.dart';
import 'SearchScreen.dart';



class NavigationHome extends StatefulWidget {
  static const String routName = '/NavigationHome_Screen';

  @override
  _NavigationHomeState createState() => _NavigationHomeState();
}

class _NavigationHomeState extends State<NavigationHome> {
  List<Widget> mainWidgets = [
    HomeScreen(),
    CartScreen(),
    SearchScreen(),
    FavouriteScreen(),
  ];

  String _locale;
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


  @override
  void initState() {
    super.initState();

    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;



  }
  Widget drawerText(
      {BuildContext context,
      String textKey,
      bool isTextNotKey = false,
      Color textColor,Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Text(
          isTextNotKey == false
              ? AppLocalizations.of(context).locale.languageCode == "en"
                  ? '${AppLocalizations.of(context).trans(textKey).toUpperCase()}'
                  : '${AppLocalizations.of(context).trans(textKey)}'
              : textKey,
          style: Theme.of(context).textTheme.headline5.copyWith(
              color: textColor != null ? textColor : Color(0xFF747474),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

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
            child: SafeArea(
              child: InnerDrawer(
                  key: changeIndex.innerDrawerKey,
                  onTapClose: true,
                  // default false
                  swipe: false,
                  tapScaffoldEnabled: false,
                  swipeChild: true,
                  offset: IDOffset.horizontal(0.20),
//                      proportionalChildArea : false, // default true
                  leftAnimationType: InnerDrawerAnimation.static,
                  // default static
                  rightAnimationType: InnerDrawerAnimation.quadratic,
                  leftChild: Scaffold(
                    body: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: media.width * 0.6,
                          minWidth: media.width * 0.6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 8.0),
                        decoration:const  BoxDecoration(
                          gradient: LinearGradient(
                            transform: GradientRotation(20),
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color(0xFFF1F1F1),
                              Color(0xFF8F8F8F),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: media.height * 0.05,
                            ),
                            Container(
                                width: media.width * 0.35,
                                height: media.height * 0.2,
                                child:
                                    Image.asset('images/logoEauDeMilano.png')),
                            SizedBox(
                              height: media.height * 0.05,
                            ),
                            drawerText(
                                context: context,
                                textKey: 'home',
                                textColor: changeIndex.index==0?Colors.black87:null),
                            drawerText(
                                context: context,
                                textKey: 'exclusive_for_woman'),
                            drawerText(
                                context: context, textKey: 'exclusive_for_man'),
                            drawerText(context: context, textKey: 'partners'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // required if rightChild is not set
                  scaffold: Scaffold(
                    backgroundColor: Colors.white,
                    body: mainWidgets[changeIndex.index],
                    extendBody: true,
                    bottomNavigationBar: Container(
                      decoration:const  BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                        ),
//                    boxShadow: [
//                      BoxShadow(
//                        color: Color(0xFF060606).withOpacity(0.5),
//                        spreadRadius: 5,
//                        blurRadius: 7,
//                        offset:
//                            const Offset(0, 3), // changes position of shadow
//                      ),
//                    ],
                      ),
                      child: ClipRRect(
                        borderRadius:const BorderRadius.only(
                          topRight: Radius.circular(12),
                          topLeft: Radius.circular(12),
                        ),
                        child: BottomNavigationBar(
                          elevation: 0.0,
                          items: [
                            BottomNavigationBarItem(
                              icon: const SizedBox(
                                height: 53,
                                child: ImageIcon(
                                  AssetImage('images/homeGrey.png'),
                                  size: 25,
                                ),
                              ),
                              label: '',
                              activeIcon: Container(
                                height: 53,
                                decoration:const  BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.white, width: 2))),
                                child:const  ImageIcon(
                                  AssetImage('images/home.png'),
                                  size: 25,
                                ),
                              ),
                            ),
                            BottomNavigationBarItem(
                              label: '',
                              icon: const SizedBox(
                                height: 53,
                                child: ImageIcon(
                                  AssetImage('images/shoppingCartGrey.png'),
                                  size: 25,
                                ),
                              ),
                              activeIcon: Container(
                                height: 53,
                                decoration:const  BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.white, width: 2))),
                                child:const  ImageIcon(
                                  AssetImage('images/shoppingCart.png'),
                                  size: 25,
                                ),
                              ),
                            ),
                            BottomNavigationBarItem(
                              label: '',
                              icon: const SizedBox(
                                height: 53,
                                child: ImageIcon(
                                  AssetImage('images/searchGrey.png'),
                                  size: 25,
                                ),
                              ),
                              activeIcon: Container(
                                height: 53,
                                decoration: const BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.white, width: 2))),
                                child: const ImageIcon(
                                  AssetImage('images/search.png'),
                                  size: 25,
                                ),
                              ),
                            ),
                            BottomNavigationBarItem(
                              label: '',
                              icon: const SizedBox(
                                height: 53,
                                child:  ImageIcon(
                                  AssetImage('images/favouriteGrey.png'),
                                  size: 25,
                                ),
                              ),
                              activeIcon: Container(
                                height: 53,
                                decoration:const  BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.white, width: 2))),
                                child: const ImageIcon(
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
                          selectedIconTheme:const  IconThemeData(size: 25),
                          unselectedIconTheme:
                          const  IconThemeData(color: Colors.grey, size: 25),
// selectedItemColor: Theme.of(context).primaryColor,
                          selectedLabelStyle:const  TextStyle(
                            fontSize: 0,
                          ),
                          unselectedLabelStyle:const  TextStyle(
                            fontSize: 0,
                          ),
                        ),
                      ),
                    ),
                    floatingActionButton: changeIndex.index == 1
                        ? Consumer<CartProvider>(
                      builder: (context, cartProvider, child) =>  FloatingActionButton(
                              onPressed: cartProvider.getAllProductsInCart.specificProduct.length==0?null:() {
                                navigateTo(context, CheckoutScreen());
                              },backgroundColor: cartProvider.getAllProductsInCart.specificProduct.isEmpty?secondaryColor:primeColor,
                              child:const  ImageIcon(
                                AssetImage('images/arrow.png'),
                                size: 17,
                                color: Colors.white,
                              ),
                            ),
                        )
                        : null,
                  )),
            )));
  }
}
