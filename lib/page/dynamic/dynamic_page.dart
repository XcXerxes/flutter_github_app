/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 00:53:56
 * @LastEditors: leo
 * @LastEditTime: 2020-06-09 01:24:34
 */ 
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_footer.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:github_app/models/event.dart';
import 'package:github_app/provider/event_receive.dart';
import 'package:github_app/provider/user.dart';
import 'package:github_app/widget/event/event_item.dart';
import 'package:provider/provider.dart';

class DynamicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userName = Provider.of<UserProvider>(context).myUserInfo.login;
    return FutureBuilder(
      future: Provider.of<EventReceiveProvider>(context, listen: false).getEventReceiveList(userName),
      builder: (context, snapshot) {
        List<Event> eventList = Provider.of<EventReceiveProvider>(context, listen: false).eventList;
        if (snapshot.hasData && eventList != null) {
          return EasyRefresh.custom(
            header: PhoenixHeader(),
            footer: PhoenixFooter(),
            onLoad: () {

            },
            onRefresh: () {
              
            },
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return EventItem(eventList[index]);
                  },
                  childCount: eventList.length
                ),
              )
            ],
          );
        }
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
