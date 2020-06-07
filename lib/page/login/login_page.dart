/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 12:53:48
 * @LastEditors: leo
 * @LastEditTime: 2020-06-03 20:04:13
 */ 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_app/page/login/login_form_widget.dart';
import 'package:github_app/widget/animated_background.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: <Widget>[
            Positioned.fill(child: AnimatedBackground()),
            Center(
              child: _buildBody(context),
            )
          ],
        ),
      ),
    );
  }
  // form内容
  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0)
          ),
          width: ScreenUtil().setWidth(710),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildLogo(),
              LoginForm()
            ],
          ),
        ),
      )
    );
  }
  // logo
  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Image.asset(
        './assets/images/logo.png',
        width: ScreenUtil().setWidth(200)
      ),
    );
  }
}
