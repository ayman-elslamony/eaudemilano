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


class SeeAllBestSelling extends StatefulWidget {
  @override
  _SeeAllBestSellingState createState() => _SeeAllBestSellingState();
}

class _SeeAllBestSellingState extends State<SeeAllBestSelling> {
  String _locale;

  @override
  void initState() {
    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
    Provider.of<HomeProvider>(context, listen: false)
        .getAllBestSellingFunction(context: context, locale: _locale);
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
          '${AppLocalizations.of(context).trans('best_selling')}',
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
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeLeft: true,
            removeRight: true,
            removeBottom: false,
            child:ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: homeProvider.allBestSellingStage == GetAllBestSellingStage.LOADING
                    ?loadingCard(media: media):defaultCard(
                  productId: homeProvider.getAllBestSelling.bestSellingContent[index].id,
                    titleContent: '',
                    title: homeProvider.getAllBestSelling.bestSellingContent[index].price,
                    imgUrl: homeProvider.getAllBestSelling.bestSellingContent[index].image,
                    subTitle: homeProvider.getAllBestSelling.bestSellingContent[index].title,
                    context: context,
                    currentIndex: index,
                    media: media),
              ),
              itemCount: homeProvider.allBestSellingStage == GetAllBestSellingStage.LOADING
                  ?8:homeProvider.getAllBestSelling.bestSellingContent.length,
            ),
          ),
        ),
      ),
    );
  }
}
