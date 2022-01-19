// ignore_for_file: file_names, unnecessary_this, unnecessary_string_interpolations, use_rethrow_when_possible, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'package:dio/dio.dart';
import 'package:eaudemilano/Helper/Helper.dart';
import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Models/AllBestSellingModel.dart';
import 'package:eaudemilano/Models/AllProductsInCartModel.dart';
import 'package:eaudemilano/Models/SearchModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import 'FavouriteProvider.dart';

enum GetSearchResultStage { ERROR, LOADING, DONE }

class SearchProvider extends ChangeNotifier {
//  bool enableWriteInSearch = false;
  GetSearchResultStage searchResultStage;
  List<SearchModel> _searchResult=[];
  String _searchKey='';
  List<SearchModel> get getSearchResult => _searchResult;
  Future<void> getSearchResultFunction({context, locale,String text}) async {

    if(_searchKey != text){
      this.searchResultStage = GetSearchResultStage.LOADING;
      notifyListeners();
      String url = '$domain/api/search?key=$text';
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'api_password': apiPassword,
        'language': locale.toString()
      };
      _searchKey = text;
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
            _searchResult = <SearchModel>[];
            responseJson['data'].forEach((v) {
              _searchResult.add(SearchModel.fromJson(v));
            });
          }else{
            _searchResult = [];
          }

          this.searchResultStage = GetSearchResultStage.DONE;
          notifyListeners();
        } else {
          this.searchResultStage = GetSearchResultStage.ERROR;
          var errors = responseJson['message'];
          // showAlertDialog(context, content: '$errors');
          _searchResult = [];
          notifyListeners();
        }
      } catch (e) {
        this.searchResultStage = GetSearchResultStage.ERROR;
        _searchResult = [];
        notifyListeners();
        throw e;
      }
    }
  }
  resetSearchResult(){
    _searchResult=[];
    notifyListeners();
  }
// enableWriteInSearchFunction(){
//    print('cxcxvc');
//  enableWriteInSearch = true;
//  notifyListeners();
//
//}
//  disableWriteInSearchFunction(){
//    print('cdgrtgc');
//    _searchResult=[];
//    enableWriteInSearch = false;
//  }
}
