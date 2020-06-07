import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_app/provider/event_receive.dart';
import 'package:github_app/provider/user.dart';
import 'package:github_app/widget/event/event_item.dart';
import 'package:github_app/widget/user/ghchart_rshah.dart';
import 'package:github_app/widget/user/user_header.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false).myUserInfo;
    return Container(
      width: double.infinity,
      color: Color.fromRGBO(235, 235, 235, 1),
      child: FutureBuilder(
        future: Provider.of<EventReceiveProvider>(context, listen: false).getStarredEventList(user.login),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return EasyRefresh.custom(
              header: PhoenixHeader(),
              onRefresh: () async {
                await Provider.of<EventReceiveProvider>(context, listen: false).getStarredEventList(user.login, page: 1);
                await Provider.of<UserProvider>(context, listen: false).getUserInfo();
                return '';
              },
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: UserHeader(user),
                ),
                SliverToBoxAdapter(
                  child: _buildChat(user.login),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, int index) {
                      return EventItem(Provider.of<EventReceiveProvider>(context).strredEventList[index]);
                    },
                    childCount: 10
                  ),
                )
              ],
            );
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(
            child: CircularProgressIndicator()
          );
        },
      ),
    );
  }

  Widget _buildChat (String login) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.centerLeft,
            child: Text('个人动态', style: TextStyle(fontSize: ScreenUtil().setSp(30)),),
          ),
          Card(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: GhchartRshah(login),
            ),
          )
        ],
      ),
    );
  }
}
