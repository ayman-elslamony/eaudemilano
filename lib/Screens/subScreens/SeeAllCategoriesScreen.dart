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
import 'package:shimmer/shimmer.dart';

import 'CategorieDetailsScreen.dart';

class SeeAllCategoriesScreen extends StatefulWidget {
  @override
  _SeeAllCategoriesScreenState createState() => _SeeAllCategoriesScreenState();
}

class _SeeAllCategoriesScreenState extends State<SeeAllCategoriesScreen> {
  String _locale;
  RefreshController _refreshControllerAllCategoriesScreen ;
  @override
  void initState() {
    _refreshControllerAllCategoriesScreen =
        RefreshController(initialRefresh: false);
    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;

    Provider.of<HomeProvider>(context, listen: false)
        .getAllCategoriesFunction(context: context, locale: _locale);

    super.initState();
  }
  void _onRefresh() async {
    await  Provider.of<HomeProvider>(context, listen: false)
        .getAllCategoriesFunction(context: context, locale: _locale);
    _refreshControllerAllCategoriesScreen.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return SmartRefresher(
      enablePullDown: true,
      controller: _refreshControllerAllCategoriesScreen,
      onRefresh: _onRefresh,
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
            '${AppLocalizations.of(context).trans('see_all')}',
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
            child: SingleChildScrollView(
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
                      physics:const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: homeProvider.allCategoriesStage ==
                                GetAllCategoriesStage.LOADING
                            ? Shimmer.fromColors(
                          child: Container(
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
                            child: const ListTile(
                              contentPadding:  EdgeInsets.symmetric(horizontal: 12.0),
                              hoverColor: primeColor,
                            ),
                          ),
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                        )
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
                                    Provider.of<HomeProvider>(context, listen: false).resetPageNumber();
                                    Provider.of<HomeProvider>(context, listen: false)
                                        .getCategorieDetailsFunction(context: context, locale: _locale,id:homeProvider.getAllCategories[index].id,currentPage: 1 );
                                    navigateTo(context, CategorieDetailsScreen(title: homeProvider.getAllCategories[index].title,id: homeProvider.getAllCategories[index].id,));
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
                          ? 5
                          : homeProvider.getAllCategories.length,
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
