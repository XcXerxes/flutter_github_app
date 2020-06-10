/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-07 12:10:34
 * @LastEditors: leo
 * @LastEditTime: 2020-06-08 17:11:24
 */ 
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_app/models/repository.dart';
import 'package:intl/intl.dart';

class RepositoryHeader extends StatelessWidget {
  final Repository repo;
  RepositoryHeader(this.repo);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          children: <Widget>[
            _buildTopName(),
            _buildSubInfo(),
            _buildFooter()
          ],
        ),
      ),
    );
  }
  // 名称
  Widget _buildTopName(){
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 15.0),
      child: Row(
        children: <Widget>[
          // 用户名
          RawMaterialButton(
            constraints: BoxConstraints(minWidth: 0, minHeight: 0),
            padding: EdgeInsets.all(0),
            onPressed: () {

            },
            child: Text(
              '${repo.owner.login ?? ''}',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: ScreenUtil().setSp(36),
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              '/',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
              ),
            ),
          ),
          Expanded(
            child: Text(
              '${repo.name}',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(36),
                fontWeight: FontWeight.bold
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  // 子内容
  Widget _buildSubInfo() {
    var date = repo.createdAt != null ? DateFormat('yyyy-MM-dd').format(repo.createdAt) : '--';
    var updateDate = repo.updatedAt != null ? DateFormat('yyyy-MM-dd HH:mm:ss').format(repo.createdAt) : '--';
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('${repo.language ?? '--'}', style: TextStyle(
                fontSize: ScreenUtil().setSp(30),
                color: Colors.redAccent
              ),),
              Container(
                margin: EdgeInsets.only(left: 5.0),
                child: Text(
                  '${repo.size ?? '--'}',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30)
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            alignment: Alignment.centerLeft,
            child: Text('${repo.description ?? '--'}', style: TextStyle(
              fontSize: ScreenUtil().setSp(30.0),
              color: Colors.black54
            ),),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 15.0),
            child: Text(
              '创建于 $date',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(28.0)
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 2.0),
            padding: EdgeInsets.only(right: 15.0),
            alignment: Alignment.centerRight,
            child: Text(
              '最后提交于 $updateDate',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(28.0)
              ),
            ),
          )
        ],
      ),
    );
  }

  // footer内容
  Widget _buildFooter () {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.5,
            color: Colors.black12
          )
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: _buildFooterItem(Icons.star_border, repo.stargazersCount),
          ),
          Expanded(
            child: _buildFooterItem(Icons.share, repo.forksCount),
          ),
          Expanded(
            child: _buildFooterItem(Icons.remove_red_eye, repo.watchersCount),
          ),
          Expanded(
            child: _buildFooterItem(Icons.info_outline, repo.allIssueCount ?? 0),
          )
        ],
      )
    );
  }

  // footer item
  Widget _buildFooterItem (IconData icon, int count) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
        ),
      )
    );
  }
}

