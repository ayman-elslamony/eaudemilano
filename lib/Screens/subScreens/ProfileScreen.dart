import 'package:eaudemilano/Helper/Helper.dart';
import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Provider/UserProvider.dart';
import 'package:eaudemilano/Provider/changeIndexPage.dart';
import 'package:eaudemilano/Provider/LocaleProvider.dart';

import 'package:eaudemilano/Screens/mainScreen/NavigationHome.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'OrdersScreen.dart';
import 'UpdateProfile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _locale;

  @override
  void initState() {
    super.initState();
    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
  }

  Widget showScreenComponent({String titleKey, String imgUrl, Function onTap}) {
    return SizedBox(
      height: 45,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(0.0),
        isThreeLine: false,
        dense: true,
        horizontalTitleGap: -5,
        leading: ImageIcon(
          AssetImage(imgUrl),
          color: Colors.white,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
          color: primeColor,
        ),
        title: Text(
          '${AppLocalizations.of(context).trans(titleKey)}',
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          iconSize: 19,
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          '${AppLocalizations.of(context).trans('profile')}',
          style: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: media.width,
        height: media.height,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF060606),
              Color(0xFF747474),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      child: Image.asset(
                        'images/user.png',
                        color: secondaryColor,
                        fit: BoxFit.fill,
                        height: media.height * 0.12,
                        width: media.width * 0.25,
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Consumer<UserDataProvider>(
                      builder: (context, userData, child) =>userData.updateUserDataStage==GetUpdateUserDataStage.LOADING?loaderApp():Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Helper.userName,
                            style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          Text(Helper.userEmail,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(color: Colors.white70)),
                        ],
                      ),
                    ),
                  ],
                ),
                myDivider(),
                showScreenComponent(
                    titleKey: 'orders',
                    imgUrl: 'images/orders.png',
                    onTap: () {
                     navigateTo(context, OrdersScreen());
                    })
                ,showScreenComponent(titleKey: 'language_switch',imgUrl: 'images/language.png',
                onTap: ()async{
                  final prefs =
                      await SharedPreferences
                      .getInstance();
                  String currentLanguage='en';
                  if(_locale=='en'){
                    currentLanguage='ar';
                  }else{
                    currentLanguage='en';
                  }
                  Provider.of<LocaleProvider>(
                      context,
                      listen: false)
                      .setLocale(Locale(currentLanguage
                      ));
                  prefs.setString('language',
                      currentLanguage);
                })
                ,
                showScreenComponent(
                    titleKey: 'edit_profile',
                    imgUrl: 'images/accountDetails.png',
                    onTap: () {
                      navigateTo(context, UpdateProfile());
                    }),
                myDivider(),
                defaultTextButton(
                    function: () {
                      Provider.of<UserDataProvider>(context, listen: false)
                          .logout(context: context, locale: _locale).then((_){
                            Provider.of<ChangeIndex>(context,listen: false).changeIndexFunction(0);

                      });
                    },
                    context: context,
                    textKey: 'logout',
                    textColor: primeColor)
              ],
            ),
          ),
        ),
      ),
//        bottomNavigationBar:Consumer<ChangeIndex>(
//          builder: (context, changeIndex, child) => bottomNavigationBar(
//              context: context,
//              onTap: (index) {
//                setState(() {
//                  changeIndex.index = index;
//                });
//                Navigator.pushAndRemoveUntil(
//                    context,
//                    PageRouteBuilder(
//                      pageBuilder: (context, animation1, animation2) =>
//                          NavigationHome(),
//                      transitionDuration:const Duration(seconds: 0),
//                    ),
//                    (Route<dynamic> route) => false);
//              },
//              currentIndex: changeIndex.index),
//        ),
    );
  }
}
