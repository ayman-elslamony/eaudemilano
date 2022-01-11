// ignore_for_file: file_names, unnecessary_this, unnecessary_string_interpolations, use_rethrow_when_possible, non_constant_identifier_names, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:eaudemilano/Helper/components.dart';
import 'package:eaudemilano/Screens/intoScreen/LoginScreen.dart';
import 'package:eaudemilano/Screens/mainScreen/NavigationHome.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:eaudemilano/Helper/Helper.dart';
import 'package:eaudemilano/Localization/app_localizations.dart';
import 'package:eaudemilano/main.dart';

//import 'package:eaudemilano/models/Product.dart';
//import 'package:eaudemilano/screens/IntroScreens/Login.dart';
//import 'package:eaudemilano/screens/IntroScreens/Verification.dart';
//import 'package:eaudemilano/screens/MainScreens/NavigationHome.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum UserDataProviderStage { ERROR, LOADING, DONE }

class UserDataProvider extends ChangeNotifier {
  UserDataProviderStage stage;
  UserDataProviderStage favouritesStage;
  String errorMessage = "Network Error";

  // get user Data From Shared Preferences

  Future getUserData() async {

    Helper.is_loggedIn = await Helper.getUserLoggedInSharedPreferences();
    Helper.userId = await Helper.getUserIdInSharedPreferences();
    Helper.userName = await Helper.getUsernameInSharedPreferences();
    Helper.userEmail = await Helper.getUserEmailInSharedPreferences();
    Helper.userPhone = await Helper.getUserPhoneInSharedPreferences();
    Helper.token = await Helper.getUserTokenInSharedPreferences();
    Helper.status = await Helper.getUserStatusInSharedPreferences();
//    Helper.is_active = await Helper.getUserIsActiveInSharedPreferences();
//    Helper.is_verified = await Helper.getUserIsVerifiedInSharedPreferences();
//    Helper.confirmation_code = await Helper.getConfirmationCodeInSharedPreferences();
  }

// Login Request
  Future<void> login({context, locale, email, password,fcmToken}) async {
    this.stage = UserDataProviderStage.LOADING;
      notifyListeners();
    String url = '$domain/api/login';

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'api_password': apiPassword,
      'language': locale.toString()
    };
    var formData = FormData.fromMap({
      'email': email,
      'password': password,
      'token': "$fcmToken",
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
        Helper.saveUserLoggedInSharedPreferences(true);
        Helper.saveUserIdInSharedPreferences(responseJson["user"]["id"]);
        Helper.saveUsernameInSharedPreferences(responseJson["user"]["name"]);
        Helper.saveUserEmailInSharedPreferences(responseJson["user"]["email"]);
        Helper.saveUserStatusInSharedPreferences(responseJson["user"]["status"]);
        Helper.saveUserPhoneInSharedPreferences(responseJson["user"]["mobile"]);
        Helper.saveUserTokenInSharedPreferences(responseJson["user"]["api_token"]);
        await Provider.of<UserDataProvider>(context, listen: false).getUserData();
        navigateAndFinish(context, NavigationHome());
        this.stage = UserDataProviderStage.DONE;
        notifyListeners();
      } else {
        print('D');
        this.stage = UserDataProviderStage.ERROR;
        var errors = responseJson['message'];
//        var errors = responseJson['errors']??responseJson['message'];
//
//        String finalError = '';
//        if (responseJson['errors']!=null) {
//          errors.forEach((key, errors) {
//            finalError += "${responseJson['errors']!=null ? errors[0] : errors}\n\n";
//          });
//        }
//        showAlertDialog(context, content: finalError==''?'${errors}':"${finalError}");
        showAlertDialog(context,
            content: '$errors' );
        notifyListeners();
        notifyListeners();
      }
     } catch (e) {
       this.stage = UserDataProviderStage.ERROR;
       notifyListeners();
       print(e);
       throw e;
     }
  }



