/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 02:11:13
 * @LastEditors: leo
 * @LastEditTime: 2020-06-03 21:25:08
 */ 

import 'package:dio/dio.dart';
import 'package:github_app/services/code.dart';
import 'package:github_app/services/result_data.dart';

class ResponseInterceptor extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    RequestOptions option = response.request;
    var value;
    try {
      var header = response.headers[Headers.contentTypeHeader];
      if (header != null && header.toString().contains('text')) {
        value = ResultData(
          response.data,
          true,
          Code.SUCCESS
        );
      } else if (response.statusCode >= 200 && response.statusCode < 300) {
        value = ResultData(
          response.data,
          true,
          Code.SUCCESS,
          headers: response.headers
        );
      }
    } catch (e) {
      print(e.toString() + option.path);
      value = ResultData(
        response.data,
        false,
        response.statusCode,
        headers: response.headers
      );
    }
    // TODO: implement onResponse
    return value;
  }
}
