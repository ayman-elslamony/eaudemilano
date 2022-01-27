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

class SeeAllBestSellingScreen extends StatefulWidget {
  @override
  _SeeAllBestSellingScreenState createState() =>
      _SeeAllBestSellingScreenState();
}

class _SeeAllBestSellingScreenState extends State<SeeAllBestSellingScreen> {
  String _locale;
  RefreshController _refreshControllerAllBestSellingScreen;
  @override
  void initState() {
    print(Helper.token);
    _refreshControllerAllBestSellingScreen =
        RefreshController(initialRefresh: false);

    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
    Provider.of<HomeProvider>(context, listen: false)
        .getAllBestSellingFunction(context: context, locale: _locale);
    super.initState();
  }

  int nextPage;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await Provider.of<HomeProvider>(context, listen: false)
        .getAllBestSellingFunction(context: context, locale: _locale);
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));

    nextPage = Provider.of<HomeProvider>(context, listen: false).nextPage;
    if (nextPage != null) {
      Provider.of<HomeProvider>(context, listen: false)
          .getAllBestSellingFunction(
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
                        child: homeProvider.allBestSellingStage ==
                                GetAllBestSellingStage.LOADING
                            ? loadingCard(media: media)
                            : defaultCard(
                                productId: homeProvider.getAllBestSelling
                                    .bestSellingContent[index].id,
                                titleContent: '',
                                priceBeforeDiscount: homeProvider
                                    .getAllBestSelling
                                    .bestSellingContent[index]
                                    .priceBeforeDiscount,
                                price: homeProvider.getAllBestSelling
                                    .bestSellingContent[index].price,
                                imgUrl: homeProvider.getAllBestSelling
                                    .bestSellingContent[index].image,
                                productName: homeProvider.getAllBestSelling
                                    .bestSellingContent[index].title,
                                context: context,
                                currentIndex: index,
                                media: media),
                      ),
                      itemCount: homeProvider.allBestSellingStage ==
                              GetAllBestSellingStage.LOADING
                          ? 5
                          : homeProvider
                              .getAllBestSelling.bestSellingContent.length,
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
