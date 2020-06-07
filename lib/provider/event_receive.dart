/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 21:41:01
 * @LastEditors: leo
 * @LastEditTime: 2020-06-06 22:13:49
 */ 

import 'package:flutter/material.dart';
import 'package:github_app/config/config.dart';
import 'package:github_app/models/event.dart';
import 'package:github_app/services/address.dart';
import 'package:github_app/services/dio.dart';
import 'package:github_app/services/result_data.dart';

class EventReceiveProvider extends ChangeNotifier {
  List<Event> eventList = [];
  List<Event> strredEventList = [];
  // 获取事件列表
  getEventReceiveList(String userName, {page = 1, bool needDb = false}) async {
    if (userName == null) {
      return null;
    }
    String url = Address.getEventReceived(userName);
    print('--------------结果$url');
    var res = await httpManager.netFetch(url, {'page': page, 'pre_page': Config.PAGE_SIZE}, null, null);
    print('--------------结果$res');
    if (res != null && res.result) {
      var data = res.data;
      if (data == null || data.length == 0) {
        return null;
      }
      getEventList(data);
      return data;
    }
    return null;
  }

  // 获取得到事件的列表
  getEventList (List list) {
    for (var i = 0; i < list.length; i++) {
      eventList.add(Event.fromJson(list[i]));
    }
    notifyListeners();
  }

  // 用户行为事件
  getStarredEventList(String userName, {page = 1}) async{
    try {
      var res = await httpManager.netFetch(
        Address.getEvent(userName),
        {'page': page},
        null,
        null
      );
      if (res != null && res.result) {
        setStrredEventList(res.data);
      }
      return res;
    } catch (e) {
      print(e);
    }
  }

  // 设置行为事件
  setStrredEventList (List list) {
    strredEventList = [];
    for (var i = 0; i < list.length; i++) {
      strredEventList.add(Event.fromJson(list[i]));
    }
    notifyListeners();
  }
}
