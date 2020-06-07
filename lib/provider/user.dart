/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 17:10:30
 * @LastEditors: leo
 * @LastEditTime: 2020-06-06 21:25:38
 */ 

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:github_app/config/config.dart';
import 'package:github_app/config/ignoreConfig.dart';
import 'package:github_app/local/local_storage.dart';
import 'package:github_app/models/user.dart';
import 'package:github_app/services/address.dart';
import 'package:github_app/services/dio.dart';

class UserProvider extends ChangeNotifier {
  User _myUserInfo;
  String _token;
  User currentUserInfo;

  login(String userName, String password) async {
    // 加密账号密码
    String type = '$userName:$password';
    var bytes = utf8.encode(type);
    var base64Str = base64.encode(bytes);

    if(Config.DEBUG) {
      print('base64str login ${base64Str}');
    }

    // 将用户名和加密的账号密码放到本地存储中
    await LocalStorage.save(Config.USER_NAME_KEY, userName);
    await LocalStorage.save(Config.USER_BASIC_CODE, base64Str);

    // 请求参数
    Map requestParams = {
      "scopes": ['user', 'repo', 'gist', 'notifications'],
      "note": "admin_script",
      "client_id": NetConfig.CLIENT_ID,
      "client_secret": NetConfig.CLIENT_SECRET
    };
    // 清除授权信息
    httpManager.clearAuthorization();

    var res = await httpManager.netFetch(
      Address.getAuthorization(),
      json.encode(requestParams),
      null,
      Options(method: 'post')
    );
    // var resultData = null;
    if(res != null && res.result) {
      await LocalStorage.save(Config.PW_KEY, password);
      await getUserInfo();
      if (Config.DEBUG) {
        print(res.data.toString());
      }
    }
    return res;
    // notifyListeners();
  }

  // 获取用户信息
  getUserInfo({userName, needDb = false}) async {
    var res;
    if (userName == null) {
      res = await httpManager.netFetch(Address.getMyUserInfo(), null, null, null);
    } else {
      res = await httpManager.netFetch(Address.getUserInfo(userName), null, null, null);
    }
    if (res != null && res.result) {
      if(userName == null) {
        myUserInfo = User.fromJson(res.data);
      } else {
        currentUserInfo = User.fromJson(res.data);
      }
    }
    return res;
  }
  // 获取个人信息
  User get myUserInfo => _myUserInfo;

  // 设置个人信息
  set myUserInfo (User user) {
    LocalStorage.save(Config.USER_INFO, json.encode(user.toJson()));
    _myUserInfo = user;
    notifyListeners();
  }

  // 初始化用户信息
  Future initUserInfo() async {
    var token = await LocalStorage.get(Config.TOKEN_KEY);
    if (token !=null) {
      await getUserInfo(); 
    }
    notifyListeners();
    return token;
  }
}
