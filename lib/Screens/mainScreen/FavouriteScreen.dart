import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Provider/CartProvider.dart';
import 'package:eaudemilano/Provider/FavouriteProvider.dart';
import 'package:eaudemilano/Provider/changeIndexPage.dart';
import 'package:eaudemilano/Provider/LocaleProvider.dart';
import 'package:eaudemilano/Screens/subScreens/ProfileScreen.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import 'NavigationHome.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  String _locale;
  var _cartProvider;
  RefreshController _refreshControllerFavouriteScreen;
  @override
  void initState() {
    _refreshControllerFavouriteScreen =
        RefreshController(initialRefresh: false);

    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;

    if (Provider.of<FavouriteProvider>(context, listen: false)
        .getAllProductsInFavourite
        .products
        .isEmpty) {
      Provider.of<FavouriteProvider>(context, listen: false)
          .getAllProductsInFavouriteFunction(context: context, locale: _locale);
    }

    _cartProvider = Provider.of<CartProvider>(context, listen: false);
    super.initState();
  }

  int nextPage;
  void _onRefresh() async {
    await Provider.of<FavouriteProvider>(context, listen: false)
        .getAllProductsInFavouriteFunction(
            context: context, locale: _locale, enableLoading: false);
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshControllerFavouriteScreen.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));

    nextPage = Provider.of<FavouriteProvider>(context, listen: false).nextPage;
    if (nextPage != null) {
      Provider.of<FavouriteProvider>(context, listen: false)
          .getAllProductsInFavouriteFunction(
              context: context, locale: _locale, currentPage: nextPage);
      if (mounted) {
        setState(() {});
        _refreshControllerFavouriteScreen.loadComplete();
      }
    } else {
      if (mounted) {
        setState(() {});
        _refreshControllerFavouriteScreen.loadNoData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: Consumer<ChangeIndex>(
            builder: (context, changeIndex, child) => IconButton(
              onPressed: () {
                changeIndex.openDrawer();
              },
              icon: const ImageIcon(
                AssetImage('images/drawer.png'),
              ),
            ),
          ),
          title: Row(
            children: [
              Text(
                '${AppLocalizations.of(context).trans('favourite')}',
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Consumer<FavouriteProvider>(
                builder: (context, favouriteProvider, child) => Text(
                  favouriteProvider.allProductsInFavouriteStage ==
                          GetAllProductsInFavouriteStage.LOADING
                      ? ''
                      : '(${favouriteProvider.getAllProductsInFavourite.products.length} ${AppLocalizations.of(context).trans('items')})',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.grey[600]),
                ),
              ),
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
                navigateTo(context, ProfileScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 18,
                  child: ClipOval(
                    child: Image.asset(
                      'images/user.png',
                      color: primeColor,
                      width: 24,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Container(
          width: media.width,
          height: media.height * 0.82,
          padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 12.0),
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
          child: Consumer<FavouriteProvider>(
            builder: (context, favouriteProvider, child) => favouriteProvider
                            .allProductsInFavouriteStage ==
                        GetAllProductsInFavouriteStage.DONE &&
                    favouriteProvider.getAllProductsInFavourite.products.isEmpty
                ? Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            AppLocalizations.of(context).locale.languageCode ==
                                    "en"
                                ? 'There are no products in ${AppLocalizations.of(context).trans('favourite')}'
                                : 'لايوجد منتجات فى ${AppLocalizations.of(context).trans('favourite')} ',
                            style: Theme.of(context).textTheme.headline3,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  )
                : SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    controller: _refreshControllerFavouriteScreen,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    footer: CustomFooter(
                      height: 100,
                      builder: (BuildContext context, LoadStatus mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = Text(
                              AppLocalizations.of(context).trans("swipe_up"));
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
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 12.0),
                                child: favouriteProvider
                                            .allProductsInFavouriteStage ==
                                        GetAllProductsInFavouriteStage.LOADING
                                    ? loadingCard(media: media)
                                    : defaultCard(
                                        productId: favouriteProvider
                                            .getAllProductsInFavourite
                                            .products[index]
                                            .productDetails
                                            .id,
                                        titleContent: '',
                                        imgUrl: favouriteProvider
                                            .getAllProductsInFavourite
                                            .products[index]
                                            .productDetails
                                            .image,
                                        price: favouriteProvider
                                            .getAllProductsInFavourite
                                            .products[index]
                                            .productDetails
                                            .price,
                                        priceBeforeDiscount: favouriteProvider
                                            .getAllProductsInFavourite
                                            .products[index]
                                            .productDetails
                                            .priceBeforeDiscount,
                                        productName: favouriteProvider
                                            .getAllProductsInFavourite
                                            .products[index]
                                            .productDetails
                                            .title,
                                        context: context,
                                        currentIndex: index,
                                        media: media,
                                        justEnableDeleteIcon: true,
                                        isEnabledReload: favouriteProvider
                                            .getAllProductsInFavourite
                                            .products[index]
                                            .productDetails
                                            .enableLoader,
                                        onDeletePressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    title: Text(
                                                      '${AppLocalizations.of(context).trans('remove_item')}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3
                                                          .copyWith(
                                                              color: Colors
                                                                  .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                    shape: const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25.0))),
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 20,
                                                            vertical: 18),
                                                    content: SizedBox(
                                                      height: 80,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const SizedBox(),
                                                          defaultTextButton(
                                                              function: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              textKey: 'cancel',
                                                              context: context),
                                                          defaultButton(
                                                            function: () async {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              int id = favouriteProvider
                                                                  .getAllProductsInFavourite
                                                                  .products[
                                                                      index]
                                                                  .productDetails
                                                                  .id;
                                                              bool result = await favouriteProvider
                                                                  .removeFromFavourite(
                                                                      locale:
                                                                          _locale,
                                                                      context:
                                                                          context,
                                                                      index:
                                                                          index,
                                                                      id: id);
                                                              if (result ==
                                                                  true) {
                                                                _cartProvider
                                                                    .removeFavouriteProductInCart(
                                                                        id: id);
                                                              }
                                                            },
                                                            text:
                                                                '${AppLocalizations.of(context).trans('remove')}',
                                                            width: 120,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ));
                                        },
                                      ),
                              );
                            },
                            itemCount:
                                favouriteProvider.allProductsInFavouriteStage ==
                                        GetAllProductsInFavouriteStage.LOADING
                                    ? 5
                                    : favouriteProvider
                                        .getAllProductsInFavourite
                                        .products
                                        .length,
                          ),
                          const SizedBox(
                            height: 12.0,
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ));
  }
}