// Register Request
  Future<void> register({
    context,
    locale,
    name,
    email,
    phone,
    password,
    password_confirmation,
    fcmToken,
  }) async {
    this.stage = UserDataProviderStage.LOADING;
    notifyListeners();
    String url = '$domain/api/register';

    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'api_password': apiPassword,
      'language': locale.toString()
    };

    var formData = FormData.fromMap({
      'name': name,
      'email': email,
      'mobile': phone,
      'password': password,
      'password_confirmation': password_confirmation,
      'fcm_token': fcmToken,
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


        Helper.saveUserLoggedInSharedPreferences(true);
        Helper.saveUserIdInSharedPreferences(
            responseJson['user']["id"]);
        Helper.saveUsernameInSharedPreferences(
            responseJson['user']["name"]);
        Helper.saveUserEmailInSharedPreferences(
            responseJson['user']["email"]);
        Helper.saveUserStatusInSharedPreferences(
            responseJson['user']["status"]);
        Helper.saveUserPhoneInSharedPreferences(
            responseJson['user']["mobile"]);
        Helper.saveUserTokenInSharedPreferences(
            responseJson['user']["api_token"]);

        await Provider.of<UserDataProvider>(context, listen: false)
            .getUserData();

        navigateAndFinish(context, NavigationHome());

        //          .then((value) {
//        if (responseJson["data"]['user']["is_verified"] == true) {
//          Navigator.push(
//              context, MaterialPageRoute(builder: (context) => NavigationHome()));
//        }
//        else{
//          Navigator.push(
//              context, MaterialPageRoute(builder: (context) => Verification(verificationCode: responseJson["data"]["verification_code"],token: responseJson["data"]["api_token"],)));
//        }
//      });

        this.stage = UserDataProviderStage.DONE;
        notifyListeners();
      } else {
        print('D');
        this.stage = UserDataProviderStage.ERROR;
        var errors = responseJson['message'];
//        String finalError = '';
//        if (responseJson['errors'] != null) {
//          errors.forEach((key, errors) {
//            finalError +=
//                "${responseJson['errors'] != null ? errors[0] : errors}\n\n";
//          });
//        }
        showAlertDialog(context,
            content: '$errors' );
        notifyListeners();
      }
    } catch (e) {
      this.stage = UserDataProviderStage.ERROR;
      notifyListeners();
      print(e);
      throw e;
    }

  }

// Logout
  logout({context, locale,}) async {
    this.stage = UserDataProviderStage.LOADING;


    String url = '$domain/api/logout';
    var token = Helper.token;
    if(token.isEmpty) {
      token = await Helper.getUserTokenInSharedPreferences();
    }
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'api_password': apiPassword,
      'language': locale.toString()
    };
    var formData = FormData.fromMap({
      'token': token,
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
      SharedPreferences prefs= await SharedPreferences.getInstance();
      if (response.statusCode == 200 && responseJson['status'] == true) {
        await prefs.clear();
        this.stage = UserDataProviderStage.DONE;
        navigateAndFinish(context,LoginScreen());
      } else {

        await prefs.clear();
        this.stage = UserDataProviderStage.DONE;
        navigateAndFinish(context,LoginScreen());

//        var errors = responseJson['errors'];
//        var _list = errors.values.toList();
//        String finalError = '';
//        errors.forEach((key, errors) {
//          finalError += "${errors[0]}\n\n";
//        });
//        showAlertDialog(context, content: "${finalError}");
      }
    } catch (e) {
      this.stage = UserDataProviderStage.ERROR;
      notifyListeners();
      print(e);
      throw e;
    }
    notifyListeners();
  }
