/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-07 12:43:48
 * @LastEditors: leo
 * @LastEditTime: 2020-06-09 17:00:00
 */ 
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_app/models/event.dart';
import 'package:github_app/models/repoCommit.dart';
import 'package:github_app/page/introduction/introduction_page.dart';
import 'package:github_app/provider/repo.dart';
import 'package:github_app/widget/commits/commits_item.dart';
import 'package:github_app/widget/event/event_item.dart';
import 'package:github_app/widget/repository/repository_header.dart';
import 'package:github_app/widget/xc_tabs.dart';
import 'package:provider/provider.dart';

class DynamicContainer extends StatefulWidget {
  final List<String> tabs = ['动态', '提交'];
  
  final IntroductionArgsModel arguments;
  DynamicContainer(this.arguments);

  @override
  _DynamicContainerState createState() {
    // TODO: implement createState
    return _DynamicContainerState();
  }
}

class _DynamicContainerState extends State<DynamicContainer> with AutomaticKeepAliveClientMixin {
  
  EasyRefreshController _refreshController;
  int currentIndex = 0;
  @override
  initState() {
    super.initState();
    _init();
    _refreshController = EasyRefreshController();
  }

  _init() async {
    var res = await Provider.of<RepoProvider>(context, listen: false).getRepoEventList(widget.arguments.repo, currentIndex);
    await Provider.of<RepoProvider>(context, listen: false).getCurrentRepo(widget.arguments.userName, widget.arguments.repo);
    return res;
  }
  // 刷新
  _refreshData() async {
    var res = await Provider.of<RepoProvider>(context, listen: false).getRepoEventList(widget.arguments.repo, currentIndex);
    return res;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FutureBuilder(
        future: _init(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var list;
            if(currentIndex == 0) {
              list = Provider.of<RepoProvider>(context, listen: false).repoEventList;
            } else {
              list = Provider.of<RepoProvider>(context, listen: false).repoCommitsList;
            }

            return EasyRefresh.custom(
              header: PhoenixHeader(),
              onRefresh: () async {
                _refreshData();
              },
              controller: _refreshController,
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: RepositoryHeader(Provider.of<RepoProvider>(context, listen: false).currentRepo)
                ),
                SliverToBoxAdapter(
                  child: XcTabs(widget.tabs, currentIndex, onPressed: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                    _refreshController.callRefresh();
                  }),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, int index) {
                      if(currentIndex == 0) {
                        return EventItem(list[index]);
                      }
                      return CommitsItem(list[index]);
                    },
                    childCount: list.length
                  ),
                )
              ],
            );
          }
          if(snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


