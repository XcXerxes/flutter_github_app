/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-04 12:12:41
 * @LastEditors: leo
 * @LastEditTime: 2020-06-04 17:40:09
 */ 

import 'package:flutter/material.dart';
import 'package:github_app/models/trendingRepoModel.dart';
import 'package:github_app/services/address.dart';
import 'package:github_app/services/dio.dart';

class TrendProvider extends ChangeNotifier {
  List<TrendingRepoModel> trendList = [];
  String since = 'weekly'; // 筛选时间类型字段
  String languageType; // 筛选语言类型字段
  getTrendList() async{
    try {
      var res = await httpManager.netFetch(
        Address.getTrendList(),
        {'since': since, 'language': languageType},
        null,
        null
      );
      if (res != null && res.result) {
        initTrendList(res.data);
      }
      return res.data;
    } catch (e) {
      print(e);
    }
  }
  // 获取得到 trendList
  initTrendList (List list) {
    for (var i = 0; i < list.length; i++) {
      trendList.add(TrendingRepoModel.fromJson(list[i]));
    }
    notifyListeners();
  }
  
  // 设置时间类型
  changeSinceState (String _since) {
    since = _since;
    getTrendList();
  }
  // 设置语言类型
  changeLanguageState (String _language) {
    languageType = _language;
    getTrendList();
  }
}
