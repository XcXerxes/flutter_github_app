/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-05 15:13:42
 * @LastEditors: leo
 * @LastEditTime: 2020-06-05 15:42:49
 */ 
import 'package:flutter/material.dart';
import 'package:github_app/config/config.dart';
import 'package:github_app/models/user.dart';
import 'package:github_app/services/address.dart';
import 'package:github_app/services/dio.dart';

class ProfileProvider extends ChangeNotifier {
  List<User> followerList = []; // 粉丝列表
  List<User> followingList = []; // 关注列表

  /// 粉丝列表
  getFollowerList(String userName, {page = 1}) async{
    try {
      var res = await httpManager.netFetch(
        Address.getUserFollower(userName),
        {'page': page, 'per_page': Config.PAGE_SIZE},
        null,
        null
      );
      if (res != null && res.result) {
        setFollowerList(res.data);
      }
      return res;
    } catch (e) {
      print(e);
    }
    return null;
  }

  /// 关注列表
  getFollowingList(String userName, {page = 1}) async{
    try {
      var res = await httpManager.netFetch(
        Address.getUserFollow(userName),
        {'page': page, 'per_page': Config.PAGE_SIZE},
        null,
        null
      );
      if (res != null && res.result) {
        setFollowingList(res.data);
      }
      return res;
    } catch (e) {
      print(e);
    }
    return null;
  }

  /// 设置粉丝列表
  setFollowerList(List list) {
    for (var i = 0; i < list.length; i++) {
      followerList.add(User.fromJson(list[i]));
    }
  }

  /// 设置关注列表
  setFollowingList(List list) {
    for (var i = 0; i < list.length; i++) {
      followingList.add(User.fromJson(list[i]));
    }
  }
}