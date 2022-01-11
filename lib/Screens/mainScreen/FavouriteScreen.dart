import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Provider/FavouriteProvider.dart';
import 'package:eaudemilano/Provider/locale_provider.dart';
import 'package:eaudemilano/Screens/subScreens/ProfileScreen.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'NavigationHome.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  String _locale;

  @override
  void initState() {
    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
    Provider.of<FavouriteProvider>(context, listen: false)
        .getAllProductsInFavouriteFunction(context: context, locale: _locale);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              openDrawer();
            },
            icon: const ImageIcon(
              AssetImage('images/drawer.png'),
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
                navigateAndFinish(context, ProfileScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 18,
                  child: ClipOval(
                    child: Image.asset(
                      "images/profile.png",
                      width: double.infinity,
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
          height: media.height * 0.8,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
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
            builder: (context, favouriteProvider, child) =>  favouriteProvider.allProductsInFavouriteStage ==
                          GetAllProductsInFavouriteStage.LOADING
                      ?Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                loaderApp()
              ],
            ): ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 5.0,
                          ),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: defaultCard(
                                titleContent: '',
                                imgUrl: favouriteProvider
                                    .getAllProductsInFavourite
                                    .products[index]
                                    .productDetails
                                    .image,
                                title: favouriteProvider
                                    .getAllProductsInFavourite
                                    .products[index]
                                    .productDetails
                                    .price,
                                subTitle: favouriteProvider
                                    .getAllProductsInFavourite
                                    .products[index]
                                    .productDetails
                                    .title,
                                context: context,
                                currentIndex: index,
                                media: media,
                                justEnableDeleteIcon: true,
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
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold),
                                              textAlign: TextAlign.start,
                                            ),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25.0))),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
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
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      textKey: 'cancel',
                                                      context: context),
                                                  defaultButton(
                                                    function: () {
//                                      favouriteProvider.getAllProductsInFavourite.products[index].productDetails.
//                                                      setState(() {
//                                                        countList
//                                                            .removeAt(index);
//                                                        Navigator.of(context)
//                                                            .pop();
//                                                      });
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
                          itemCount: favouriteProvider
                              .getAllProductsInFavourite.products.length,
                        ),
          ),
        ));
  }
}
