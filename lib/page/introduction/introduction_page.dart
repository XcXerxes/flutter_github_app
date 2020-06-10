/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-06 23:30:22
 * @LastEditors: leo
 * @LastEditTime: 2020-06-10 15:03:49
 */ 
import 'package:flutter/material.dart';
import 'package:github_app/page/introduction/dynamic_widget.dart';
import 'package:github_app/page/introduction/file_widget.dart';
import 'package:github_app/page/introduction/issue_widget.dart';
import 'package:github_app/page/introduction/readme_widger.dart';

class IntroductionPage extends StatefulWidget {
  final IntroductionArgsModel argument;
  IntroductionPage(this.argument);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _IntroductionPageState();
  }
}

class _IntroductionPageState extends State<IntroductionPage> with AutomaticKeepAliveClientMixin {

  TabController _tabController;
  List tabs = ['动态', '详情', 'Issue', '文件'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.argument.repo),
          actions: <Widget>[
            IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.more_horiz),
            )
          ],
          bottom: _tabbar(),
        ),
        body: Container(
          child: TabBarView(
            children: <Widget>[
              DynamicContainer(widget.argument),
              ReadmeContainer(widget.argument),
              IssueContainer(widget.argument),
              FileContainer(widget.argument),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabbar() {
    return TabBar(
      tabs: tabs.map((e) => Tab(text: e)).toList(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}

class IntroductionArgsModel {
  final String userName;
  final String repo;

  IntroductionArgsModel(this.userName, this.repo);
}
