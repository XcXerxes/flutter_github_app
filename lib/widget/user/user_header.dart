/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-04 17:52:52
 * @LastEditors: leo
 * @LastEditTime: 2020-06-06 21:34:12
 */ 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_app/models/user.dart';
import 'package:github_app/widget/user/user_avatar.dart';
import 'package:intl/intl.dart';

class UserHeader extends StatelessWidget {
  User user;
  UserHeader(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(15.0, 10, 15.0, 0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        )
      ),
      child: Column(
        children: <Widget>[
          UserAvatar(user),
          _buildUrl(),
          _buildCompany(),
          _buildDate(),
          _buildUserFooter(context)
        ],
      ),     
    );
  }
  // url链接
  Widget _buildUrl () {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top: 15.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.link, color: Colors.white, size: ScreenUtil().setSp(50),),
            Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Text(
                '${user.html_url}',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: ScreenUtil().setSp(30)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // 公司
  Widget _buildCompany () {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10.0),
      child: (user != null && user.company != null) ? Text(
        '就职于 ${user.company}',
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
          color: Colors.white
        ),
      ) : Text(''),
    );
  }

  // 创建时间
  Widget _buildDate() {
    var created = user != null ? DateFormat.yMMMMEEEEd().format(user.created_at) : '';
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 6.0),
      child: Text(
        '创建于: $created',
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
          color: Colors.white
        ),
      ),
    );
  }

  // 底部状态栏
  Widget _buildUserFooter(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.5,
            color: Color.fromRGBO(200, 200, 200, 0.8)
          )
        )
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _buildUserFooterItem('仓库', user.public_repos, (){
              Navigator.pushNamed(context, '/repo', arguments: user.login);
            }),
          ),
          Expanded(
            child: _buildUserFooterItem('粉丝', user.followers, (){
              Navigator.pushNamed(context, '/follower', arguments: user.login);
            }),
          ),
          Expanded(
            child: _buildUserFooterItem('关注', user.following, (){
              Navigator.pushNamed(context, '/following', arguments: user.login);
            }),
          ),
          Expanded(
            child: _buildUserFooterItem('星标', user.disk_usage ?? 0, (){
              Navigator.pushNamed(context, '/starred', arguments: user.login);
            }),
          ),
        ],
      ),
    );
  }

  // 底部状态栏itme
  Widget _buildUserFooterItem (String label, int value, onPressed) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 0.5,
              color: label == '星标' ? Colors.transparent : Color.fromRGBO(255, 255, 255, 0.7)
            )
          )
        ),
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(30)
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text('$value',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
