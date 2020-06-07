/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-06 17:29:56
 * @LastEditors: leo
 * @LastEditTime: 2020-06-06 17:32:41
 */ 

import 'package:flutter/material.dart';

enum ViewState {Loading, Success, Failure }

class BaseProvider extends ChangeNotifier {
  ViewState _state = ViewState.Loading;

  ViewState get state => _state;

  setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
