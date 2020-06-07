/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-06 23:30:22
 * @LastEditors: leo
 * @LastEditTime: 2020-06-06 23:51:11
 */ 
import 'package:flutter/material.dart';

class IntroductionPage extends StatefulWidget {
  final argument;
  IntroductionPage(this.argument);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _IntroductionPageState();
  }
}

class _IntroductionPageState extends State<IntroductionPage> {
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
          title: Text(widget.argument),
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
            children: tabs.map((tab) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(tab),
              );
            }).toList(),
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
}