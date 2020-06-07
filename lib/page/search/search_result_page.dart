/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-06 11:22:39
 * @LastEditors: leo
 * @LastEditTime: 2020-06-06 19:38:11
 */ 
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_footer.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:github_app/page/search/search_drawer_widget.dart';
import 'package:github_app/provider/repo.dart';
import 'package:github_app/widget/empty.dart';
import 'package:github_app/widget/repository/repository_item.dart';
import 'package:provider/provider.dart';
class SearchResultPage extends StatefulWidget {
  final arguments;
  SearchResultPage(this.arguments);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchResultPageState();
  }
}
class _SearchResultPageState extends State<SearchResultPage> {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // String q = ModalRoute.of(context).settings.arguments;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {
    //   String q = ModalRoute.of(this.context).settings.arguments;
    //   widget.searchValue = q;
    // });
    _getData();
    
  }
  @override
  void didUpdateWidget(SearchResultPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
  _getData() {
    SearchQueryModel query = Provider.of<RepoProvider>(this.context, listen: false).searchQuery;
    query.q = widget.arguments;
    Provider.of<RepoProvider>(this.context, listen: false).getsearchRepoList(query);
  }
  @override
  Widget build(BuildContext context) {
    String q = ModalRoute.of(context).settings.arguments;
    SearchQueryModel query = Provider.of<RepoProvider>(context, listen: false).searchQuery;
    query.q = q;
    return Scaffold(
      appBar: AppBar(
        title: Text('$q'),
      ),
      
      endDrawer: SearchDrawer(_typeCallback, _sortCallback, _languageCallback),
      body: Consumer<RepoProvider>(
        builder: (context, repo, widget) {
          if(repo.searchLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (repo.searchRepoList.length == 0) {
            return Center(
              child: Empty(),
            );
          }
          return EasyRefresh.custom(
            header: PhoenixHeader(),
            footer: PhoenixFooter(),
            onRefresh: () async{
              await _onReresh(context);
            },
            onLoad: () async {
              // return Provider.of<RepoProvider>(context, listen: false).getRepoList(args, page: page);
            },
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, int index) {
                    return RepositoryItem(repo.searchRepoList[index]);
                  },
                  childCount: repo.searchRepoList.length
                ),
              )
            ],
          );
        },
      ),
    );
  }
  _onReresh(context) async {
    var query = Provider.of<RepoProvider>(context, listen: false).searchQuery;
    query.page = 1;
    Provider.of<RepoProvider>(context, listen: false).changeSearchState(query, isRefresh: false);
    return '';
  }
  // load
  _onLoad(context) async {
    var query = Provider.of<RepoProvider>(context, listen: false).searchQuery;
    query.page += 1;
    Provider.of<RepoProvider>(context, listen: false).changeSearchState(query);
  }
  _typeCallback(String value) {
    _fetchData(value, '类型');
  }
  _sortCallback(String value) {
    _fetchData(value, '排序');
  }
  _languageCallback(String value) {
    _fetchData(value, '语言');
  }
  _fetchData(String value, String label) {
    var query = Provider.of<RepoProvider>(context, listen: false).searchQuery;
    if(label == '类型') {
      query.sort = value;
    } else if(label == '排序') {
      query.order = value;
    } else {
      query.language = value;
    }
    Provider.of<RepoProvider>(context, listen: false).changeSearchState(query);
    Navigator.of(context).pop();
  }
}
