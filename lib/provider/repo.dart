/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-05 12:35:32
 * @LastEditors: leo
 * @LastEditTime: 2020-06-10 17:36:01
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:github_app/config/config.dart';
import 'package:github_app/models/event.dart';
import 'package:github_app/models/fileModel.dart';
import 'package:github_app/models/issue.dart';
import 'package:github_app/models/repoCommit.dart';
import 'package:github_app/models/repoReadme.dart';
import 'package:github_app/models/repository.dart';
import 'package:github_app/services/address.dart';
import 'package:github_app/services/dio.dart';

class RepoProvider extends ChangeNotifier {
  /// 仓库events
  List<Event> repoEventList = [];

  /// 仓库commits
  List<RepoCommit> repoCommitsList = [];

  /// 仓库的issueList
  List<Issue> repoIssueList = [];

  /// 仓库的文件列表
  List<FileModel> repoFileList = []; 

  /// 仓库列表
  List<Repository> repoList = [];

  /// 仓库的readme
  String repoReadmeContent;

  /// 单个仓库的详情内容
  Repository currentRepo;

  /// 搜索仓库列表
  List<Repository> searchRepoList = [];

  /// 搜索条件
  SearchQueryModel searchQuery =
      SearchQueryModel('', 'best%20match', 'desc', null);

  /// 搜索loading
  bool searchLoading = false;
  getRepoList(String userName, {page = 1, sort = 'pushed'}) async {
    try {
      var res = await httpManager.netFetch(
          Address.userRepos(userName),
          {'page': page, 'sort': sort, 'per_page': Config.PAGE_SIZE},
          null,
          null);
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
  getsearchRepoList(SearchQueryModel queryParams, {isRefresh = true}) async {
    try {
      if (queryParams.q == null || queryParams.q.isEmpty) {
        setSearchRepoList([]);
        return null;
      }
      if (isRefresh) {
        changeLoadingState(true);
      }
      var res = await httpManager.netFetch(Address.searchRepo(queryParams.q),
          parseQuery(queryParams), null, null);
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
  setSearchRepoList(List list) {
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

  /// 单个仓库的详情
  getCurrentRepo(String userName, String repo) async {
    try {
      var res = await httpManager.netFetch(
          Address.userRepoDetail(userName, repo), null, null, null);
      if (res != null && res.result) {
        currentRepo = Repository.fromJson(res.data);
      }
      return res;
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return null;
  }

  /// 仓库的事件列表
  getRepoEventList(String repoName, int currentIndex, {page = 1}) async {
    try {
      var res;
      if (currentIndex == 0) {
        res = await httpManager.netFetch(Address.getReposEvent(repoName),
            {'page': page, 'per_page': Config.PAGE_SIZE}, null, null);
      } else {
        res = await httpManager.netFetch(Address.getReposCommit(repoName),
            {'page': page, 'per_page': Config.PAGE_SIZE}, null, null);
      }
      if (res != null && res.result) {
        if (currentIndex == 0) {
          setRepoEventList(res.data);
        } else {
          setRepoCommitsList(res.data);
        }
        return res;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  /// 仓库的事件列表设置
  setRepoEventList(List list) {
    repoEventList = [];
    for (var i = 0; i < list.length; i++) {
      repoEventList.add(Event.fromJson(list[i]));
    }
    notifyListeners();
  }

  /// 仓库的提交列表设置
  setRepoCommitsList(List list) {
    repoCommitsList = [];
    for (var i = 0; i < list.length; i++) {
      repoCommitsList.add(RepoCommit.fromJson(list[i]));
    }
    notifyListeners();
  }

  /// 得到仓库的 readme 内容
  getRepoReadmeInfo(String repoName) async{
    try {
      var res = await httpManager.netFetch(
        Address.getReposReadme(repoName),
        null,
        {"Accept": 'application/vnd.github.VERSION.raw'},
        Options(contentType: "text/plain; charset=utf-8")
      );
      if(res != null && res.result) {
        print('返回的参数===================${res.data}');
        repoReadmeContent = res.data;
      } else {
        repoReadmeContent = '';
      }
      return res;
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return null;
  }

  /// 得到仓库的 issue内容
  getRepoIssueList(String repoName, {page = 1, state = 'all'}) async{
    try {
      var res = await httpManager.netFetch(
        Address.getReposIssueList(repoName),
        {'page': page, 'state': state, 'per_page': Config.PAGE_SIZE},
        null,
        null
      );
      if(res != null && res.result) {
        setRepoIssueList(res.data);
      }
      return res;
    } catch (e) {
      print(e);
    }
    return null;
  }
  /// 设置仓库的 issue列表
  setRepoIssueList(List list) {
    repoIssueList = [];
    for (var i = 0; i < list.length; i++) {
      repoIssueList.add(Issue.fromJson(list[i]));
    }
    notifyListeners();
  }


  /// 仓库的文件列表
  getRepoFileList(repoName) async{
    try {
      var res = await httpManager.netFetch(
        Address.getReposFileList(repoName),
        null,
        null,
        null
      );
      if (res != null && res.result) {
        setRepoFileList(res.data);
      }
      return res;
    } catch (e) {
      print(e);
    }
    return null;
  }

  /// 文件列表
  setRepoFileList(List list) {
    repoFileList = [];
    for (var i = 0; i < list.length; i++) {
      repoFileList.add(FileModel.fromJson(list[i]));
    }
    notifyListeners();
  }
}

class SearchQueryModel {
  String q;
  String sort;
  String order;
  String language;
  int page = 1;
  int per_page = Config.PAGE_SIZE;

  SearchQueryModel(this.q, this.sort, this.order, this.language,
      {this.page, this.per_page});
}
