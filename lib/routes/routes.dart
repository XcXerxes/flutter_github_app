/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 20:07:21
 * @LastEditors: leo
 * @LastEditTime: 2020-06-10 21:07:07
 */ 

import 'package:flutter/material.dart';
import 'package:github_app/page/code_detail_page_web.dart';
import 'package:github_app/page/follower/follower_page.dart';
import 'package:github_app/page/follower/following_page.dart';
import 'package:github_app/page/home/home_page.dart';
import 'package:github_app/page/introduction/introduction_page.dart';
import 'package:github_app/page/login/login_page.dart';
import 'package:github_app/page/repository/repository_page.dart';
import 'package:github_app/page/search/search_page.dart';
import 'package:github_app/page/search/search_result_page.dart';
import 'package:github_app/page/user/user_page.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/login': (context) => LoginPage(),
    '/home': (context) => HomePage(),
    '/repo': (context) => RepositoryPage(),
    '/follower': (context) => FollowerPage(),
    '/following': (context) => FollowingPage(),
    '/search': (context) => SearchPage(),
    '/search-result': (context) => SearchResultPage(ModalRoute.of(context).settings.arguments),
    '/user': (context) => UserPage(),
    '/introduction': (context) => IntroductionPage(ModalRoute.of(context).settings.arguments),
    '/code-detail': (context) => CodeDetailPageWeb(ModalRoute.of(context).settings.arguments),
  };
}
