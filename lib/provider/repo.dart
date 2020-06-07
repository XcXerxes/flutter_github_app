/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-05 12:35:32
 * @LastEditors: leo
 * @LastEditTime: 2020-06-06 19:39:08
 */ 

import 'package:flutter/material.dart';
import 'package:github_app/config/config.dart';
import 'package:github_app/models/repository.dart';
import 'package:github_app/services/address.dart';
import 'package:github_app/services/dio.dart';

class RepoProvider extends ChangeNotifier {
  /// 仓库列表
  List<Repository> repoList = [];

  /// 搜索仓库列表
  List<Repository> searchRepoList = [];
  /// 搜索条件
  SearchQueryModel searchQuery = SearchQueryModel('', 'best%20match', 'desc', null);
  /// 搜索loading
  bool searchLoading = false;
  getRepoList (String userName, {page = 1, sort = 'pushed'}) async {
    try {
      var res = await httpManager.netFetch(
        Address.userRepos(userName),
        {
          'page': page,
          'sort': sort,
          'per_page': Config.PAGE_SIZE
        },
        null, null
      );
      if (res != null && res.result) {
        setRepoList(res.data);
      }
      return res.data;
    } catch (e) {
      print(e);
    }
    return null;
  }

  setRepoList(List list) {
    for (var i = 0; i < list.length; i++) {
      repoList.add(Repository.fromJson(list[i]));
    }
    notifyListeners();
  }

  /// 搜索仓库列表
  getsearchRepoList (SearchQueryModel queryParams, {isRefresh = true}) async {
    try {
      if(queryParams.q == null || queryParams.q.isEmpty) {
        setSearchRepoList([]);
        return null;
      }
      if (isRefresh) {
        changeLoadingState(true);
      }
      var res = await httpManager.netFetch(
        Address.searchRepo(queryParams.q),
        parseQuery(queryParams),
        null,
        null
      );
      changeLoadingState(false);
      if (res != null && res.result) {
        setSearchRepoList(res.data['items']);
      }
      return res;
    } catch (e) {
      changeLoadingState(false);
    }
    return null;
  }

  /// 搜查仓库列表
  setSearchRepoList (List list) {
    if (list.length == 0) {
      searchRepoList = [];
    } else {
      searchRepoList = [];
      for (var i = 0; i < list.length; i++) {
        searchRepoList.add(Repository.fromJson(list[i]));
      }
    }
    notifyListeners();
  }

  ///loading
  changeLoadingState(bool state) {
    searchLoading = state;
    notifyListeners();
  }

  ///改变搜索的过滤条件
  changeSearchState(SearchQueryModel query, {isRefresh = true}) {
    searchQuery.page = query.page;
    searchQuery.q = query.q;
    searchQuery.sort = query.sort;
    searchQuery.order = query.order;
    searchQuery.language = query.language;
    getsearchRepoList(searchQuery, isRefresh: isRefresh);
  }

  /// 解析参数
  parseQuery(SearchQueryModel query) {
    var searchValue = query.q;
    if (query.language != null && query.language.isNotEmpty) {
      searchValue = '${query.q}+language:${query.language}';
    }
    return {
      'q': searchValue,
      'sort': query.sort,
      'order': query.order,
      'page': query.page,
      'per_page': query.per_page
    };
  }
}

class SearchQueryModel {
  String q;
  String sort;
  String order;
  String language;
  int page = 1;
  int per_page = Config.PAGE_SIZE;

  SearchQueryModel(this.q, this.sort, this.order, this.language, {this.page, this.per_page});
}
