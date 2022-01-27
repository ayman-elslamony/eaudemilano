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

import 'CategorieDetailsScreen.dart';
import 'OrderDetailsScreen.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String _locale;
  int nextPage;
  RefreshController _refreshControllerOrderScreen;
  @override
  void initState() {
    _refreshControllerOrderScreen= RefreshController(initialRefresh: false);
    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
    Provider.of<HomeProvider>(context, listen: false)
        .getAllOrdersFunction(context: context, locale: _locale);
    super.initState();
  }

  void _onRefresh() async {
    Provider.of<HomeProvider>(context, listen: false)
        .getAllOrdersFunction(context: context, locale: _locale);
    _refreshControllerOrderScreen.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));

    nextPage = Provider.of<HomeProvider>(context, listen: false).nextPage;
    if (nextPage != null) {
      Provider.of<HomeProvider>(context, listen: false).getAllOrdersFunction(
          context: context, locale: _locale, currentPage: nextPage);
      if (mounted) {
        setState(() {});
        _refreshControllerOrderScreen.loadComplete();
      }
    } else {
      if (mounted) {
        setState(() {});
        _refreshControllerOrderScreen.loadNoData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      controller: _refreshControllerOrderScreen,
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
            body = Text(
                AppLocalizations.of(context).trans("no_more_notifications"));
          }
          return Container(
            height: 1.0,
            child: Center(child: body),
          );
        },
      ),
      child: Scaffold(
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
            child: homeProvider.allOrdersStage == GetAllOrdersStage.DONE &&
                    homeProvider.getAllOrders.isEmpty
                ? Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context).locale.languageCode ==
                                    "en"
                                ? 'There are no orders yet'
                                : 'لايوجد طلبات',
                            style: Theme.of(context).textTheme.headline3,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        MediaQuery.removePadding(
                          context: context,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: homeProvider.allOrdersStage ==
                                      GetAllOrdersStage.LOADING
                                  ? loadingCard(media: media)
                                  : InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title: Text(
                                                    AppLocalizations.of(context)
                                                                .locale
                                                                .languageCode ==
                                                            "en"
                                                        ? 'Order Details'
                                                        : 'تفاصيل الطلب',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2
                                                        .copyWith(
                                                            color: primeColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      25.0))),
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20,
                                                          vertical: 12.0),
                                                  content: OrderDetailsScreen(
                                                    idOfSpecificOrder:
                                                        homeProvider
                                                            .getAllOrders[index]
                                                            .id,
                                                  ),
                                                  actions: [
                                                    defaultTextButton(
                                                        function: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        textKey: 'ok',
                                                        textColor: primeColor,
                                                        context: context)
                                                  ],
                                                ));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 8.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8)),
                                            border: Border.all(
                                                color: secondaryColor)),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)
                                                              .locale
                                                              .languageCode ==
                                                          "en"
                                                      ? 'Price Of All Products: ${homeProvider.getAllOrders[index].total}\$'
                                                      : ' إجمالى سعر المنتجات: ${homeProvider.getAllOrders[index].total}\$',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline3
                                                      .copyWith(
                                                          color: primeColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          height: 1.2),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)
                                                              .locale
                                                              .languageCode ==
                                                          "en"
                                                      ? 'Number Of products: ${homeProvider.getAllOrders[index].countItems}'
                                                      : ' عدد المنتجات: ${homeProvider.getAllOrders[index].countItems}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4
                                                      .copyWith(
                                                        color: secondaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)
                                                              .locale
                                                              .languageCode ==
                                                          "en"
                                                      ? 'Operation Date: ${homeProvider.getAllOrders[index].operationDate}'
                                                      : ' تاريخ العملية: ${homeProvider.getAllOrders[index].operationDate}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4
                                                      .copyWith(
                                                          color: secondaryColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)
                                                              .locale
                                                              .languageCode ==
                                                          "en"
                                                      ? 'SerialNumber: ${homeProvider.getAllOrders[index].serialNumber}'
                                                      : ' رقم سري: ${homeProvider.getAllOrders[index].serialNumber}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4
                                                      .copyWith(
                                                          color: secondaryColor,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              size: 18.0,
                                              color: primeColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ),
                            itemCount: homeProvider.allCategoriesStage ==
                                    GetAllCategoriesStage.LOADING
                                ? 8
                                : homeProvider.getAllOrders.length,
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
