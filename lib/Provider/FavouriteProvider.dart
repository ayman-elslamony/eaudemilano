// ignore_for_file: file_names, unnecessary_this, unnecessary_string_interpolations, use_rethrow_when_possible, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:eaudemilano/Helper/Helper.dart';
import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Models/AllBestSellingModel.dart';
import 'package:eaudemilano/Models/AllProductsInCartModel.dart';
import 'package:eaudemilano/Models/AllProductsInFavouriteModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'CartProvider.dart';

enum GetAllProductsInFavouriteStage { ERROR, LOADING, DONE }

class FavouriteProvider extends ChangeNotifier {
  String _token = '';

  Future<void> getUserToken() async {
    if (_token == '') {
      _token = Helper.token ?? await Helper.getUserTokenInSharedPreferences();
    }
  }

  GetAllProductsInFavouriteStage allProductsInFavouriteStage;
  AllProductsInFavourite _allProductsInFavourite;

  AllProductsInFavourite get getAllProductsInFavourite => _allProductsInFavourite;

  Future<void> getAllProductsInFavouriteFunction({context, locale}) async {

    this.allProductsInFavouriteStage = GetAllProductsInFavouriteStage.LOADING;
   // notifyListeners();
    String url = '$domain/api/user/favorite';
    await getUserToken();
    print('_token');
    print(_token);
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
          _allProductsInFavourite = AllProductsInFavourite.fromJson(responseJson['data']);
        }else{
          _allProductsInFavourite = AllProductsInFavourite(
            products:[],
            currentPage: 0,
            totalProducts: 0
          );
        }
        print(_allProductsInFavourite.products.length.toString());
        this.allProductsInFavouriteStage = GetAllProductsInFavouriteStage.DONE;
        notifyListeners();
      } else {
        print('D');
        this.allProductsInFavouriteStage = GetAllProductsInFavouriteStage.ERROR;
        var errors = responseJson['message'];
        showAlertDialog(context, content: '$errors');
        notifyListeners();
      }
    } catch (e) {
      this.allProductsInFavouriteStage = GetAllProductsInFavouriteStage.ERROR;
      notifyListeners();
      print(e);
      throw e;
    }
  }


  checkIsFavourite(int index){
    if(_allProductsInFavourite.products[index].productDetails.enableLoader == false ){
      _allProductsInFavourite.products[index].productDetails.enableLoader = true;
    }else{
      _allProductsInFavourite.products[index].productDetails.enableLoader = false;
    }
  }

  Future<bool> removeFromFavourite({context, locale,int index,int id})async{
    _allProductsInFavourite.products[index].productDetails.enableLoader = true;
    notifyListeners();
    String url = '$domain/api/user/add-to-favorite/$id';
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
      print(responseJson);
      if (response.statusCode == 200 && responseJson["status"] == true) {
        _allProductsInFavourite.products.removeAt(index);
        notifyListeners();
        return true;
      }
      else {
        _allProductsInFavourite.products[index].productDetails.enableLoader = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _allProductsInFavourite.products[index].productDetails.enableLoader = false;
      notifyListeners();
      print(e);
      return false;
    }
  }
}
