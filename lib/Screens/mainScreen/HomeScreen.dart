// ignore_for_file: file_names, unnecessary_this, unnecessary_string_interpolations, use_rethrow_when_possible, non_constant_identifier_names, unnecessary_brace_in_string_interps, prefer_final_fields, prefer_const_constructors, use_key_in_widget_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Provider/HomeProvider.dart';
import 'package:eaudemilano/Provider/SearchProvider.dart';
import 'package:eaudemilano/Provider/changeIndexPage.dart';
import 'package:eaudemilano/Provider/LocaleProvider.dart';

import 'package:eaudemilano/Screens/subScreens/ProfileScreen.dart';
import 'package:eaudemilano/Screens/subScreens/SeeAllBestSellingScreen.dart';
import 'package:eaudemilano/Screens/subScreens/SeeAllCategoriesScreen.dart';
import 'package:eaudemilano/Screens/subScreens/ViewProductScreen.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'NavigationHome.dart';

class HomeScreen extends StatefulWidget {
  static const String routName = '/Home_Screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String _locale;

  @override
  void initState() {
    super.initState();

    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
    Provider.of<HomeProvider>(context, listen: false)
        .getHomeData(context: context, locale: _locale);
  }

  createCard(
      {double width,
      double height,
      bool isFocusCard = true,
      String urlImage,
      String productPrice,
        Function onTap,
      String productName}) {
    return AnimatedSize(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Positioned(
              width: width * 0.525,
              height: isFocusCard ? height * 0.277 : height * 0.253,
              top: 8,
              left: 8,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: isFocusCard ? Color(0xFF8C8C8C) : Colors.white,
                child: SizedBox(),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 6.4,
              child: SizedBox(
                height: isFocusCard ? height * 0.28 : height * 0.255,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: isFocusCard ? Colors.white : Color(0xFF8C8C8C),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        urlImage,
                        width: width * 0.29,
                        height: height * 0.15,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '$productPrice\$',
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(productName,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.grey[800])),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
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
            icon: ImageIcon(
              AssetImage('images/drawer.png'),
            ),
          ),
        ),
        title: Consumer<ChangeIndex>(
          builder: (context, changeIndex, child) => SizedBox(
            height: 40,
            child: defaultFormField(
              removeContainer: true,
              validate: (val) {
                return null;
              },
              onTap: () async {
                changeIndex.changeIndexFunction(2);
              },
              readOnly: true,
              suffix: Icons.search,
              label: '${AppLocalizations.of(context).trans('search')}',
              isClickable: false,
              type: TextInputType.text,
            ),
          ),
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
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) => Container(
          width: media.width,
          height: media.height,
          //padding: const EdgeInsets.only(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: const [
                Color(0xFF060606),
                Color(0xFF747474),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 8.0,right: 12.0),
                      child: Row(
                        children: [
                          Text(
                              '${AppLocalizations.of(context).trans('popular')}',
                              style: Theme.of(context).textTheme.headline3),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: media.width,
                      height: 18,
                      child: Center(
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          removeLeft: true,
                          removeBottom: true,
                          removeRight: true,
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Text(
                                homeProvider
                                    .getAllPopularCategories[index].title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(
                                        color: homeProvider
                                                    .focusOnSpecificWidget ==
                                                index
                                            ? primeColor
                                            : secondaryColor),
                              );
                            },
                            itemCount:
                                homeProvider.getAllPopularCategories.length,
                            separatorBuilder: (context, index) => SizedBox(
                              width: 20,
                            ),
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: (){
                            navigateTo(context, SeeAllCategoriesScreen());
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            child: Text(
                              '${AppLocalizations.of(context).trans('see_all')}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                      color: primeColor,
                                      decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                homeProvider.allPopularCategoriesStage ==
                        GetPopularCategoriesStageStage.LOADING
                    ? CarouselSlider.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) => Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          child: SizedBox(
                            height: media.height * 0.28,
                            width: double.infinity,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: media.width * 0.29,
                                    height: media.height * 0.15,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        options: CarouselOptions(
                          disableCenter: false,
                          viewportFraction: 0.55,
                          height: media.height * 0.3,
                          aspectRatio: 16 / 9,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          initialPage: 1,
                          enableInfiniteScroll: false,
                          autoPlay: false,
                          scrollDirection: Axis.horizontal,
                        ),
                      )
                    : CarouselSlider.builder(
                        itemCount: homeProvider.getAllPopularCategories.length,
                        itemBuilder: (context, index) => createCard(
                          onTap: (){
                            navigateTo(context, ViewProductScreen(
                              productId: homeProvider
                                  .getAllPopularCategories[index].product.id,
                            ));
                          },
                            productName: homeProvider
                                .getAllPopularCategories[index].product.title,
                            productPrice: homeProvider
                                .getAllPopularCategories[index].product.price,
                            urlImage: homeProvider
                                .getAllPopularCategories[index].product.image,
                            width: media.width,
                            height: media.height,
                            isFocusCard:
                                homeProvider.focusOnSpecificWidget == index
                                    ? true
                                    : false),
                        options: CarouselOptions(
                          disableCenter: false,
                          viewportFraction: 0.55,
                          height: media.height * 0.3,
                          aspectRatio: 16 / 9,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          initialPage: 1,
                          enableInfiniteScroll: false,
                          autoPlay: false,
                          onPageChanged:
                              homeProvider.focusOnSpecificWidgetFunction,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${AppLocalizations.of(context).trans('best_selling')}',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      InkWell(
                        onTap: () {
                          navigateTo(context, SeeAllBestSelling());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                          child: Text(
                            '${AppLocalizations.of(context).trans('see_all')}',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(
                                    color: primeColor,
                                    decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5.0,
                  ),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: homeProvider.someBestSellingStage ==
                            GetSomeBestSellingStage.LOADING
                        ? loadingCard(media: media)
                        : defaultCard(
                      productId: homeProvider.getSomeBestSelling[index].id,
                            titleContent: '',
                            title: homeProvider.getSomeBestSelling[index].price,
                            subTitle:
                                homeProvider.getSomeBestSelling[index].title,
                            context: context,
                            imgUrl:
                                homeProvider.getSomeBestSelling[index].image,
                            currentIndex: index,
                            media: media),
                  ),
                  itemCount: homeProvider.someBestSellingStage ==
                          GetSomeBestSellingStage.LOADING
                      ? 5
                      : homeProvider.getSomeBestSelling.length,
                ),
                SizedBox(
                  height: 8.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
