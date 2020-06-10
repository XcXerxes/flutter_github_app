import 'package:flutter/material.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart' as extended;
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_app/page/introduction/introduction_page.dart';
import 'package:github_app/page/introduction/issue/issue_item.dart';
import 'package:github_app/provider/repo.dart';
import 'package:github_app/widget/search_bar.dart';
import 'package:github_app/widget/xc_tabs.dart';
import 'package:provider/provider.dart';

class IssueContainer extends StatefulWidget {
  final IntroductionArgsModel arguments;
  final List<String> tabs = ['所有', '打开', '关闭'];
  IssueContainer(this.arguments);
  
  @override
  _IssueContainerState createState() => _IssueContainerState();
}

class _IssueContainerState extends State<IssueContainer> {
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }
  String getStateValue() {
    switch (widget.tabs[currentIndex]) {
      case '所有':
        return 'all';
      case '打开':
        return 'open';
      case '关闭':
        return 'closed';
        break;
      default:
        return 'open';
    }
  }
  _init() async {
    String state = getStateValue();
    var res = Provider.of<RepoProvider>(context, listen: false).getRepoIssueList(widget.arguments.repo, state: state);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return extended.NestedScrollView(
      pinnedHeaderSliverHeightBuilder: () {
        return MediaQuery.of(context).padding.top + kToolbarHeight;
      },
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              color: Colors.black12,
              child: Column(
                children: <Widget>[
                  _buildTextField(),
                  Container(
                    width: double.infinity,
                    child: XcTabs(widget.tabs, currentIndex),
                  )
                ],
              ),
            ),
          )
        ];
      },
      body: Consumer<RepoProvider>(
        builder: (context, repo, widget) {
          if (repo.repoIssueList.length > 0) {
            return EasyRefresh(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return IssueItem(repo.repoIssueList[index]);
                },
                itemCount: repo.repoIssueList.length,
              ),
            );
          }
          return Text('暂无数据');
        },
      )
    );
  }
  // 输入框
  _buildTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '搜索关键字...',
          suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: (){

          }),
        ),
      ),
    );
  }
}

