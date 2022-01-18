// ignore_for_file: file_names, unnecessary_this, unnecessary_string_interpolations, use_rethrow_when_possible, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:eaudemilano/Helper/Helper.dart';
import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/Models/AllBestSellingModel.dart';
import 'package:eaudemilano/Models/AllProductsInCartModel.dart';
import 'package:eaudemilano/Models/MyOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'FavouriteProvider.dart';

enum GetCheckOutProviderStage { ERROR, LOADING, DONE }
enum GetDirectLinkStage { ERROR, LOADING, DONE }

class CheckOutProvider extends ChangeNotifier {
  String _token = '';

  static String _directLink = '';
//    static int _paymentMethod =0;

   String get directLink => _directLink;
//  int get paymentMethod => _paymentMethod;

  Future<void> getUserToken() async {
    if (_token == '') {
      _token = Helper.token ?? await Helper.getUserTokenInSharedPreferences();
    }
  }

//   setPaymentMethod(int value) {
//    _paymentMethod = value;
//  }
  GetCheckOutProviderStage checkOutProviderStage;
  MyOrder _myOrder= MyOrder(details: []);

  MyOrder get myOrder => _myOrder;
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
        _myOrder =MyOrder.fromJson(responseJson["data"]);
        print(_myOrder.details.length);
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
  GetDirectLinkStage directLinkStage;
  Future<bool> getDirectLink({
    context,
    locale,
  }) async {
    this.directLinkStage = GetDirectLinkStage.LOADING;
    notifyListeners();
    String url = '$domain/api/user/myfatoorh';
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
      'id': _myOrder.id,
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
        _directLink = responseJson["link"];
       await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              contentPadding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
              title: const SizedBox(),
              content: Text(
                responseJson['message'],
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
              ),
              actions: [
                FlatButton(
                  child: Text(
                    AppLocalizations.of(context).trans("ok"),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                  ),
                  onPressed:
                      () async{
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
        this.directLinkStage = GetDirectLinkStage.DONE;
        notifyListeners();
        return true;
      } else {
        print('D');
        this.directLinkStage = GetDirectLinkStage.ERROR;
        var errors = responseJson['message'];
       showAlertDialog(context,content: errors);
        notifyListeners();
        return false;
      }
    } catch (e) {
      this.directLinkStage = GetDirectLinkStage.ERROR;
      notifyListeners();
      print(e);
      return false;
    }
  }

}
