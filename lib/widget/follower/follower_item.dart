/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-05 14:52:32
 * @LastEditors: leo
 * @LastEditTime: 2020-06-06 20:24:07
 */ 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_app/models/user.dart';
import 'package:github_app/widget/cache_image.dart';

class FollowerItem extends StatelessWidget {
  final User item;
  FollowerItem(this.item);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        margin: EdgeInsets.only(top: 15.0),
        child: _buildItem(context),
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, '/user', arguments: item.login);
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              ClipOval(
                child: CacheImage(item.avatar_url, width: ScreenUtil().setHeight(70)),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Text('${item.login ?? ""}', style: TextStyle(
                  fontSize: ScreenUtil().setSp(30)
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
