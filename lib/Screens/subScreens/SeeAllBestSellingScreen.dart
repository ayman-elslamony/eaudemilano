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
import 'package:pull_to_refresh/pull_to_refresh.dart';


class SeeAllBestSellingScreen extends StatefulWidget {
  @override
  _SeeAllBestSellingScreenState createState() => _SeeAllBestSellingScreenState();
}

class _SeeAllBestSellingScreenState extends State<SeeAllBestSellingScreen> {
  String _locale;
  RefreshController _refreshControllerAllBestSellingScreen ;
  @override
  void initState() {
    _refreshControllerAllBestSellingScreen =
        RefreshController(initialRefresh: false);

    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
    Provider.of<HomeProvider>(context, listen: false)
        .getAllBestSellingFunction(context: context, locale: _locale);
    super.initState();
  }
  void _onRefresh() async {
    await Provider.of<HomeProvider>(context, listen: false)
        .getAllBestSellingFunction(context: context, locale: _locale);
    _refreshControllerAllBestSellingScreen.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {

    final media = MediaQuery.of(context).size;
    return SmartRefresher(
      enablePullDown: true,
      controller: _refreshControllerAllBestSellingScreen,
      onRefresh: _onRefresh,
      child: Scaffold(
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    removeLeft: true,
                    removeRight: true,
                    removeBottom: true,
                    child:ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(top: 12,),
                        child: homeProvider.allBestSellingStage == GetAllBestSellingStage.LOADING
                            ?loadingCard(media: media):defaultCard(
                          productId: homeProvider.getAllBestSelling.bestSellingContent[index].id,
                            titleContent: '',
                            priceBeforeDiscount: homeProvider.getAllBestSelling.bestSellingContent[index].priceBeforeDiscount,
                            price: homeProvider.getAllBestSelling.bestSellingContent[index].price,
                            imgUrl: homeProvider.getAllBestSelling.bestSellingContent[index].image,
                            subTitle: homeProvider.getAllBestSelling.bestSellingContent[index].title,
                            context: context,
                            currentIndex: index,
                            media: media),
                      ),
                      itemCount: homeProvider.allBestSellingStage == GetAllBestSellingStage.LOADING
                          ?5:homeProvider.getAllBestSelling.bestSellingContent.length,
                    ),
                  ),
                  const SizedBox(height: 12.0,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
