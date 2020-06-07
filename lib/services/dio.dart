/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 01:39:03
 * @LastEditors: leo
 * @LastEditTime: 2020-06-05 13:32:39
 */ 
// http请求
import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:github_app/services/interceptors/log_interceptor.dart';
import 'package:github_app/services/interceptors/response_interceptor.dart';
import 'package:github_app/services/interceptors/token_interceptor.dart';
import 'package:github_app/services/result_data.dart';

// http请求
class HttpManager {
  // content-type
  static const CONTENT_TYPE_JSON = 'application/json';
  static const CONTENT_TYPE_FORM = 'application/x-www-form-urlencoded';

  Dio _dio = Dio();

  final TokenInterceptor _tokenInterceptor = TokenInterceptor();
  HttpManager() {
    _dio.interceptors.add(_tokenInterceptor);
    _dio.interceptors.add(LogsInterceptor());
    _dio.interceptors.add(ResponseInterceptor());
  }
  
  /// 发起网络请求
  /// [url] 请求url
  /// [params] 请求参数
  /// [header] 外加头
  /// [option] 配置
  Future<ResultData> netFetch(
    url,
    params,
    Map<String, dynamic>header,
    Options option,
    {noTip = false}
  ) async {
    Map<String, dynamic> headers = HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = Options(method: 'get');
      option.headers = headers;
    }
    Response response;
    try {
      if (option.method == 'get') {
        response = await _dio.request(url, queryParameters: params, options: option);
      } else {
        print('option==============${option.method}');
        response = await _dio.request(url, data: params, options: option);
      }
    } on DioError catch (e) {
      
    }
    if (response.data is DioError) {

    }
    return response.data;
  }

    ///清除授权
  clearAuthorization() {
    _tokenInterceptor.clearAuthorization();
  }

  ///获取授权token
  getAuthorization() async {
    return _tokenInterceptor.getAuthorization();
  }
}
final HttpManager httpManager = HttpManager();
