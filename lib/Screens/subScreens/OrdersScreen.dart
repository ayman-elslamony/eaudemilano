import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Provider/HomeProvider.dart';
import 'package:eaudemilano/Provider/SearchProvider.dart';
import 'package:eaudemilano/Provider/changeIndexPage.dart';
import 'package:eaudemilano/Provider/LocaleProvider.dart';

import 'package:eaudemilano/Screens/subScreens/ProfileScreen.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CategorieDetailsScreen.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String _locale;

  @override
  void initState() {
    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<HomeProvider>(context, listen: false)
        .getAllOrdersFunction(context: context, locale: _locale);
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
          '${AppLocalizations.of(context).trans('orders')}',
          style: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) => Container(
          width: media.width,
          height: media.height,
          padding: const EdgeInsets.only(
            left: 15.0,
            right: 15.0,
          ),
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
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeLeft: true,
            removeRight: true,
            removeBottom: false,
            child: ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: homeProvider.allCategoriesStage ==
                    GetAllCategoriesStage.LOADING
                    ? loadingCard(media: media)
                    : Container(
                  margin:const EdgeInsets.only(top: 8.0),
                  decoration: BoxDecoration(
                      gradient:const  LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color(0xFF060606),
                          Color(0xFF747474),
                        ],
                      ),
                      borderRadius:const  BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: secondaryColor)),
                  child: ListTile(
                    contentPadding:const  EdgeInsets.symmetric(horizontal: 12.0),
                    onTap: () {
                      Provider.of<HomeProvider>(context, listen: false)
                          .getCategorieDetailsFunction(context: context, locale: _locale,id:homeProvider.getAllCategories[index].id );
                      navigateTo(context, CategorieDetailsScreen(title: homeProvider.getAllCategories[index].title,));
                    },
                    hoverColor: primeColor,
                    title: Text(
                      homeProvider.getAllCategories[index].title,
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: primeColor),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 18.0,
                      color: primeColor,
                    ),
                  ),
                ),
              ),
              itemCount: homeProvider.allCategoriesStage ==
                  GetAllCategoriesStage.LOADING
                  ? 8
                  : homeProvider.getAllCategories.length,
            ),
          ),
        ),
      ),
    );
  }
}
