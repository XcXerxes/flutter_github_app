/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-05 15:26:41
 * @LastEditors: leo
 * @LastEditTime: 2020-06-05 18:13:14
 */
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_footer.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:github_app/provider/profile.dart';
import 'package:github_app/widget/follower/follower_item.dart';
import 'package:provider/provider.dart';

/// 粉丝的列表
class FollowingPage extends StatelessWidget {
  int page = 1;
  @override
  Widget build(BuildContext context) {
    String userName = ModalRoute.of(context).settings.arguments ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text('$userName')
      ),
      body: FutureBuilder(
        future: Provider.of<ProfileProvider>(context, listen: false).getFollowingList(userName),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Consumer<ProfileProvider>(
              builder: (context, profile, widget) {
                return EasyRefresh.custom(
                  header: PhoenixHeader(),
                  footer: PhoenixFooter(),
                  onRefresh: () async {
                    page = 1;
                    return Provider.of<ProfileProvider>(context, listen: false)
                        .getFollowingList(userName, page: page);
                  },
                  onLoad: () async {
                    page++;
                    return Provider.of<ProfileProvider>(context, listen: false)
                        .getFollowingList(userName, page: page);
                  },
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildBuilderDelegate((context, int index) {
                        return FollowerItem(profile.followingList[index]);
                      }, childCount: profile.followingList.length),
                    )
                  ],
                );
              },
            );
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
