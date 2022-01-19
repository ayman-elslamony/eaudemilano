// ignore_for_file: file_names, unnecessary_this, unnecessary_string_interpolations, use_rethrow_when_possible, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:eaudemilano/Helper/Helper.dart';
import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Models/AllBestSellingModel.dart';
import 'package:eaudemilano/Models/AllCategoriesModel.dart';
import 'package:eaudemilano/Models/AllOrdersModel.dart';
import 'package:eaudemilano/Models/CategorieDetailsModel.dart';
import 'package:eaudemilano/Models/CategorieDetailsModel.dart';
import 'package:eaudemilano/Models/CategorieDetailsModel.dart';
import 'package:eaudemilano/Models/CategorieDetailsModel.dart';
import 'package:eaudemilano/Models/OrderDetailsModel.dart';
import 'package:eaudemilano/Models/PopularCategoriesModel.dart';
import 'package:eaudemilano/Models/ProductViewModel.dart';
import 'package:eaudemilano/Models/SettingInformation.dart';
import 'package:eaudemilano/Models/SomeBestSellingModel.dart';
import 'package:flutter/material.dart';

import '../main.dart';

enum GetHomeStage { ERROR, LOADING, DONE }
enum GetAllCategoriesStage { ERROR, LOADING, DONE }
enum GetCategorieDetailsStage { ERROR, LOADING, DONE }
enum GetPopularCategoriesStageStage { ERROR, LOADING, DONE }
enum GetSomeBestSellingStage { ERROR, LOADING, DONE }
enum GetAllBestSellingStage { ERROR, LOADING, DONE }
enum GetAllOrdersStage { ERROR, LOADING, DONE }
enum GetOrderDetailsStage { ERROR, LOADING, DONE }
enum GetSettingInformationStage { ERROR, LOADING, DONE }

class HomeProvider extends ChangeNotifier {

  GetHomeStage homeStage;

  String _token = '';
  Future<void> getUserToken() async {
    if (_token == '') {
      _token = Helper.token ?? await Helper.getUserTokenInSharedPreferences();
    }
  }

  onRefresh({context,locale})async{
    _someBestSelling=[];
    _allPopularCategories=[];
    this.someBestSellingStage = GetSomeBestSellingStage.LOADING;
    await getAllPopularCategoriesFunction(context: context,locale: locale,enableNotify: true);
    await getSomeBestSellingFunction(context: context,locale: locale);

  }
Future<void> getHomeData({context,locale})async{
  bool enableNotify=false;
  if(_someBestSelling.isEmpty || _allPopularCategories.isEmpty) {
    this.homeStage = GetHomeStage.LOADING;
    enableNotify = true;
  }
  if(_someBestSelling.isEmpty){
    this.someBestSellingStage = GetSomeBestSellingStage.LOADING;
  }
  if(_allPopularCategories.isEmpty){
    await getAllPopularCategoriesFunction(context: context,locale: locale);
  }
 if(_someBestSelling.isEmpty){
    await getSomeBestSellingFunction(context: context,locale: locale);
  }


if(enableNotify) {
  homeStage = GetHomeStage.DONE;
  notifyListeners();
}
}

  GetAllCategoriesStage allCategoriesStage;
  List<Categorie> _allCategories=[];

  List<Categorie> get getAllCategories => _allCategories;

