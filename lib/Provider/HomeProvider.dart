// ignore_for_file: file_names, unnecessary_this, unnecessary_string_interpolations, use_rethrow_when_possible, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:eaudemilano/Helper/Helper.dart';
import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Models/AllBestSellingModel.dart';
import 'package:eaudemilano/Models/AllCategoriesModel.dart';
import 'package:eaudemilano/Models/CategorieDetails.dart';
import 'package:eaudemilano/Models/CategorieDetails.dart';
import 'package:eaudemilano/Models/CategorieDetails.dart';
import 'package:eaudemilano/Models/CategorieDetails.dart';
import 'package:eaudemilano/Models/PopularCategoriesModel.dart';
import 'package:eaudemilano/Models/SomeBestSellingModel.dart';
import 'package:flutter/material.dart';

import '../main.dart';

enum GetAllCategoriesStage { ERROR, LOADING, DONE }
enum GetCategorieDetailsStage { ERROR, LOADING, DONE }
enum GetPopularCategoriesStageStage { ERROR, LOADING, DONE }
enum GetSomeBestSellingStage { ERROR, LOADING, DONE }
enum GetAllBestSellingStage { ERROR, LOADING, DONE }

class HomeProvider extends ChangeNotifier {
  String token = '';

  Future<void> getUserToken() async {
    if (token == '') {
      token = Helper.token ?? await Helper.getUserTokenInSharedPreferences();
    }
  }
Future<void> getHomeData({context,locale})async{
  getAllCategoriesFunction(context: context,locale: locale);
  getPopularCategoriesFunction(context: context,locale: locale);
  getSomeBestSellingFunction(context: context,locale: locale);
}
  GetAllCategoriesStage AllCategoriesStage;
  AllCategories _allCategories;

  AllCategories get getAllCategories => _allCategories;

  Future<void> getAllCategoriesFunction({context, locale}) async {
    this.AllCategoriesStage = GetAllCategoriesStage.LOADING;
    notifyListeners();
    String url = '$domain/api/categories';
    await getUserToken();
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'api_password': apiPassword,
      'Authorization': token,
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
      debugPrint(responseJson);
      if (response.statusCode == 200 && responseJson["status"] == true) {
        _allCategories = AllCategories.fromJson(responseJson);
        debugPrint(_allCategories.categories.length.toString());
        this.AllCategoriesStage = GetAllCategoriesStage.DONE;
        notifyListeners();
      } else {
        print('D');
        this.AllCategoriesStage = GetAllCategoriesStage.ERROR;
        var errors = responseJson['message'];
        showAlertDialog(context, content: '$errors');
        notifyListeners();
      }
    } catch (e) {
      this.AllCategoriesStage = GetAllCategoriesStage.ERROR;
      notifyListeners();
      print(e);
      throw e;
    }
  }

  GetCategorieDetailsStage categorieDetailsStage;
  CategorieDetails _CategorieDetails;

  CategorieDetails get getCategorieDetails => _CategorieDetails;

  Future<void> getCategorieDetailsFunction({context, locale, String id}) async {
    this.categorieDetailsStage = GetCategorieDetailsStage.LOADING;
    notifyListeners();
    String url = '$domain/api/categories/$id';
    await getUserToken();
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'api_password': apiPassword,
      'Authorization': token,
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
      debugPrint(responseJson);
      if (response.statusCode == 200 && responseJson["status"] == true) {
        _CategorieDetails =
            CategorieDetails.fromJson(responseJson['data']['data']);
        debugPrint(_allCategories.categories.length.toString());
        this.categorieDetailsStage = GetCategorieDetailsStage.DONE;
        notifyListeners();
      } else {
        print('D');
        this.categorieDetailsStage = GetCategorieDetailsStage.ERROR;
        var errors = responseJson['message'];
        showAlertDialog(context, content: '$errors');
        notifyListeners();
      }
    } catch (e) {
      this.categorieDetailsStage = GetCategorieDetailsStage.ERROR;
      notifyListeners();
      print(e);
      throw e;
    }
  }

  GetPopularCategoriesStageStage popularCategoriesStage;
  AllPopularCategories _allPopularCategories;

  AllPopularCategories get getPopularCategories => _allPopularCategories;

  Future<void> getPopularCategoriesFunction(
      {context, locale}) async {
    this.popularCategoriesStage = GetPopularCategoriesStageStage.LOADING;
    notifyListeners();
    String url = '$domain/api/popular-categories';
    await getUserToken();
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'api_password': apiPassword,
      'Authorization': token,
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
      debugPrint(responseJson);
      if (response.statusCode == 200 && responseJson["status"] == true) {
        _allPopularCategories =
            AllPopularCategories.fromJson(responseJson['data']);
        debugPrint(
            _allPopularCategories.allPopularCategories.length.toString());
        this.popularCategoriesStage = GetPopularCategoriesStageStage.DONE;
        notifyListeners();
      } else {
        print('D');
        this.popularCategoriesStage = GetPopularCategoriesStageStage.ERROR;
        var errors = responseJson['message'];
        showAlertDialog(context, content: '$errors');
        notifyListeners();
      }
    } catch (e) {
      this.popularCategoriesStage = GetPopularCategoriesStageStage.ERROR;
      notifyListeners();
      print(e);
      throw e;
    }
  }

  GetSomeBestSellingStage someBestSellingStage;
  List<SomeBestSelling> _someBestSelling;

  List<SomeBestSelling> get getSomeBestSelling => _someBestSelling;

  Future<void> getSomeBestSellingFunction({context, locale, String id}) async {
    this.someBestSellingStage = GetSomeBestSellingStage.LOADING;
    notifyListeners();
    String url = '$domain/api/some-best-selling';
    await getUserToken();
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'api_password': apiPassword,
      'Authorization': token,
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
      debugPrint(responseJson);
      if (response.statusCode == 200 && responseJson["status"] == true) {
        if (responseJson['data'] != null) {
          _someBestSelling = <SomeBestSelling>[];
          responseJson['data'].forEach((v) {
            _someBestSelling.add(SomeBestSelling.fromJson(v));
          });
        }
        debugPrint(_someBestSelling.length.toString());
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
  List<AllBestSelling> _allBestSelling;

  List<AllBestSelling> get getAllBestSelling => _allBestSelling;

  Future<void> getAllBestSellingFunction({context, locale, String id}) async {
    this.allBestSellingStage = GetAllBestSellingStage.LOADING;
    notifyListeners();
    String url = '$domain/api/some-best-selling';
    await getUserToken();
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'api_password': apiPassword,
      'Authorization': token,
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
      debugPrint(responseJson);
      if (response.statusCode == 200 && responseJson["status"] == true) {
        if (responseJson['data'] != null) {
          _allBestSelling = <AllBestSelling>[];
          responseJson['data'].forEach((v) {
            _allBestSelling.add(AllBestSelling.fromJson(v));
          });
        }
        debugPrint(_allBestSelling.length.toString());
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
}
