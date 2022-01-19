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
           if (_productView.productDetails.productInCart.quantity!='0') {
            for (int i = 0; i < _productView.productDetailsSizes.length; i++) {
              if (_productView.productDetailsSizes[i].sizeId ==
                  _productView.productDetails.productInCart.sizeId) {
                _productView.productDetailsSizes[i].isSelected = true;
              }
            }
            _currentCount = int.parse(
                _productView.productDetails.productInCart.quantity);
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

  void selectProductSize(
    int index,
  ) {
    //idOfSelectedSizeProduct = _productView.productDetailsSizes[index].sizeId;
    if(_productView.productDetailsSizes[index].isSelected==true){
      _productView.productDetails.productInCart.sizeId='';
    }else {
      _productView.productDetails.productInCart.sizeId =
          _productView.productDetailsSizes[index].sizeId;
      for (int i = 0; i < _productView.productDetailsSizes.length; i++) {
        _productView.productDetailsSizes[i].isSelected = false;
      }
    }
    if(_productView.productDetailsSizes[index].isSelected==true){
      _productView.productDetailsSizes[index].isSelected = false;

    }else {
      _productView.productDetailsSizes[index].isSelected = true;
    }
    notifyListeners();
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
