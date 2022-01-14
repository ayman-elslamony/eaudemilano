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

enum GetCheckOutProviderStage { ERROR, LOADING, DONE }

class CheckOutProvider extends ChangeNotifier {
  String _token = '';

  static String _directLink = '';
    static int _paymentMethod =0;

   String get directLink => _directLink;
  int get paymentMethod => _paymentMethod;

  Future<void> getUserToken() async {
    if (_token == '') {
      _token = Helper.token ?? await Helper.getUserTokenInSharedPreferences();
    }
  }

   setPaymentMethod(int value) {
    _paymentMethod = value;
  }
  GetCheckOutProviderStage checkOutProviderStage;

  static int _areaId=1;

  setAreaId(val){
    print('dgdg');
    print(val);
    _areaId = val;
  }
  Future<bool> sendUserData({
    context,
    locale,
    name,
    sur_name,
    email,
    mobile,
    street,
    zip_code,
    city,
  }) async {
    this.checkOutProviderStage = GetCheckOutProviderStage.LOADING;
    notifyListeners();
    String url = '$domain/api/user/checkout';
    String token = '';
    if (token == '') {
      token = Helper.token ?? await Helper.getUserTokenInSharedPreferences();
    }
    print(token);
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      'api_password': apiPassword,
      'language': locale.toString()
    };

    var formData = FormData.fromMap({
      'name': name,
      'sur_name': sur_name,
      'email': email,
      'mobile': mobile,
      'area_id': _areaId,
      'street': street,
      'zip_code': zip_code,
      'city': city,
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
//        await showAlertDialog(context, content: responseJson["message"],onOk: ()async{
//          Navigator.of(context).pop();
//        });
        _directLink = responseJson["link"];
        print(responseJson["link"]);
        this.checkOutProviderStage = GetCheckOutProviderStage.DONE;
        notifyListeners();
        return true;
      } else {
        print('D');
        this.checkOutProviderStage = GetCheckOutProviderStage.ERROR;
        var errors = responseJson['message'];
        showAlertDialog(context, content: '$errors');
        notifyListeners();
        return false;
      }
    } catch (e) {
      this.checkOutProviderStage = GetCheckOutProviderStage.ERROR;
      notifyListeners();
      print(e);
      return false;
    }
  }



}
