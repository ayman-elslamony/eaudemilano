//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Screens/subScreens/CheckoutScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';
import 'package:eaudemilano/provider/changeIndexPage.dart';
import 'CartScreen.dart';
import 'FavouriteScreen.dart';
import 'HomeScreen.dart';
import 'SearchScreen.dart';

final GlobalKey<InnerDrawerState> innerDrawerKey =
    GlobalKey<InnerDrawerState>();

void openDrawer() {
  innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
}

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
                  key: innerDrawerKey,
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
                        decoration: BoxDecoration(
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
                      decoration: BoxDecoration(
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
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.white, width: 2))),
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
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.white, width: 2))),
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
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.white, width: 2))),
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
                                    border: Border(
                                        top: BorderSide(
                                            color: Colors.white, width: 2))),
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
                    floatingActionButton: changeIndex.index == 1
                        ? FloatingActionButton(
                            onPressed: () {
                              navigateTo(context, CheckoutScreen());
                            },
                            child: ImageIcon(
                              AssetImage('images/arrow.png'),
                              size: 17,
                              color: Colors.white,
                            ),
                          )
                        : null,
                  )),
            )));
  }
}
