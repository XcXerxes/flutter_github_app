/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-06 19:19:13
 * @LastEditors: leo
 * @LastEditTime: 2020-06-06 19:24:22
 */ 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Empty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: ScreenUtil().setWidth(200),
            height: ScreenUtil().setHeight(200),
            child: Image.asset('./assets/images/nodata.png')
          ),
          Text(
            '暂无数据',
            style: TextStyle(fontSize: ScreenUtil().setSp(32), color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}