//
//// Forgot password Request
//  forgetPassword({context, locale,phone, scaffoldKey}) async {
//    this.stage = UserDataProviderStage.LOADING;
//    String url = '$domain/api/v1/customers/forget-password?phone=$phone';
//
//
//    Map<String, String> headers = {
//      'X-localization' : locale
//    };
//
//    try {
//      http.Response response =
//      await http.patch(Uri.parse(url), headers: headers);
//      var responseJson = json.decode(response.body);
//      print(responseJson);
//      if (response.statusCode == 200 && responseJson['status'] == true) {
//        showSnack(
//            context: context,
//            msg: responseJson['message'],
//            fullHeight: 30.0,
//            color: Theme.of(context).primaryColor,
//            isFloating: true,
//            scaffoldKey: scaffoldKey);
//        Timer(const Duration(milliseconds: 5000), (){
//          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()), (route) => false);
//        });
//        this.stage = UserDataProviderStage.DONE;
//      } else {
//        this.stage = UserDataProviderStage.ERROR;
//        var errors = responseJson['errors'];
//        var _list = errors.values.toList();
//        String finalError = '';
//        errors.forEach((key, errors) {
//          finalError += "${errors[0]}\n\n";
//        });
//        showAlertDialog(context, content: "$finalError");
//      }
//    } catch (e) {
//      this.stage = UserDataProviderStage.ERROR;
//      debugPrint(e.toString());
//      throw e;
//    }
//    notifyListeners();
//  }
//
//// Reset Password
//  resetPassword(
//      {context,
//        locale,
//        password,
//        password_confirmation,
//        scaffoldKey}) async {
//    this.stage = UserDataProviderStage.LOADING;
//    String url = '${domain}/api/v1/customers/reset-password?password=$password&password_confirmation=$password_confirmation';
//
//
//    Map<String, String> headers = {
//      'X-localization': '$locale',
//    };
//
//    try {
//      http.Response response =
//      await http.patch(Uri.parse(url), headers: headers);
//      var responseJson = json.decode(response.body);
//      if (response.statusCode == 200 && responseJson['status'] == true) {
//        // showSnack(
//        //     context: context,
//        //     msg: '${responseJson['message']}',
//        //     fullHeight: 30.0,
//        //     isFloating: true,
//        //     scaffKey: scaffoldKey,
//        //     color: Theme.of(context).primaryColor
//        // );
//
//        // Timer(Duration(milliseconds: 2000), (){
//        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
//        // });
//        this.stage = UserDataProviderStage.DONE;
//      } else {
//        var errors = responseJson['errors'];
//        var _list = errors.values.toList();
//        String finalError = '';
//        errors.forEach((key, errors) {
//          finalError += "${errors[0]}\n\n";
//        });
//        showAlertDialog(context, content: "${finalError}");
//      }
//    } catch (e) {
//      this.stage = UserDataProviderStage.ERROR;
//      print(e);
//      throw e;
//    }
//    notifyListeners();
//  }
//
//
//// Change Password
//  changePassword(
//      {context,
//        locale,
//        old_password,
//        new_password,
//        new_password_confirmation,
//        scaffoldKey}) async {
//    this.stage = UserDataProviderStage.LOADING;
//    String url = '${domain}/api/v1/customers/update-password?old_password=$old_password&new_password=$new_password&new_password_confirmation=$new_password_confirmation';
//
//
//    Map<String, String> headers = {
//      'X-localization': '$locale',
//    };
//
//    try {
//      http.Response response =
//      await http.patch(Uri.parse(url), headers: headers);
//      var responseJson = json.decode(response.body);
//      if (response.statusCode == 200 && responseJson['status'] == true) {
//        // showSnack(
//        //     context: context,
//        //     msg: '${responseJson['message']}',
//        //     fullHeight: 30.0,
//        //     isFloating: true,
//        //     scaffKey: scaffoldKey,
//        //     color: Theme.of(context).primaryColor
//        // );
//
//        // Timer(Duration(milliseconds: 2000), (){
//        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
//        // });
//        this.stage = UserDataProviderStage.DONE;
//      } else {
//        var errors = responseJson['errors']??responseJson['message'];
//        String finalError = '';
//        if (responseJson['errors']!=null) {
//          var _list = errors.values.toList();
//          errors.forEach((key, errors) {
//            finalError += "${errors[0]}\n\n";
//          });
//        }
//        showAlertDialog(context, content: responseJson['errors'] == null ? "${errors}":"${finalError}");
//      }
//    } catch (e) {
//      this.stage = UserDataProviderStage.ERROR;
//      print(e);
//      throw e;
//    }
//    notifyListeners();
//  }
//
//
//
//// update User
//  Future updateUser(
//      {context,
//        locale,
//        name,
//        phone,
//        email,
//        scaffoldKey
//      }) async {
//    this.stage = UserDataProviderStage.LOADING;
//    String url = '$domain/api/v1/customers/update';
//    String photoPath;
//
//
//    // if (photo != null) {
//    //   final File pickedImage = File(photo.path);
//    //   photoPath = pickedImage.path.split('/').last;
//    // }
//
//    var formData = {
//      'name': name,
//      'email': email,
//      'phone': phone,
//      'accept_terms': true,
//      // 'photo': photo == null
//      //     ? ''
//      //     : await MultipartFile.fromFile(photo.path,
//      //     filename: photoPath),
//    };
//
//    Map<String, String> headers = {
//      'Content-Type': 'application/json',
//      'Authorization': "Bearer ${Helper.token}",
//      'Accept' : 'application/json',
//      'X-Localization': locale.toString(),
//    };
//
//    // try {
//    Dio dio = Dio();
//    Response response = await dio.put(url,
//      data: formData,
//      options: Options(
//        followRedirects: false,
//        responseType: ResponseType.bytes,
//        validateStatus: (status) {
//          return status < 500;
//        },
//        headers: headers,
//      ),
//    );
//    var responseJsonn = response.data;
//    var convertedResponse = utf8.decode(responseJsonn);
//    var responseJson = json.decode(convertedResponse);
//    print(responseJson);
//
//    if (response.statusCode == 200 && responseJson['status'] == true) {
//      this.stage = UserDataProviderStage.DONE;
//      Helper.saveUsernameInSharedPreferences(responseJson["data"]["name"]);
//      Helper.saveUserEmailInSharedPreferences(responseJson["data"]["email"]);
//      Helper.saveUserPhoneInSharedPreferences(responseJson["data"]["phone"]);
//      getUserData();
//
//      showSnack(
//          context: context,
//          msg: AppLocalizations.of(context).locale.languageCode == 'ar'?'تم تعديل البيانات بنجاح!' : 'Profile Updated Successfully!',
//          fullHeight: 30.0,
//          isFloating: true,
//          color: Theme.of(context).primaryColor,
//          scaffoldKey: scaffoldKey);
//    } else {
//      var errors = responseJson['errors']??responseJson['message'];
//      // var _list = errors.values.toList();
//      String finalError = '';
//      if (responseJson['errors'] !=null) {
//        errors.forEach((key, errors) {
//          finalError += "${errors[0]}\n\n";
//        });
//      }
//      showAlertDialog(context, content: "${finalError=='' ? errors:finalError}");
//    }
//    // } catch (e) {
//    //   this.stage = UserDataProviderStage.ERROR;
//    //   print(e);
//    //   throw e;
//    // }
//    notifyListeners();
//  }
//
//
//// resend Verification Code
//  resendVerificationCode({context, locale, userId, token}) async {
//    this.stage = UserDataProviderStage.LOADING;
//    String url = '$domain/api/v1/customers/resend-verification-code';
//
//    Map<String, String> headers = {
//      'X-localization': '$locale',
//      'X-AppApiToken': "Bearer $token",
//    };
//    try {
//      http.Response response = await http.get(Uri.parse(url), headers: headers);
//      var responseJson = json.decode(response.body);
//      if (response.statusCode == 200 && responseJson['status'] == true) {
//        this.stage = UserDataProviderStage.DONE;
//      } else {
//        var errors = responseJson['errors'];
//        var _list = errors.values.toList();
//        String finalError = '';
//        errors.forEach((key, errors) {
//          finalError += "${errors[0]}\n\n";
//        });
//        showAlertDialog(context, content: "${finalError}");
//      }
//    } catch (e) {
//      this.stage = UserDataProviderStage.ERROR;
//      print(e);
//      throw e;
//    }
//    notifyListeners();
//  }
//
//
//// verify
//  verifyUser({context, locale, email,token}) async {
//    this.stage = UserDataProviderStage.LOADING;
//
//    String url = '$domain/api/auth/verify';
//
//    var headers = {
//      'Accept': 'application/json',
//      'Content-Type': 'application/json',
//      'X-localization' : locale.toString(),
//    };
//    var formData = FormData.fromMap({
//      'email': email,
//    });
//
//
//    // try {
//    Dio dio = Dio();
//    Response<List<int>> response = await dio.post(url,
//        data: formData,
//        options: Options(
//            followRedirects: false,
//            responseType: ResponseType.bytes,
//            validateStatus: (status) => true,
//            // validateStatus: (status) {
//            //   return status < 500;
//            // },
//            headers: headers));
//    var responseJsonn = response.data;
//    var convertedResponse = utf8.decode(responseJsonn);
//    var responseJson = json.decode(convertedResponse);
//
//    print(responseJson);
//      if (response.statusCode == 200 && responseJson['success'] == true) {
//        this.stage = UserDataProviderStage.DONE;
//        Helper.saveUserIsVerifiedInSharedPreferences(responseJson["data"]["is_verified"]);
//        Helper.saveUserIsActiveInSharedPreferences(responseJson["data"]["is_active"]);
//        getUserData().then((_) => {
//        Navigator.pushNamed(context, NavigationHome.routName)
//        });
//
//      } else {
//        this.stage = UserDataProviderStage.ERROR;
//        var errors = responseJson['errors']??responseJson['message'];
//
//        String finalError = '';
//        if (responseJson['errors']!=null) {
//          errors.forEach((key, errors) {
//            finalError += "${responseJson['errors']!=null ? errors[0] : errors}\n\n";
//          });
//        }
//        showAlertDialog(context, content: finalError==''?'${errors}':"${finalError}");
//      }
//    // } catch (e) {
//    //   this.stage = UserDataProviderStage.ERROR;
//    //   print(e);
//    //   throw e;
//    // }
//    notifyListeners();
//  }

}
