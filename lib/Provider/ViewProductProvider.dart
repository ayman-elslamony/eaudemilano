// ignore_for_file: file_names, unnecessary_this, unnecessary_string_interpolations, use_rethrow_when_possible, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:eaudemilano/Helper/Helper.dart';
import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Models/ProductViewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'FavouriteProvider.dart';

enum GetProductViewStage { ERROR, LOADING, DONE }
enum GetProductViewSize { NOTSELECTED, SIZEONE, SIZEtWO}


class ViewProductProvider extends ChangeNotifier {
  String _token = '';
  String idOfSelectedSizeProduct;
List<bool> isSelectedSizeOFProduct=[];
  Future<void> getUserToken() async {
    if (_token == '') {
      _token = Helper.token ?? await Helper.getUserTokenInSharedPreferences();
    }
  }
  GetProductViewSize getProductViewSize = GetProductViewSize.NOTSELECTED;
  GetProductViewStage getProductViewStage;
  ProductView _productView;

  ProductView get productView => _productView;

  Future<void> viewProduct({context, locale, int id})async{
    this.getProductViewStage = GetProductViewStage.LOADING;

    String url = '$domain/api/view-product/$id';
    await getUserToken();
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'api_password': apiPassword,
      'Authorization': _token,
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
        if (responseJson['data'] != null) {
          _productView= ProductView.fromJson(responseJson['data']);
          isSelectedSizeOFProduct= List.generate(_productView.productDetailsSizes.length, (index) => false);
        }
        print(_productView.productDetails.id.toString());
        this.getProductViewStage = GetProductViewStage.DONE;
        notifyListeners();
      } else {
        print('D');
        this.getProductViewStage = GetProductViewStage.ERROR;
        var errors = responseJson['message'];
        showAlertDialog(context, content: '$errors');
        notifyListeners();
      }
    } catch (e) {
      this.getProductViewStage = GetProductViewStage.ERROR;
      notifyListeners();
      print(e);
      throw e;
    }
  }
  bool isFavourite=false;
  Future<void> addToFavouriteOrDelete({context, locale})async{

    String url = '$domain/api/user/add-to-favorite/${_productView.productDetails.id}';
    await getUserToken();
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'api_password': apiPassword,
      'Authorization': 'Bearer $_token',
      'language': locale.toString()
    };
    isFavourite = true;
    notifyListeners();
    try {
      Dio dio = Dio();
      Response response = await dio.get(url,
          options: Options(
              followRedirects: false,
              validateStatus: (status) => true,
              headers: headers));
      var responseJson = response.data;
      print('responseJson');
      print(responseJson);
      if (response.statusCode == 200 && responseJson["status"] == true) {
        Provider.of<FavouriteProvider>(context,listen: false).getAllProductsInFavouriteFunction(
            context: context,
            locale: locale
        );
      }
      else {
        isFavourite = false;
        notifyListeners();
      }
    } catch (e) {
      isFavourite = false;
      notifyListeners();
      print(e);
      throw e;
    }
  }

void selectProductSize(int index,) {
  idOfSelectedSizeProduct = _productView.productDetailsSizes[index].sizeId;
    int length = isSelectedSizeOFProduct.length;

  isSelectedSizeOFProduct = List.generate(length, (index) => false);
    isSelectedSizeOFProduct[index] = true;
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