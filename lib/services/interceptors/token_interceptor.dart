/*
 * @Description: Token 拦截器
 * @Author: leo
 * @Date: 2020-06-03 01:47:01
 * @LastEditors: leo
 * @LastEditTime: 2020-06-03 02:08:00
 */ 

import 'package:dio/dio.dart';
import 'package:github_app/config/config.dart';
import 'package:github_app/local/local_storage.dart';

class TokenInterceptor extends InterceptorsWrapper {
  String _token;

  // 授权码
  @override
  Future onRequest(RequestOptions options) async {
    // TODO: implement onRequest
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
      }
    }
    options.headers['Authorization'] = _token;
    return options;
  }

  @override
  Future onResponse(Response response) async {
    try {
      var responseJson = response.data;
      if (response.statusCode == 201 && responseJson['token'] != null) {
        _token = 'token ' + responseJson['token'];
        await LocalStorage.save(Config.TOKEN_KEY, _token);
      }
    } catch (e) {
      print(e);
    }
    return response;
  }
  // 清除授权
  clearAuthorization() {
    _token = null;
    LocalStorage.remove(Config.TOKEN_KEY);
    
  }
  // 获取授权token
  Future getAuthorization() async {
    String token = await LocalStorage.get(Config.TOKEN_KEY);
    if (token == null) {
      String basic = await LocalStorage.get(Config.USER_BASIC_CODE);
      if (basic == null) {
        // 提示输入账号密码
      } else {
        // 通过basic 去获取token,获取到设置，返回token
        return 'Basic $basic';
      }
    } else {
      _token = token;
      return token;
    }
  }
}
