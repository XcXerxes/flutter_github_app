/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-04 18:11:41
 * @LastEditors: leo
 * @LastEditTime: 2020-06-06 22:09:17
 */ 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_app/models/user.dart';
import 'package:github_app/widget/cache_image.dart';

class UserAvatar extends StatelessWidget {
  User user;
  UserAvatar(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          _buildImage(),
          _buildUserSign(),
        ],
      ),
    );
  }

  // 头像
  Widget _buildImage () {
    return Container(
      width: ScreenUtil().setWidth(140),
      child: ClipOval(
        child: CacheImage(user.avatar_url),
      ),
    );
  }
  // 名称和签名组合
  Widget _buildUserSign () {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        alignment: Alignment.centerLeft,
        child: Column(
          children: <Widget>[
            _buildUserName(),
            _buildName(),
            _buildSign(),
            _buildAddress()
          ],
        ),
      ),
    );
  }
  // 用户名
  Widget _buildUserName() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 6),
      child: Text(
        '${user.login}',
        style: TextStyle(
          color: Colors.white,
          fontSize: ScreenUtil().setSp(36),
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
  // 名称
  Widget _buildName() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 6),
      child: Text(
        '${user.name ?? ''}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, .7),
          fontSize: ScreenUtil().setSp(30),
        ),
      ),
    );

  }
  // 签名
  Widget _buildSign () {
    var bioText = user.bio ?? 'Ta什么都没留下';
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.person_pin_circle, size: ScreenUtil().setSp(36), color: Color.fromRGBO(255, 255, 255, .7)),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 6.0),
              child: Text('$bioText',
                style: TextStyle(color: Color.fromRGBO(255, 255, 255, .7))),
            ),
          )
        ],
      ),
    );
  }

  // 位置
  Widget _buildAddress () {
    var locationText = user.location ?? 'Ta什么都没留下';
    return Container(
      margin: EdgeInsets.only(bottom: 6),
      child: Row(
        children: <Widget>[
          Icon(Icons.location_on, size: ScreenUtil().setSp(36), color: Color.fromRGBO(255, 255, 255, .7)),
          Container(
            margin: EdgeInsets.only(left: 6.0),
            child: Text('$locationText',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Color.fromRGBO(255, 255, 255, .7))),
          )
        ],
      ),
    );
  }
}
