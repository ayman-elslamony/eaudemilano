// ignore_for_file: file_names, unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';

class ChangeIndex with ChangeNotifier {
  int index =0;
    int current;
  void changeIndexFunction(int index) {
    this.index = index;
    notifyListeners();
  }
  void changeIndexFunctionWithOutNotify(int index) {
    this.index = index;
  }



}