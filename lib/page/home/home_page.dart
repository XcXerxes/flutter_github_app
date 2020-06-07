import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_app/page/dynamic/dynamic_page.dart';
import 'package:github_app/page/home/home_drawer.dart';
import 'package:github_app/page/profile/profile_page.dart';
import 'package:github_app/page/trend/trend_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}
class _HomePageState extends State<HomePage> {

  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(Icons.child_friendly),
      title: Text('动态')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.timeline),
      title: Text('趋势')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('我的')
    )
  ];

  final List<Widget> tabBodies = [
    DynamicPage(),
    TrendPage(),
    ProfilePage()
  ];

  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      appBar: _appBar(context),
      drawer: HomeDrawer(),
      body: IndexedStack(
        index: currentTabIndex,
        children: tabBodies,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTabIndex,
        items: bottomTabs,
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
      ),
    );
  }
  // 工具栏
  Widget _appBar(BuildContext context) {
    return AppBar(
      title: Text('Github App'),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/search');
          },
          icon: Icon(Icons.search, size: ScreenUtil().setSp(50)),
        )
      ]
    );
  }
}
