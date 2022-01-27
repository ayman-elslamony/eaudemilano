import 'package:eaudemilano/Helper/Helper.dart';
import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Provider/HomeProvider.dart';
import 'package:eaudemilano/Provider/SearchProvider.dart';
import 'package:eaudemilano/Provider/changeIndexPage.dart';
import 'package:eaudemilano/Provider/LocaleProvider.dart';

import 'package:eaudemilano/Screens/subScreens/ProfileScreen.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SeeAllLatestProductsScreen extends StatefulWidget {
  @override
  _SeeAllLatestProductsScreenState createState() =>
      _SeeAllLatestProductsScreenState();
}

class _SeeAllLatestProductsScreenState extends State<SeeAllLatestProductsScreen> {
  String _locale;
  RefreshController _refreshController ;
  @override
  void initState() {
    print(Helper.token);
    _refreshController =
        RefreshController(initialRefresh: false);

    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
    Provider.of<HomeProvider>(context, listen: false)
        .getAllLatestProductsFunction(context: context, locale: _locale);
    super.initState();
  }

  int nextPage;



  void _onRefresh() async {
    await Provider.of<HomeProvider>(context, listen: false)
        .getAllLatestProductsFunction(context: context, locale: _locale);
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));

    nextPage = Provider.of<HomeProvider>(context, listen: false).nextPage;
    if (nextPage != null) {
      Provider.of<HomeProvider>(context, listen: false)
          .getAllLatestProductsFunction(
          context: context, locale: _locale, currentPage: nextPage);
      if (mounted) {
        setState(() {});
        _refreshController.loadComplete();
      }
    } else {
      if (mounted) {
        setState(() {});
        _refreshController.loadNoData();
      }
    }
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
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            footer: CustomFooter(
              height: 100,
              builder: (BuildContext context, LoadStatus mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Text(AppLocalizations.of(context).trans("swipe_up"));
                } else if (mode == LoadStatus.loading) {
                  body = Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CupertinoActivityIndicator(),
                  );
                } else if (mode == LoadStatus.failed) {
                  body = Text("Load Failed!Click retry!");
                } else if (mode == LoadStatus.canLoading) {
                  //                                      body = Text("");
                } else {
                  body = Text(AppLocalizations.of(context)
                      .trans("no_more_notifications"));
                }
                return Container(
                  height: 1.0,
                  child: Center(child: body),
                );
              },
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
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                        ),
                        child: homeProvider.allLatestProductsStage ==
                            GetAllLatestProductsStage.LOADING
                            ? loadingCard(media: media)
                            : defaultCard(
                            productId: homeProvider.getAllLatestProducts
                                .bestSellingContent[index].id,
                            titleContent: '',
                            priceBeforeDiscount: homeProvider
                                .getAllLatestProducts
                                .bestSellingContent[index]
                                .priceBeforeDiscount,
                            price: homeProvider.getAllLatestProducts
                                .bestSellingContent[index].price,
                            imgUrl: homeProvider.getAllLatestProducts
                                .bestSellingContent[index].image,
                            productName: homeProvider.getAllLatestProducts
                                .bestSellingContent[index].title,
                            context: context,
                            currentIndex: index,
                            media: media),
                      ),
                      itemCount: homeProvider.allLatestProductsStage ==
                          GetAllLatestProductsStage.LOADING
                          ? 5
                          : homeProvider
                          .getAllLatestProducts.bestSellingContent.length,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
