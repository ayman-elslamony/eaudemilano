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

import 'CategorieDetailsScreen.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int idOfSpecificOrder;

  OrderDetailsScreen({this.idOfSpecificOrder});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  String _locale;

  @override
  void initState() {
    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
    Provider.of<HomeProvider>(context, listen: false).getOrderDetailsFunction(
        context: context, locale: _locale, idOfOrder: widget.idOfSpecificOrder);
    super.initState();
  }
Widget titleText({BuildContext context,String arTitle,String enTitle}){
    return  Text(
      AppLocalizations.of(context)
          .locale
          .languageCode ==
          "en"
          ? enTitle
          : arTitle,
      style: Theme.of(context)
          .textTheme
          .headline3
          .copyWith(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          height: 1.2),
    );
}
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) =>
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: media.height*0.5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                homeProvider.orderDetailsStage == GetOrderDetailsStage.LOADING
                        ? loaderApp(loaderMinSize: true)
                        : MediaQuery.removePadding(
                            context: context,
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: homeProvider.getOrderDetails.length,
                                itemBuilder: (context, index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    titleText(context: context,enTitle: 'Product Name: ${homeProvider.getOrderDetails[index].title}',arTitle: 'اسم المنتج: ${homeProvider.getOrderDetails[index].title}'),
                                    titleText(context: context,enTitle: 'Product Size: ${homeProvider.getOrderDetails[index].size}',arTitle: 'حجم المنتج: ${homeProvider.getOrderDetails[index].size}'),
                                    titleText(context: context,enTitle: 'Product price: ${homeProvider.getOrderDetails[index].price}\$',arTitle: 'سعر المنتج: ${homeProvider.getOrderDetails[index].price}\$'),
                                    titleText(context: context,enTitle: 'Quanity: ${homeProvider.getOrderDetails[index].quantity}',arTitle: 'العدد: ${homeProvider.getOrderDetails[index].quantity}'),

                                    titleText(context: context,enTitle: 'Total price: ${homeProvider.getOrderDetails[index].total}\$',arTitle: 'السعر الكلى: ${homeProvider.getOrderDetails[index].total}\$'),

                                  ],
                                ),
                            separatorBuilder: (context,index)=>Divider(thickness: 1,color: secondaryColor,),)),
              ],
            ),
          ),
    );
  }
}
