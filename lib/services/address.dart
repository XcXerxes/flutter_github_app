/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 11:18:15
 * @LastEditors: leo
 * @LastEditTime: 2020-06-10 20:16:34
 */ 

// 所有的接口地址
import 'package:github_app/config/config.dart';

class Address {
  static const String host = "https://api.github.com";
  // 获取趋势的api
  static const String hostWeb = "https://ghapi.huchen.dev";
  // 获取个人动态的 图表
  static const String graphicHost = 'https://ghchart.rshah.org';
  static const String updateUrl = 'https://www.pgyer.com/guqa';
  static getUri(url, {Map data}) {
    return Uri.https(host, url, data).toString();
  }
  // 获取授权
  static getAuthorization() {
    return '$host/authorizations';
  }

  // 全局搜索 GET
  static search(q, sort, order, type, int page, [int pageSize = Config.PAGE_SIZE]) {
    if (type == 'user') {
      return getUri('/search/users', data: {
        'q': q,
        'page': page,
        'per_page': pageSize
      });
      sort ??= 'best%20match';
      order ??= 'desc';
      page ??= 1;
      pageSize ??= Config.PAGE_SIZE;

      return getUri('/search/repositories', data: {
        'q': q,
        'sort': sort,
        'order': order,
        'page': page,
        'per_page': pageSize
      });
    }
  }

  // 用户收到的事件信息 GET
  static getEventReceived(String userName) {
    return '$host/users/$userName/received_events';
  }

  // 用户相关的事件信息
  static getEvent(userName) {
    return '$host/users/$userName/events';
  }
  // 当前登录用户的信息
  static getMyUserInfo() {
    return '$host/user';
  }
  // 根据用户名获取用户信息 GET
  static getUserInfo(userName) {
    return '$host/users/$userName';
  }

  // 用户的仓库列表 get
  static userRepos(userName) {
    return '$host/users/$userName/repos';
  }

  /// 仓库的详情
  static userRepoDetail(String userName , String repo) {
    return '$host/repos/$repo';
  }

  ///仓库活动 get
  static getReposEvent(reposName) {
    return "$host/repos/$reposName/events";
  }
  ///仓库活动 get
  static getReposCommit(reposName) {
    return "$host/repos/$reposName/commits";
  }
  /// readme 内容
  static getReposReadme(reposName) {
    return "$host/repos/$reposName/readme";
  }
  /// repo 的issue 列表
  static getReposIssueList(reposName) {
    return "$host/repos/$reposName/issues";
  }

  /// repo 的 文件列表
  static getReposFileList(reposName) {
    return "$host/repos/$reposName/contents";
  }
  /// repo 的目录
  static reposFileDir(reposName, path) {
    return '$host/repos/$reposName/contents/$path';
  }
  // 获取趋势列表
  static getTrendList() {
    return '$hostWeb/repositories';
  }
  // 自己个人动态 关注
  static myStarred() {
    return '$host/users/starred';
  }
  // 用户 个人动态 关注的
  static userStarred(String userName) {
    return '$host/users/$userName/starred';
  }
  /// 获取得到用户的个人动态图表
  static String getUserChartAddress(String userName) {
    return '$graphicHost/b37feb/$userName';
  }

  ///用户的粉丝 get
  static getUserFollower(userName) {
    return "$host/users/$userName/followers";
  }
  /// 用户关注的 get
  static getUserFollow(userName) {
    return "$host/users/$userName/following";
  }
  /// 搜索repo tag 主题
  static searchRepo(String searchValue) {
    return '$host/search/repositories';
  }
}
