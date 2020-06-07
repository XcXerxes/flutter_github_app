/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-04 20:21:40
 * @LastEditors: leo
 * @LastEditTime: 2020-06-04 21:09:48
 */ 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:github_app/services/address.dart';

class GhchartRshah extends StatelessWidget {
  final String userName;

  GhchartRshah(this.userName);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: ScreenUtil().setHeight(140),
      child: SvgPicture.network(
        Address.getUserChartAddress(userName),
        width: double.infinity,
        height: ScreenUtil().setHeight(120),
        allowDrawingOutsideViewBox: true,
        placeholderBuilder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
