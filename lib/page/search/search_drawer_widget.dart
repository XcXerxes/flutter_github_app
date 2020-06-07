/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-06 02:18:22
 * @LastEditors: leo
 * @LastEditTime: 2020-06-06 16:47:02
 */ 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_app/provider/repo.dart';
import 'package:provider/provider.dart';

class SearchDrawer extends StatelessWidget {
  final Function typeCallback;
  final Function sortCallback;
  final Function languageCallback;

  SearchDrawer(this.typeCallback, this.sortCallback, this.languageCallback);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('搜索过滤条件'),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Consumer<RepoProvider>(
          builder: (context, repo, widget) {
            print('内容为===================${repo.searchQuery.sort}');
            return Container(
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  _buildItemType(context, '类型', repo.searchQuery.sort, searchFilterType, typeCallback),
                  _buildItemType(context, '排序', repo.searchQuery.order, sortType, sortCallback),
                  _buildItemType(context, '语言', repo.searchQuery.language, searchLanguageType, languageCallback)
                ],
              ),
            );
          },
        )
      ),
    );
  }
  Widget _buildItemType(BuildContext context, String title, String currentValue, List<FilterModel> modelList, callback) {
    List<Widget> _contentList = List();
    for (var i = 0; i < modelList.length; i++) {
      FilterModel model = modelList[i];
      bool isCheck = model.value == currentValue;
      _contentList.add(_renderItem(model, isCheck, callback));
    }
    return Container(
      child: Column(
        children: <Widget>[
          _renderTitle(title, context),
          Column(
            children: ListTile.divideTiles(
              context: context,
              tiles: _contentList
            ).toList(),
          )
        ],
      ),
    );
  }
  // List<Widget> _renderList(BuildContext context) {
  //   List<Widget> list = List();
  //   list.add(Container(
  //     width: ScreenUtil().setWidth(400),
  //   ));

  //   list.add(_renderTitle('类型', context));

  //   for (int i = 0; i < searchFilterType.length; i++) {
  //     FilterModel model = searchFilterType[i];
  //     list.add(_renderItem(model, searchFilterType, i, typeCallback));
  //   }
  //   list.add(_renderTitle('排序', context));
  //   for (int i = 0; i < sortType.length; i++) {
  //     FilterModel model = sortType[i];
  //     list.add(_renderItem(model, sortType, i, sortCallback));
  //   }
  //   list.add(_renderTitle('语言', context));
  //   for (int i = 0; i < searchLanguageType.length; i++) {
  //     FilterModel model = searchLanguageType[i];
  //     list.add(
  //         _renderItem(model, searchLanguageType, languageCallback));
  //   }
  //   return list;
  // }

  _renderTitle(String title, BuildContext context) {
    return new Container(
      color: Theme.of(context).primaryColor,
      width: double.infinity,
      height: ScreenUtil().setWidth(100),
      child: new Center(
        child: new Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(36))
        ),
      ),
    );
  }

Widget _renderItem(FilterModel model, bool isCheck,
  select) {
    return ListTile(
      onTap: () {
        select(model.value);
      },
      title: Text(
        model.name,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30)
        ),
      ),
      trailing: isCheck ? Icon(
        Icons.check,
        color: Colors.deepPurple,
      ) : null
    );
  }
}

class FilterModel {
  String name;
  String value;
  bool select;

  FilterModel({this.name, this.value, this.select});
}

var sortType = [
  FilterModel(name: 'desc', value: 'desc', select: true),
  FilterModel(name: 'asc', value: 'asc', select: false),
];
var searchFilterType = [
  FilterModel(name: "best_match", value: 'best%20match', select: true),
  FilterModel(name: "stars", value: 'stars', select: false),
  FilterModel(name: "forks", value: 'forks', select: false),
  FilterModel(name: "updated", value: 'updated', select: false),
];
var searchLanguageType = [
  FilterModel(name: "所有", value: null, select: true),
  FilterModel(name: "Java", value: 'Java', select: false),
  FilterModel(name: "Dart", value: 'Dart', select: false),
  FilterModel(name: "Objective_C", value: 'Objective-C', select: false),
  FilterModel(name: "Swift", value: 'Swift', select: false),
  FilterModel(name: "JavaScript", value: 'JavaScript', select: false),
  FilterModel(name: "PHP", value: 'PHP', select: false),
  FilterModel(name: "C__", value: 'C++', select: false),
  FilterModel(name: "C", value: 'C', select: false),
  FilterModel(name: "HTML", value: 'HTML', select: false),
  FilterModel(name: "CSS", value: 'CSS', select: false),
];