  Future<void> getAllCategoriesFunction({context, locale}) async {
    if(_allCategories.isEmpty){
      this.allCategoriesStage = GetAllCategoriesStage.LOADING;
      // notifyListeners();
      String url = '$domain/api/categories';
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
          if (responseJson['data'] != null) {
            _allCategories = <Categorie>[];
            responseJson['data'].forEach((v) {
              _allCategories
                  .add(Categorie.fromJson(v));
            });
          }
          print(_allCategories.length.toString());
          this.allCategoriesStage = GetAllCategoriesStage.DONE;
          notifyListeners();
        } else {
          print('D');
          this.allCategoriesStage = GetAllCategoriesStage.ERROR;
          var errors = responseJson['message'];
          showAlertDialog(context, content: '$errors');
          notifyListeners();
        }
      } catch (e) {
        this.allCategoriesStage = GetAllCategoriesStage.ERROR;
        notifyListeners();
        print(e);
        throw e;
      }
    }
  }

  GetCategorieDetailsStage categorieDetailsStage;
  List<CategorieDetails> _CategorieDetails=[];
  List<CategorieDetails> _temporaryCategorieDetails=[];

  List<CategorieDetails> get getCategorieDetails => _CategorieDetails;

  int pageNumber = 1;
  int get nextPage => pageNumber;
  void resetPageNumber(){
    pageNumber = 1;
  }
  Future<void> getCategorieDetailsFunction({context, locale, int id, currentPage = 1}) async {
    print(pageNumber);
    print(currentPage);
    if (currentPage == 1) {
      this.categorieDetailsStage = GetCategorieDetailsStage.LOADING;
      _CategorieDetails=[];
      _temporaryCategorieDetails = [];
    }
    print('_temporaryCategorieDetailssssssssssss');
    print(_temporaryCategorieDetails.length);
    print('_CategorieDetailsssssssss');
    print(_CategorieDetails.length);
    String url = '$domain/api/categories/$id?page=$currentPage';
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
        final int lastPage = responseJson["data"]["last_page"];
        _temporaryCategorieDetails = _CategorieDetails;
        responseJson['data']['data'].forEach((v) {
          _temporaryCategorieDetails.add(CategorieDetails.fromJson(v));
      });
        pageNumber = currentPage;
         if(pageNumber < lastPage) {
           pageNumber++;
         }
         print('_temporaryCategorieDetails');
         print(_temporaryCategorieDetails.length);
         _CategorieDetails = _temporaryCategorieDetails;
        this.categorieDetailsStage = GetCategorieDetailsStage.DONE;
        notifyListeners();
      } else {
        print('D');
        _CategorieDetails=[];
        this.categorieDetailsStage = GetCategorieDetailsStage.ERROR;
        notifyListeners();
      }
    } catch (e) {
      this.categorieDetailsStage = GetCategorieDetailsStage.ERROR;
      notifyListeners();
      print(e);
      throw e;
    }
  }

  GetPopularCategoriesStageStage allPopularCategoriesStage;
  List<PopularCategories> _allPopularCategories=[];

  List<PopularCategories> get getAllPopularCategories => _allPopularCategories;

  Future<void> getAllPopularCategoriesFunction(
      {context, locale,bool enableNotify=false}) async {
    this.allPopularCategoriesStage = GetPopularCategoriesStageStage.LOADING;
    if(enableNotify){
      notifyListeners();
    }
    String url = '$domain/api/popular-categories';
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
       print(responseJson['data']);
      if (response.statusCode == 200 && responseJson["status"] == true) {
        if (responseJson['data'] != null) {
          _allPopularCategories = <PopularCategories>[];
          responseJson['data'].forEach((v) {
            _allPopularCategories.add( PopularCategories.fromJson(v));
          });
        }
         print(
            _allPopularCategories.length.toString());
        this.allPopularCategoriesStage = GetPopularCategoriesStageStage.DONE;
        notifyListeners();
      } else {
        print('D');
        this.allPopularCategoriesStage = GetPopularCategoriesStageStage.ERROR;
        var errors = responseJson['message'];
        showAlertDialog(context, content: '$errors');
        notifyListeners();
      }
    } catch (e) {
      this.allPopularCategoriesStage = GetPopularCategoriesStageStage.ERROR;
      notifyListeners();
      print(e);
      throw e;
    }
  }


  GetSomeBestSellingStage someBestSellingStage;
  List<SomeBestSelling> _someBestSelling=[];

  List<SomeBestSelling> get getSomeBestSelling => _someBestSelling;

  Future<void> getSomeBestSellingFunction({context, locale}) async {
    this.someBestSellingStage = GetSomeBestSellingStage.LOADING;
  //  notifyListeners();
    String url = '$domain/api/some-best-selling';
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
        if (responseJson['data'] != null) {
          _someBestSelling = <SomeBestSelling>[];
          responseJson['data'].forEach((v) {
            _someBestSelling.add(SomeBestSelling.fromJson(v));
          });
        }else{
          _someBestSelling = [];
        }
         print(_someBestSelling.length.toString());
        this.someBestSellingStage = GetSomeBestSellingStage.DONE;
        notifyListeners();
      } else {
        print('D');
        this.someBestSellingStage = GetSomeBestSellingStage.ERROR;
        var errors = responseJson['message'];
        showAlertDialog(context, content: '$errors');
        notifyListeners();
      }
    } catch (e) {
      this.someBestSellingStage = GetSomeBestSellingStage.ERROR;
      notifyListeners();
      print(e);
      throw e;
    }
  }

  GetAllBestSellingStage allBestSellingStage;
  AllBestSelling _allBestSelling;

  AllBestSelling get getAllBestSelling => _allBestSelling;

  Future<void> getAllBestSellingFunction({context, locale}) async {
    this.allBestSellingStage = GetAllBestSellingStage.LOADING;
    String url = '$domain/api/all-best-selling';
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
          _allBestSelling = AllBestSelling.fromJson(responseJson['data']);
         print(_allBestSelling.bestSellingContent.length.toString());
        this.allBestSellingStage = GetAllBestSellingStage.DONE;
        notifyListeners();
      } else {
        print('D');
        this.allBestSellingStage = GetAllBestSellingStage.ERROR;
        var errors = responseJson['message'];
        showAlertDialog(context, content: '$errors');
        notifyListeners();
      }
    } catch (e) {
      this.allBestSellingStage = GetAllBestSellingStage.ERROR;
      notifyListeners();
      print(e);
      throw e;
    }
  }

  GetAllOrdersStage allOrdersStage;
  List<AllOrders> _allOrders=[];
  List<AllOrders> get getAllOrders => _allOrders;

  Future<void> getAllOrdersFunction({context, locale}) async {
    this.allOrdersStage = GetAllOrdersStage.LOADING;
    String url = '$domain/api/user/orders';
    await getUserToken();
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
      print(responseJson);
      if (response.statusCode == 200 && responseJson["status"] == true) {
        if (responseJson['data'] != null) {
          _allOrders = <AllOrders>[];
          responseJson['data']['data'].forEach((v) {
        _allOrders.add( AllOrders.fromJson(v));
      });
    }
        print(_allOrders.length.toString());
        this.allOrdersStage = GetAllOrdersStage.DONE;
        notifyListeners();
      } else {
        print('D');
        this.allOrdersStage = GetAllOrdersStage.ERROR;
        var errors = responseJson['message'];
        showAlertDialog(context, content: '$errors');
        notifyListeners();
      }
    } catch (e) {
      this.allOrdersStage = GetAllOrdersStage.ERROR;
      notifyListeners();
      print(e);
      throw e;
    }
  }


  GetOrderDetailsStage orderDetailsStage;
  List<OrderDetails> _orderDetails=[];
  List<OrderDetails> get getOrderDetails => _orderDetails;
  Future<void> getOrderDetailsFunction({context, locale,int idOfOrder}) async {
    this.orderDetailsStage = GetOrderDetailsStage.LOADING;
    String url = '$domain/api/user/orders/$idOfOrder';
    await getUserToken();
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
      print(responseJson);
      if (response.statusCode == 200 && responseJson["status"] == true) {
        if (responseJson['data'] != null) {
          _orderDetails = <OrderDetails>[];
          responseJson['data'].forEach((v) {
            _orderDetails.add( OrderDetails.fromJson(v));
      });
    }
        print(_orderDetails.length.toString());
        this.orderDetailsStage = GetOrderDetailsStage.DONE;
        notifyListeners();
      } else {
        print('D');
        this.orderDetailsStage = GetOrderDetailsStage.ERROR;
        var errors = responseJson['message'];
        showAlertDialog(context, content: '$errors');
        notifyListeners();
      }
    } catch (e) {
      this.orderDetailsStage = GetOrderDetailsStage.ERROR;
      notifyListeners();
      print(e);
      throw e;
    }
  }

  int _focusOnSpecificWidget = 1;

  int get focusOnSpecificWidget => _focusOnSpecificWidget;
  focusOnSpecificWidgetFunction(index,_){
  print('cdfhj');
  print(index);
  _focusOnSpecificWidget = index;
   notifyListeners();
}

  GetSettingInformationStage settingInformationStage;
  static SettingInformation _settingInformation;

  SettingInformation get getSettingInformation => _settingInformation;

  Future<void> getSettingInformationFunction({context, locale,bool enableNotify=false}) async {
    if(_settingInformation == null){
      if(enableNotify == true){
        this.settingInformationStage = GetSettingInformationStage.LOADING;
        notifyListeners();
      }
      String url = '$domain/api/setting';
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'api_password': apiPassword,
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
        print('Iam');
        print(responseJson);
        if (response.statusCode == 200 && responseJson["status"] == true) {
          if (responseJson['data'] != null) {
            _settingInformation = SettingInformation.fromJson(responseJson['data']);
          }
          print(_settingInformation.areas.length.toString());
          if(enableNotify == true){
            this.settingInformationStage = GetSettingInformationStage.DONE;
            notifyListeners();
          }
        } else {
          print('D');
          var errors = responseJson['message'];
          showAlertDialog(context, content: '$errors');
          if(enableNotify == true){
            this.settingInformationStage = GetSettingInformationStage.ERROR;
            notifyListeners();
          }
        }
      } catch (e) {
        if(enableNotify == true){
          this.settingInformationStage = GetSettingInformationStage.ERROR;
          notifyListeners();
        }
        print(e);
        throw e;
      }
    }
  }
}
