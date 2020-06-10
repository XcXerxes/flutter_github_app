/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-09 17:16:50
 * @LastEditors: leo
 * @LastEditTime: 2020-06-09 21:49:34
 */ 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_app/models/issue.dart';
import 'package:github_app/widget/cache_image.dart';
import 'package:intl/intl.dart';

class IssueItem extends StatelessWidget {
  Issue item;
  IssueItem(this.item);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildAvatar(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  // 头像
  Widget _buildAvatar() {
    return Container(
      child: ClipOval(
        child: CacheImage('${item.user.avatar_url}', height: ScreenUtil().setHeight(60)),
      ),
    );
  }

  /// 内容区域
  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: Column(
        children: <Widget>[
          _buildName(),
          _buildDes(),
          _buildFooter()
        ],
      ),
    );
  }
  /// 名称
  Widget _buildName() {
    var upText = DateFormat('HH:mm:ss').format(item.updatedAt);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '${item.user.login}',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(36),
            fontWeight: FontWeight.bold
          ),
        ),
        Text(
          '${upText}',
          style: TextStyle(
            color: Colors.black54,
          ),
        )
      ],
    );
  }

  /// 描述
  Widget _buildDes() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        '${item.title}',
        style: TextStyle(
          color: Colors.black54,
          fontSize: ScreenUtil().setSp(30)
        ),
      ),
    );
  }

  /// footer
  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildFooterLeft(),  
        _buildFooterRight(),  
      ],
    );
  }

  Widget _buildFooterLeft() {
    var color = item.state == 'open' ? Colors.deepPurple : Colors.red;
    return Container(
      child: Row(
        children: <Widget>[
          Icon(Icons.info_outline, color: color, size: ScreenUtil().setSp(36),),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '${item.state}',
              style: TextStyle(
                color: color
              ),
            ),
          ),
          Text('#${item.number}', style: TextStyle(
            color: Colors.black54
          ),)
        ],
      ),
    );
  }
  Widget _buildFooterRight() {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(Icons.message, color: Colors.black54, size: ScreenUtil().setSp(36)),
          Container(
            margin: EdgeInsets.only(left: 5),
            child: Text(
              '${item.commentNum ?? 0}',
              style: TextStyle(
                color: Colors.black54
              ),
            ),
          )
        ],
      ),
    );
  }
}