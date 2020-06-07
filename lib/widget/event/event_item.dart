/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 22:54:52
 * @LastEditors: leo
 * @LastEditTime: 2020-06-06 23:43:27
 */ 

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_app/models/event.dart';
import 'package:github_app/widget/cache_image.dart';

class EventItem extends StatelessWidget {
  final Event item;
  EventItem(this.item);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/introduction', arguments: item.actor.login);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        margin: EdgeInsets.only(top: 10.0),
        child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              children: <Widget>[
                _bodyArea(),
                _des()
              ],
            ),
          )
        ),
      ),
    );
  }
  // top
  Widget _bodyArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _avatarUser(),
        Text("${DateFormat.jm().format(item.createdAt)}")
      ],
    );
  }
  // 用户头像
  Widget _avatarUser() {
    return Row(
      children: <Widget>[
        ClipOval(
          child: CacheImage(item.actor.avatar_url,
            width: ScreenUtil().setWidth(64),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 8.0),
          child: Text(item.actor.login),
        )
      ],
    );
  }
  
  // 描述文件
  Widget _des() {
    var action = item.payload.action != null ? '${item.payload.action} ' : '';
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.centerLeft,
      child: Text('$action${item.repo.name}', style: TextStyle(
        fontSize: ScreenUtil().setSp(30),
        fontWeight: FontWeight.bold
      )),
    );
  }
}
