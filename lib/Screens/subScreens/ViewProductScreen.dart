import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Provider/HomeProvider.dart';
import 'package:eaudemilano/Provider/LocaleProvider.dart';
import 'package:eaudemilano/Provider/ViewProductProvider.dart';

import 'package:eaudemilano/Screens/subScreens/ProfileScreen.dart';
import 'package:eaudemilano/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ViewProductScreen extends StatefulWidget {
  final int productId;

  ViewProductScreen({@required this.productId});

  @override
  _ViewProductScreenState createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  String _locale;

  String imgUrl = '';

  @override
  void initState() {
    super.initState();
    print('vdv');
    print(widget.productId);
    _locale =
        Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
    Provider.of<ViewProductProvider>(context, listen: false)
        .viewProduct(context: context, locale: _locale, id: widget.productId);
  }

  Widget _createIncrementDicrementButton(IconData icon, Function onPressed) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: const BoxConstraints(minWidth: 32.0, minHeight: 44.0),
      onPressed: onPressed,
      elevation: 2.0,
      child: Icon(
        icon,
        color: Colors.white,
        size: 15.0,
      ),
      shape: const CircleBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return SafeArea(
      child: Consumer<ViewProductProvider>(
        builder: (context, viewProduct, child) => Scaffold(
          body: Container(
            width: media.width,
            height: media.height,
            padding: const EdgeInsets.all(0.0),
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
            child: viewProduct.getProductViewStage ==
                    GetProductViewStage.LOADING
                ? Center(
                    child: loaderApp(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: media.width,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              SizedBox(
                                width: media.width,
                                height: media.height * 0.49,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  color: Colors.grey[500],
                                  child: const SizedBox(),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  width: media.width,
                                  height: media.height * 0.484,
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  'images/back.png',
                                                  color: primeColor,
                                                  fit: BoxFit.fill,
                                                  height: 16,
                                                  width: 16,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            InkWell(
                                              onTap: () {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Image.asset(
                                                  'images/share.png',
                                                  color: primeColor,
                                                  fit: BoxFit.fill,
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: media.height * 0.28,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const SizedBox(
                                                width: 50,
                                              ),
                                              Expanded(
                                                child: Image.network(
                                                  imgUrl == ''
                                                      ? viewProduct.productView
                                                          .productDetails.image
                                                      : imgUrl,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              SizedBox(
//                                      height: media.height*0.28,
                                                width: media.width * 0.2,
                                                child: ListView.builder(
                                                  itemBuilder:
                                                      (context, index) =>
                                                          InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        imgUrl = viewProduct
                                                            .productView
                                                            .productDetailsImages[
                                                                index]
                                                            .image;
                                                      });
                                                    },
                                                    child: Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10.0,
                                                          vertical: 5.0),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 2,
                                                          vertical: 5),
                                                      decoration: const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12)),
                                                          color: Color(
                                                              0xFF8C8C8C)),
                                                      child: Image.network(
                                                        viewProduct
                                                            .productView
                                                            .productDetailsImages[
                                                                index]
                                                            .image,
                                                        height:
                                                            media.height * 0.07,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  shrinkWrap: true,
                                                  itemCount: viewProduct
                                                      .productView
                                                      .productDetailsImages
                                                      .length,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${viewProduct.productView.productDetails.price}\$',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4
                                                      .copyWith(
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Text(
                                                    viewProduct.productView
                                                        .productDetails.title,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6
                                                        .copyWith(
                                                            color: Colors
                                                                .grey[800])),
                                              ],
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              onPressed: () {
                                                viewProduct
                                                    .addToFavouriteOrDelete(
                                                  locale: _locale,
                                                  context: context,
                                                );
                                              },
                                              icon: ImageIcon(
                                                AssetImage(
                                                  viewProduct.isFavourite ==
                                                          false
                                                      ? 'images/fav.png'
                                                      : 'images/favWithColor.png',
                                                ),
                                                color: Colors.grey[600],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 3.0),
                          child: Column(
                            children: [
                              SizedBox(
                                width: media.width,
                                child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween
                                  children: [
                                    Text(
                                      '${AppLocalizations.of(context).trans('choose')}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          .copyWith(
                                            color: Colors.white70,
                                          ),
                                    ),
                                    Expanded(
                                      child: Wrap(
                                        direction: Axis.horizontal,
                                        children: List.generate(
                                          viewProduct.productView
                                              .productDetailsSizes.length,
                                          (index) => Container(
                                            height: 30.0,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 6.0, vertical: 8.0),
                                            child: MaterialButton(
                                              onPressed: () {
                                                viewProduct
                                                    .selectProductSize(index);
                                              },
                                              child: Text(
                                                viewProduct
                                                    .productView
                                                    .productDetailsSizes[index]
                                                    .sizeName,
                                                style: const TextStyle(
                                                  fontFamily: 'Lato',
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                12,
                                              ),
                                              border: Border.all(
                                                  color: secondaryColor),
                                              color:
                                                  viewProduct.isSelectedSizeOFProduct[
                                                              index] ==
                                                          true
                                                      ? const Color(0xFF8C8C8C)
                                                      : Colors.transparent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: SizedBox(
                                  width: media.width,
                                  child: Text(
                                    viewProduct
                                        .productView.productDetails.description,
                                    textAlign: TextAlign.start,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: SizedBox(
                                  width: media.width,
                                  height: 44.0,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          padding: EdgeInsets.zero,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            border: Border.all(
                                                color: const Color(0xFF8C8C8C)),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              _createIncrementDicrementButton(
                                                  Icons.remove,
                                                  () =>
                                                      viewProduct.decrement()),
                                              Text(viewProduct.currentCount
                                                  .toString()),
                                              _createIncrementDicrementButton(
                                                  Icons.add,
                                                  () =>
                                                      viewProduct.increment()),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          child: MaterialButton(
                                            onPressed: viewProduct
                                                        .currentCount ==
                                                    0
                                                ? null
                                                : () async{
                                                    if (viewProduct
                                                            .idOfSelectedSizeProduct ==
                                                        '') {
                                                      Fluttertoast.showToast(
                                                        msg: AppLocalizations.of(
                                                                        context)
                                                                    .locale
                                                                    .languageCode ==
                                                                "en"
                                                            ? 'Please Select Size of product'
                                                            : 'من فضلك اختر حجم المنتج',
                                                        toastLength:
                                                            Toast.LENGTH_LONG,
                                                        gravity:
                                                            ToastGravity.CENTER,
                                                        timeInSecForIosWeb: 5,
                                                        backgroundColor:
                                                            Colors.red,
                                                        textColor: Colors.black,
                                                        fontSize: 16.0,
                                                      );
                                                    } else {
                                                     await viewProduct.addProductToCart(
                                                          locale: _locale,
                                                          context: context,
                                                          productId: viewProduct
                                                              .productView
                                                              .productDetails
                                                              .id);
                                                    }
                                                  },
                                            child: Text(
                                              '${AppLocalizations.of(context).trans('add_to')}',
                                              style: const TextStyle(
                                                fontFamily: 'Lato',
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12.0,
                                            ),
                                            color: viewProduct.currentCount == 0
                                                ? secondaryColor
                                                : primeColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context).trans('similar_products')}',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  Visibility(
                                    visible: viewProduct.productView
                                            .similarProducts.isNotEmpty &&
                                        viewProduct.getProductViewStage !=
                                            GetProductViewStage.DONE,
                                    child: InkWell(
                                      onTap: () {
                                        // navigateTo(context, SeeAllBestSelling());
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 12.0,
                                            right: 12.0,
                                            top: 2.0,
                                            bottom: 2.0),
                                        child: Text(
                                          '${AppLocalizations.of(context).trans('see_all')}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4
                                              .copyWith(
                                                  color: primeColor,
                                                  decoration:
                                                      TextDecoration.underline),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              viewProduct.productView.similarProducts.isEmpty &&
                                      viewProduct.getProductViewStage ==
                                          GetProductViewStage.DONE
                                  ? Container(
                                      width: media.width,
                                      height: media.height * 0.07,
                                      child: Center(
                                        child: defaultSubtitleTextOne(
                                            context: context,
                                            text:
                                                '${AppLocalizations.of(context).trans('similar_product')}'),
                                      ),
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        height: 5.0,
                                      ),
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child:
                                            viewProduct.getProductViewStage ==
                                                    GetProductViewStage.LOADING
                                                ? loadingCard(media: media)
                                                : defaultCard(
                                                    productId: viewProduct
                                                        .productView
                                                        .similarProducts[index]
                                                        .id,
                                                    titleContent: '',
                                                    title: viewProduct
                                                        .productView
                                                        .similarProducts[index]
                                                        .price,
                                                    subTitle: viewProduct
                                                        .productView
                                                        .similarProducts[index]
                                                        .title,
                                                    context: context,
                                                    imgUrl: viewProduct
                                                        .productView
                                                        .similarProducts[index]
                                                        .image,
                                                    currentIndex: index,
                                                    media: media),
                                      ),
                                      itemCount:
                                          viewProduct.getProductViewStage ==
                                                  GetProductViewStage.LOADING
                                              ? 3
                                              : viewProduct.productView
                                                  .similarProducts.length,
                                    ),
                              const SizedBox(
                                height: 8.0,
                              )
                            ],
                          ),
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
