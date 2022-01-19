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

class CategorieDetailsScreen extends StatefulWidget {
  final String title;
  final int id;

  CategorieDetailsScreen({this.title,this.id});

  @override
  _CategorieDetailsScreenState createState() => _CategorieDetailsScreenState();
}

class _CategorieDetailsScreenState extends State<CategorieDetailsScreen> {
  String _locale;
  RefreshController _refreshControllerCategorieDetails ;
  int nextPage;
  @override
  void initState() {
    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
    _refreshControllerCategorieDetails =
        RefreshController(initialRefresh: false);
    super.initState();
  }
  void _onRefresh() async {

    await Provider.of<HomeProvider>(context, listen: false)
        .getCategorieDetailsFunction(context: context, locale: _locale,id:widget.id);
    _refreshControllerCategorieDetails.refreshCompleted();
  }
  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));

    nextPage = Provider.of<HomeProvider>(context, listen: false)
      .nextPage;
    if (nextPage != null) {
      Provider.of<HomeProvider>(context, listen: false)
          .getCategorieDetailsFunction(context: context, locale: _locale,id:widget.id,currentPage: nextPage);
      if (mounted) {
      //  setState(() {});
        _refreshControllerCategorieDetails.loadComplete();
      }
    } else {
      if (mounted) {
     //   setState(() {});
        _refreshControllerCategorieDetails.loadNoData();
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
          widget.title,
          style: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body:SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshControllerCategorieDetails,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        footer: CustomFooter(
         loadStyle: LoadStyle.HideAlways,
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = defaultSubtitleTextOne(
                  context: context, text: '${AppLocalizations.of(context).trans('swipe_up')}');
            } else if (mode == LoadStatus.loading) {
              body = const Padding(
                padding:  EdgeInsets.only(top: 10),
                child: CupertinoActivityIndicator(),
              );
            } else if (mode == LoadStatus.failed) {
              body = defaultSubtitleTextOne(
                  context: context, text: '${AppLocalizations.of(context).trans('load_failed')}');
            }  else {
              body = defaultSubtitleTextOne(
                  context: context, text: '${AppLocalizations.of(context).trans('no_more_notifications')}');
            }
            return Container(
              color: primeColor,
              height: 50,
              child: Center(child: body),
            );
          },
        ),
        child: Consumer<HomeProvider>(
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
            child: homeProvider.getCategorieDetails.isEmpty &&
                homeProvider.categorieDetailsStage ==
                    GetCategorieDetailsStage.DONE
                ? Center(
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                        AppLocalizations.of(context).locale.languageCode ==
                            "en"
                            ? 'Sorry there are no any products in ${widget.title}'
                            : '${widget.title}نأسف لايوجد منتجات فى  ',
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            )
                :SingleChildScrollView(
              child: Column(
                children: [
                   MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          removeLeft: true,
                          removeRight: true,
                          removeBottom: false,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: homeProvider.categorieDetailsStage ==
                                      GetCategorieDetailsStage.LOADING
                                  ? loadingCard(media: media)
                                  : defaultCard(
                                      productId: homeProvider
                                          .getCategorieDetails[index].id,
                                      titleContent: '',
                                      price: homeProvider.getCategorieDetails
                                          [index].price,
                                      priceBeforeDiscount: homeProvider.getCategorieDetails
                                      [index].price,
                                      imgUrl: homeProvider.getCategorieDetails
                                          [index].image,
                                      subTitle: homeProvider.getCategorieDetails
                                          [index].title,
                                      context: context,
                                      currentIndex: index,
                                      media: media),
                            ),
                            itemCount: homeProvider.categorieDetailsStage ==
                                    GetCategorieDetailsStage.LOADING
                                ? 5
                                : homeProvider.getCategorieDetails. length,
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
