// ignore_for_file: file_names, unnecessary_this, unnecessary_string_interpolations, use_rethrow_when_possible, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:eaudemilano/Helper/Helper.dart';
import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Models/ProductViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'CartProvider.dart';
import 'FavouriteProvider.dart';

enum GetProductViewStage { ERROR, LOADING, DONE }
enum GetProductViewSize { NOTSELECTED, SIZEONE, SIZEtWO }
enum GetProductPriceStage { ERROR, LOADING, DONE }
enum GetAddProductToCartStage { ERROR, LOADING, DONE }

class ViewProductProvider extends ChangeNotifier {
  String _token = '';
  // String idOfSelectedSizeProduct = '';

  Future<void> getUserToken() async {
    if (_token == '') {
      _token = Helper.token ?? await Helper.getUserTokenInSharedPreferences();
    }
  }

  GetProductViewSize getProductViewSize = GetProductViewSize.NOTSELECTED;
  GetProductViewStage getProductViewStage;
  ProductView _productView;
  ProductView get productView => _productView;

  Future<void> viewProduct({context, locale, int id}) async {
    this.getProductViewStage = GetProductViewStage.LOADING;
    isFavourite = false;
    _currentCount = 0;
    String url = '$domain/api/view-product/$id';
    await getUserToken();
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'api_password': apiPassword,
      'Authorization': 'Bearer $_token',
      'language': locale.toString()
    };
    try {
      Dio dio = Dio();
      Response response = await dio.get(url,
          options: Options(
              followRedirects: false,
              validateStatus: (status) => true,
              headers: headers));
      var responseJson = response.data;
      if (response.statusCode == 200 && responseJson["status"] == true) {
        if (responseJson['data'] != null) {
          _productView = ProductView.fromJson(responseJson['data']);
          if (_productView.productDetails.productInCart.quantity != '0') {
            for (int i = 0; i < _productView.productDetailsSizes.length; i++) {
              if (_productView.productDetailsSizes[i].sizeId ==
                  _productView.productDetails.productInCart.sizeId) {
                _productView.productDetailsSizes[i].isSelected = true;
              }
            }
            _currentCount =
                int.parse(_productView.productDetails.productInCart.quantity);
            await getProductPrice(locale: locale,context: context,enableNotify: false,size_id:_productView.productDetails.productInCart.sizeId);
          }
          if (_productView.productDetails.favorite == 'yes') {
            isFavourite = true;
          }
        }
        this.getProductViewStage = GetProductViewStage.DONE;
        notifyListeners();
      } else {
        this.getProductViewStage = GetProductViewStage.ERROR;
        var errors = responseJson['message'];
        showAlertDialog(context, content: '$errors');
        notifyListeners();
      }
    } catch (e) {
      this.getProductViewStage = GetProductViewStage.ERROR;
      notifyListeners();
      throw e;
    }
  }

  bool isFavourite = false;

  Future<bool> addToFavouriteOrDelete({context, locale}) async {
    String url =
        '$domain/api/user/add-to-favorite/${_productView.productDetails.id}';
    await getUserToken();
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'api_password': apiPassword,
      'Authorization': 'Bearer $_token',
      'language': locale.toString()
    };
    isFavourite = !isFavourite;

    notifyListeners();
    try {
      Dio dio = Dio();
      Response response = await dio.get(url,
          options: Options(
              followRedirects: false,
              validateStatus: (status) => true,
              headers: headers));
      var responseJson = response.data;
      if (response.statusCode == 200 && responseJson["status"] == true) {
        return true;
      } else {
        isFavourite = !isFavourite;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isFavourite = !isFavourite;
      notifyListeners();
      return false;
    }
  }

  GetAddProductToCartStage addProductToCartStage;

  Future<void> addProductToCart({context, locale, int productId}) async {
    this.addProductToCartStage = GetAddProductToCartStage.LOADING;
    notifyListeners();
    String url = '$domain/api/user/add-to-cart';
    await getUserToken();
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'api_password': apiPassword,
      'Authorization': 'Bearer $_token',
      'language': locale.toString()
    };

    var formData = FormData.fromMap({
      'product_id': productId.toString(),
      'size_id': _productView.productDetails.productInCart.sizeId,
      'quantity': _currentCount.toString(),
    });
    try {
      Dio dio = Dio();
      Response response = await dio.post(url,
          data: formData,
          options: Options(
              followRedirects: false,
              validateStatus: (status) => true,
              headers: headers));
      var responseJson = response.data;
      print(responseJson);
      if (response.statusCode == 200 && responseJson["status"] == true) {
        showAlertDialog(context, content: responseJson['message']);
        Provider.of<CartProvider>(context, listen: false)
            .getAllProductsInCartFunction(locale: locale, context: context);
//        if (responseJson['message'] != null) {
//
//
//        }
//        print(_allProductsInCart.specificProduct.length.toString());
//        await getAllProductsInCartFunction(locale: locale,context: context);
//        await getTotalPrice();
        this.addProductToCartStage = GetAddProductToCartStage.DONE;
        notifyListeners();
      } else {
        var errors = responseJson['message'];
        showAlertDialog(context, content: '$errors');

        this.addProductToCartStage = GetAddProductToCartStage.ERROR;
        notifyListeners();
      }
    } catch (e) {
      this.addProductToCartStage = GetAddProductToCartStage.ERROR;
      notifyListeners();
      throw e;
    }
  }
  GetProductPriceStage getProductPriceStage=GetProductPriceStage.DONE;
  Future<bool> getProductPrice({BuildContext context, locale,String size_id,bool enableNotify=true})async{
    if(enableNotify)
    {
      this.getProductPriceStage = GetProductPriceStage.LOADING;
      notifyListeners();
    }
    bool result = true;
    String url = '$domain/api/change-product-size?product_id=${_productView.productDetails.id}&size_id=$size_id';
    await getUserToken();
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'api_password': apiPassword,
      'Authorization': 'Bearer $_token',
      'language': locale.toString()
    };

    try {
      Dio dio = Dio();
      Response response = await dio.get(url,
          options: Options(
              followRedirects: false,
              validateStatus: (status) => true,
              headers: headers));
      var responseJson = response.data;
      print(responseJson);
      if (response.statusCode == 200 && responseJson["status"] == true) {
            _productView.productDetails.priceBeforeDiscount = responseJson["data"]["price_before_discount"];
            _productView.productDetails.price= responseJson["data"]["price"];
            result =true;
            if(enableNotify)
            {this.getProductPriceStage = GetProductPriceStage.DONE;
        notifyListeners();}
      } else {
//        var errors = responseJson['message'];
//        showAlertDialog(context, content: '$errors');
        result =false;
      }
      return result;
    } catch (e) {
      return false;
    }
  }
  void selectProductSize(
  {BuildContext context,locale,int index,}

  ) async{
    int indexOfPreviousSize;
    if (_productView.productDetailsSizes[index].isSelected == false)
    {
//      sizeId = _productView.productDetails.productInCart.sizeId;
//      _productView.productDetails.productInCart.sizeId = '';
//      _productView.productDetailsSizes[index].isSelected = false;
//     //bool isGettingScuess= await
//     getProductPrice(context: context,locale: locale,size_id:  _productView.productDetailsSizes[0].sizeId).then((isGettingScuess){
//       if(isGettingScuess == false){
//         _productView.productDetailsSizes[index].isSelected = true;
//         _productView.productDetails.productInCart.sizeId = sizeId;
//       }
//       this.getProductPriceStage = GetProductPriceStage.DONE;
//       notifyListeners();
//     });
//
//    } else {
      _productView.productDetails.productInCart.sizeId =
          _productView.productDetailsSizes[index].sizeId;
      for (int i = 0; i < _productView.productDetailsSizes.length; i++) {
        if(_productView.productDetailsSizes[i].isSelected == true){
          indexOfPreviousSize = i;
        }
        _productView.productDetailsSizes[i].isSelected = false;
      }
      _productView.productDetailsSizes[index].isSelected = true;
       getProductPrice(context: context,locale: locale,size_id:  _productView.productDetailsSizes[index].sizeId).then((isGettingScuess){
         if(isGettingScuess == false){
           _productView.productDetails.productInCart.sizeId =
               _productView.productDetailsSizes[indexOfPreviousSize].sizeId;
           _productView.productDetailsSizes[indexOfPreviousSize].isSelected = true;
           this.getProductPriceStage = GetProductPriceStage.DONE;
           notifyListeners();
         }

       });
    }

  }

  int _currentCount = 0;

  int get currentCount => _currentCount;

  void increment() {
    _currentCount++;
    notifyListeners();
  }

  void decrement() {
    if (_currentCount > 0) {
      _currentCount--;
    }
    notifyListeners();
  }
}
