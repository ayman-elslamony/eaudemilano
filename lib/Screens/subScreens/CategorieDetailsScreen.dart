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


class CategorieDetailsScreen extends StatefulWidget {
 final String title;
 CategorieDetailsScreen({this.title});

  @override
  _CategorieDetailsScreenState createState() => _CategorieDetailsScreenState();
}

class _CategorieDetailsScreenState extends State<CategorieDetailsScreen> {
  String _locale;

  @override
  void initState() {
    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        },
          iconSize: 19,
          icon:
          const Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          widget.title,
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
          padding: const EdgeInsets.only(left: 15.0,right: 15.0,),
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
          child: homeProvider.categorieDetailsStage == GetCategorieDetailsStage.ERROR?
              Center(
                child: Row(
                  children: [
                    Expanded(child: Text(AppLocalizations.of(context).locale.languageCode == "en" ?'Sorry there are no any products in ${widget.title}':'${widget.title}نأسف لايوجد منتجات فى  ',style: Theme.of(context).textTheme.headline3,textAlign: TextAlign.center,)),
                  ],
                ),
              )
              :MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeLeft: true,
            removeRight: true,
            removeBottom: false,
            child:ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: homeProvider.categorieDetailsStage == GetCategorieDetailsStage.LOADING
                    ?loadingCard(media: media):defaultCard(
                  productId: homeProvider.getCategorieDetails.products[index].id,
                    titleContent: '',
                    title: homeProvider.getCategorieDetails.products[index].price,
                    imgUrl: homeProvider.getCategorieDetails.products[index].image,
                    subTitle: homeProvider.getCategorieDetails.products[index].title,
                    context: context,
                    currentIndex: index,
                    media: media),
              ),
              itemCount: homeProvider.categorieDetailsStage == GetCategorieDetailsStage.LOADING
                  ?8:homeProvider.getCategorieDetails.products.length,
            ),
          ),
        ),
      ),
    );
  }
}
