/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-06 23:53:34
 * @LastEditors: leo
 * @LastEditTime: 2020-06-07 00:24:43
 */ 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_app/models/user.dart';
import 'package:github_app/provider/user.dart';
import 'package:github_app/widget/cache_image.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(420),
      child: Consumer<UserProvider>(
        builder: (context, user, widget) {
          return Column(
            children: <Widget>[
              _buildUser(context, user.myUserInfo),
              _buildList(),
              _buildBtn(context)
            ],
          );
        },
      )
    );
  }

  Widget _buildBtn(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(390),
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: FlatButton(
        color: Theme.of(context).primaryColor,
        child: Text('退出登录', style: TextStyle(
          color: Colors.white,
          fontSize: ScreenUtil().setSp(30)
        ),),
        onPressed: () {
          
        },
      ),
    );
  }

  Widget _buildUser(BuildContext context, User user) {
    return Container(
      width: ScreenUtil().setWidth(420),
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(left: 15.0, top: 20.0),
      alignment: Alignment.centerLeft,
      child: SafeArea(
        child: Column(
        children: <Widget>[
          ClipOval(
            child: CacheImage(user.avatar_url, height: ScreenUtil().setHeight(130)),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0, bottom: 6.0),
            child: Text(
              user.login,
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(36)
              ),
            ),
          ),
          Container(
            child: Text(
              user.name,
              style: TextStyle(
                color: Colors.white70,
                fontSize: ScreenUtil().setSp(30)
              ),
            ),
          )
        ],
      ),
      )
    );
  }

  Widget _buildList() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          _buildTitle('问题反馈'),
          _buildTitle('个人信息'),
          _buildTitle('切换主题'),
          _buildTitle('检查更新'),
          _buildTitle('关于我们'),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30)
        ),
      ),
    );
  }
}