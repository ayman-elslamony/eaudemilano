// ignore_for_file: file_names, unnecessary_this, unnecessary_string_interpolations, use_rethrow_when_possible, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:eaudemilano/Helper/Helper.dart';
import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Models/AllBestSellingModel.dart';
import 'package:eaudemilano/Models/AllProductsInCartModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'FavouriteProvider.dart';

enum GetAllProductsInCartStage { ERROR, LOADING, DONE }

class CartProvider extends ChangeNotifier {
  String _token = '';

  Future<void> getUserToken() async {
    if (_token == '') {
      _token = Helper.token ?? await Helper.getUserTokenInSharedPreferences();
    }
  }

  GetAllProductsInCartStage allProductsInCartStage;
  AllProductsInCart _allProductsInCart;

  AllProductsInCart get getAllProductsInCart => _allProductsInCart;

  Future<void> getAllProductsInCartFunction({context, locale}) async {
    this.allProductsInCartStage = GetAllProductsInCartStage.LOADING;
    String url = '$domain/api/user/cart';
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
      print('responseJson');
      print(responseJson['data']);
      if (response.statusCode == 200 && responseJson["status"] == true) {
        if (responseJson['data'] != null) {
          _allProductsInCart = AllProductsInCart.fromJson(responseJson['data']);
        }
        print(_allProductsInCart.specificProduct.length.toString());
        await getTotalPrice();
        this.allProductsInCartStage = GetAllProductsInCartStage.DONE;
        notifyListeners();
      } else {
        print('D');
        this.allProductsInCartStage = GetAllProductsInCartStage.ERROR;
        var errors = responseJson['message'];
        showAlertDialog(context, content: '$errors');
        notifyListeners();
      }
    } catch (e) {
      this.allProductsInCartStage = GetAllProductsInCartStage.ERROR;
      notifyListeners();
      print(e);
      throw e;
    }
  }

  double _totalPrice=0;

  double get totalPrice => _totalPrice;

  Future<void>  getTotalPrice()async{
    _totalPrice=0;
    if(_allProductsInCart.specificProduct.isNotEmpty) {
      for (int i = 0; i < _allProductsInCart.specificProduct.length; i++) {
        _totalPrice  += double.parse(_allProductsInCart.specificProduct[i].total);
      }
    }
  }
  checkIsFavourite(int index){
    if(_allProductsInCart.specificProduct[index].favorite=='no'){
      _allProductsInCart.specificProduct[index].favorite='yes';
    }else{
      _allProductsInCart.specificProduct[index].favorite='no';
    }
  }
  Future<void> addToFavouriteOrDelete({context, locale,int index})async{
    String url = '$domain/api/user/add-to-favorite/${_allProductsInCart.specificProduct[index].id}';
    await getUserToken();
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'api_password': apiPassword,
      'Authorization': 'Bearer $_token',
      'language': locale.toString()
    };

    checkIsFavourite(index);
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
        checkIsFavourite(index);
        notifyListeners();

      }
    } catch (e) {
      checkIsFavourite(index);
      notifyListeners();
      print(e);
      throw e;
    }
  }
}
