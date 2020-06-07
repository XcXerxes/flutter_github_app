 
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

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    print('参数为=================$args');
    return Scaffold(
      appBar: AppBar(
        title: Text(args),
      ),
      body: Container(
        width: double.infinity,
        color: Color.fromRGBO(235, 235, 235, 1),
        child: FutureBuilder(
          future: _fetchData(args, context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return EasyRefresh.custom(
                header: PhoenixHeader(),
                onRefresh: () async {
                  await Provider.of<EventReceiveProvider>(context, listen: false).getStarredEventList(args, page: 1);
                  await Provider.of<UserProvider>(context, listen: false).getUserInfo();
                  return '';
                },
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: UserHeader(Provider.of<UserProvider>(context).currentUserInfo),
                  ),
                  SliverToBoxAdapter(
                    child: _buildChat(args),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, int index) {
                        return EventItem(Provider.of<EventReceiveProvider>(context, listen: false).strredEventList[index]);
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
      )
    );
  }
  _fetchData(String args, BuildContext context) async {
    var res = await Provider.of<EventReceiveProvider>(context, listen: false).getStarredEventList(args);
    var userRes = await Provider.of<UserProvider>(context, listen: false).getUserInfo(userName: args);
    return res;
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
