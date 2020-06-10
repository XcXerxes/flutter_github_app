/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 22:54:52
 * @LastEditors: leo
 * @LastEditTime: 2020-06-08 18:22:47
 */ 

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_app/models/repoCommit.dart';
import 'package:github_app/page/introduction/introduction_page.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_app/widget/cache_image.dart';

class CommitsItem extends StatelessWidget {
  final RepoCommit item;
  CommitsItem(this.item);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/introduction', arguments: IntroductionArgsModel(item.committer.login, item.committer.name));
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
                _des(),
                _sha()
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
        Text("${item.committer.created_at ?? ''}")
      ],
    );
  }
  // 用户头像
  Widget _avatarUser() {
    return Row(
      children: <Widget>[
        Container(
          child: Text('${item.commit.author.name}', style: TextStyle(
              fontSize: ScreenUtil().setSp(36),
              fontWeight: FontWeight.bold
          )),
        )
      ],
    );
  }
  
  // 描述文件
  Widget _des() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.centerLeft,
      child: Text('${item.commit.message}', style: TextStyle(
        color: Colors.black54
      )),
    );
  }
  // 描述文件
  Widget _sha() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      alignment: Alignment.centerLeft,
      child: Text('${item.sha}', style: TextStyle(
        fontSize: ScreenUtil().setSp(30),
      )),
    );
  }
}
