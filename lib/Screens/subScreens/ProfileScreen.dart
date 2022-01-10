import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';

import 'package:eaudemilano/Screens/mainScreen/NavigationHome.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  Widget showScreenComponent({String titleKey,String imgUrl}){
    return  SizedBox(
      height: 45,
      child: ListTile(
        contentPadding: const EdgeInsets.all( 0.0),
        isThreeLine: false,
        dense: true,
        horizontalTitleGap: -5,
        leading: ImageIcon(
          AssetImage(imgUrl),
          color: Colors.white,
        ),
        trailing: const ImageIcon(
          AssetImage('images/show.png'),
          color: primeColor,
        ),
        title: Text(
          '${AppLocalizations.of(context).trans(titleKey)}',
          style: Theme.of(context).textTheme.headline4.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {openDrawer();},
          icon:const  ImageIcon(
            AssetImage('images/drawer.png'),
          ),
        ),
        title: Text(
          '${AppLocalizations.of(context).trans('profile')}',
          style: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 18,
              child: ClipOval(
                child: Image.asset(
                  "images/profile.png",
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: media.width,
        height: media.height * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        decoration:const  BoxDecoration(
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
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      child: Image.asset(
                        'images/profile.png',
                        fit: BoxFit.fill,
                        height: media.height * 0.13,
                        width: media.width * 0.25,
                      ),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ahmed',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        Text('ahmed@gmail.com',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
                myDivider(),
                showScreenComponent(titleKey: 'orders',imgUrl: 'images/orders.png')
                ,showScreenComponent(titleKey: 'addresses',imgUrl: 'images/addresses.png')
                ,showScreenComponent(titleKey: 'account_details',imgUrl: 'images/accountDetails.png')
             ,myDivider(),
                defaultTextButton(function: (){}, context: context, textKey: 'logout',textColor: const Color(0xFF7D3030))
              ],
            ),
          ),
        ),
      ),
//        bottomNavigationBar: bottomNavigationBar(
//            context: context,
//            onTap: (index) {
//              setState(() {
//                changeIndex.index = index;
//              });
//              Navigator.pushAndRemoveUntil(
//                  context,
//                  PageRouteBuilder(
//                    pageBuilder: (context, animation1, animation2) =>
//                        NavigationHome(),
//                    transitionDuration: Duration(seconds: 0),
//                  ),
//                  (Route<dynamic> route) => false);
//            },
//            currentIndex: changeIndex.index),
    );
  }
}
