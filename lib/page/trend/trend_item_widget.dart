/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-04 11:40:36
 * @LastEditors: leo
 * @LastEditTime: 2020-06-04 17:30:18
 */ 

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_app/models/trendingRepoModel.dart';
import 'package:github_app/widget/cache_image.dart';

class TrendItem extends StatelessWidget {
  final TrendingRepoModel item;
  TrendItem(this.item);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      margin: EdgeInsets.only(top: 15.0),
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            children: <Widget>[
              _buildBody(),
              _buildDescription(),
              _buildFooter()
            ],
          ),
        )
      ),
    );
  }

  // body内容
  Widget _buildBody () {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _buildUser(),
        ),
        Text(
          '${item.language}',
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: Colors.black54
          ),
        )
      ],
    );
  }

  // 描述内容
  Widget _buildDescription () {
    return Container(
      height: ScreenUtil().setHeight(94),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      alignment: Alignment.centerLeft,
      child: Text(
        '${item.description}',
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28), color: Colors.black54)),
    );
  }

  // 用户头像等内容
  Widget _buildUser() {
    print('avatar地址========${item.avatar}');
    print('url地址========${item.url}');
    return Container(
      padding: EdgeInsets.only(right: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: ClipOval(
              child: CacheImage('${item.url}', width: ScreenUtil().setWidth(70)),
            ),
          ),
          _buildTeam()
        ],
      ),
    );
  }

  // team
  Widget _buildTeam() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${item.name}',
            style: TextStyle(fontSize: ScreenUtil().setSp(32), fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: <Widget>[
              Icon(Icons.people, size: ScreenUtil().setSp(30),color: Colors.black38),
              Expanded(
                child: Container(
                margin: EdgeInsets.only(left: 10.0),
                  child: Text('${item.author}', style: 
                    TextStyle(
                      color: Colors.black38,
                      fontSize: ScreenUtil().setSp(26)
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  // footer内容
  Widget _buildFooter () {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildFooterItem(Icons.star_border, item.stars),
        _buildFooterItem(Icons.share, item.forks),
        _buildFooterItem(Icons.info_outline, item.currentPeriodStars),
      ],
    );
  }

  // footer item
  Widget _buildFooterItem (IconData icon, int count) {
    return Row(
      children: <Widget>[
        Icon(icon, size: ScreenUtil().setSp(30), color: Colors.black54),
        Container(
          margin: EdgeInsets.only(left: 10.0),
          child: Text('$count', style: TextStyle(
            fontSize: ScreenUtil().setSp(30),
            color: Colors.black54
          )),
        )
      ],
    );
  }
}
