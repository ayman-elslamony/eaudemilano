import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Provider/CartProvider.dart';
import 'package:eaudemilano/Provider/FavouriteProvider.dart';
import 'package:eaudemilano/Provider/locale_provider.dart';

import 'package:eaudemilano/Screens/subScreens/ProfileScreen.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'NavigationHome.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _locale;

  @override
  void initState() {
    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
    Provider.of<CartProvider>(context, listen: false)
        .getAllProductsInCartFunction(context: context, locale: _locale);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) => Scaffold(
          appBar: AppBar(
            leading: IconButton(onPressed: () {
              openDrawer();
            }, icon: const ImageIcon(
               AssetImage('images/drawer.png'),
            ),),
            title: Row(
              children: [
                Text(
                  '${AppLocalizations.of(context).trans('cart')}',
                  style: Theme.of(context).textTheme.headline3.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                 Text(
                    cartProvider.allProductsInCartStage ==
                        GetAllProductsInCartStage.LOADING
                        ? ''
                        : '(${cartProvider.getAllProductsInCart.specificProduct.length} ${AppLocalizations.of(context).trans('items')})',
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.grey[600]),
                  ),

              ],
            ),
            actions: [
              InkWell(
                onTap: (){
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
              ),
            ],
            bottom: PreferredSize(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${AppLocalizations.of(context).trans('total')}:',
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(color: Colors.grey[600]),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        cartProvider.allProductsInCartStage ==
                            GetAllProductsInCartStage.LOADING
                            ? ''
                            :'${cartProvider.totalPrice}\$',
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
                preferredSize: Size(media.width, 38)),
          ),
          body: Container(
            width: media.width,
            height: media.height*0.8,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: const BoxDecoration(
              gradient:  LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF060606),
                  Color(0xFF747474),
                ],
              ),
            ),
            child: cartProvider.allProductsInCartStage ==
                GetAllProductsInCartStage.LOADING?Column(
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
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: defaultCard(
                    titleContent: cartProvider.getAllProductsInCart.specificProduct[index].quantity,
                    title: cartProvider.getAllProductsInCart.specificProduct[index].price,
                    subTitle: cartProvider.getAllProductsInCart.specificProduct[index].product.title,
                    imgUrl: cartProvider.getAllProductsInCart.specificProduct[index].product.image,
                    context: context, currentIndex: index, media: media,
                    onDeletePressed: (){
                      showDialog(
                          context: context,
                          builder: (context) =>  AlertDialog(
                            title: Text(
                              '${AppLocalizations.of(context).trans('remove_item')}',
                              style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.black87,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25.0))),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 18),
                            content: SizedBox(
                              height:80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox()
                                  ,defaultTextButton(function: (){
                                    Navigator.of(context).pop();
                                  }, textKey: 'cancel',context: context),
                                  defaultButton(function: (){
//                                    cartProvider.getAllProductsInCart.specificProduct[index].product.id
//                                    setState(() {
//                                      countList.removeAt(index);
//                                      Navigator.of(context).pop();
//                                    });

                                  }, text: '${AppLocalizations.of(context).trans('remove')}',width: 120,)
                                ],
                              ),
                            ),
                          ));
                    },
                    favIconUrl: cartProvider.getAllProductsInCart.specificProduct[index].favorite=='no'?'images/fav.png':'images/favWithColor.png',
                  onFavPressed:(){
                    cartProvider.addToFavouriteOrDelete(locale: _locale,context: context,index: index,);
                  }
                ),
              ),
              itemCount: cartProvider.getAllProductsInCart.specificProduct.length ,
            ),
          ),

      ),
    );
  }
}
