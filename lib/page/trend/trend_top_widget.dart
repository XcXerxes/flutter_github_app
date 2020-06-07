/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-04 10:52:17
 * @LastEditors: leo
 * @LastEditTime: 2020-06-04 14:18:28
 */ 
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_app/provider/trend.dart';
import 'package:provider/provider.dart';

class TrendTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      height: ScreenUtil().setHeight(80),
      child: Consumer<TrendProvider>(
        builder: (context, trend, widget) {
          return Row(
            children: <Widget>[
              _dropdownBtn(context, 'time', trend.since),
              _dropdownBtn(context, 'language', trend.languageType)
            ],
          );
        }
      ),     
    );
  }

  // 单个dropdown 按钮
  Widget _dropdownBtn(BuildContext context, String type, String value) {
    List trendTimeList = trendTime();
    List trendLanguageTypeList = trendLanguageType();
    List list = (type == 'time' ? trendTimeList : trendLanguageTypeList);
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: DropdownButton(
          value: value,
          selectedItemBuilder: (BuildContext context) {
            return list.map((dynamic item) {
              return Center(
                child: Text(item.name, style: TextStyle(color: Colors.white)),
              );
            }).toList();
          },
          icon: Icon(Icons.arrow_drop_down, color: Colors.white),
          underline: Container(
            height: 0,
          ),
          elevation: 16,
          onChanged: (newValue) {
            if (type == 'language') {
              Provider.of<TrendProvider>(context, listen: false).changeLanguageState(newValue);
            } else {
              Provider.of<TrendProvider>(context, listen: false).changeSinceState(newValue);
            }
            print('newValue====$newValue');
          },
          items: list.map((e) => DropdownMenuItem(
            value: e.value,
            child: Text(e.name),
          )).toList(),
        )
      ),
    );
  }

}

// 趋势数据过滤显示
class TrendTypeModel {
  final String name;
  final String value;

  TrendTypeModel(this.name, this.value);
}
// 得到趋势时间数据
List trendTime() {
  return [
    TrendTypeModel('今日', 'deily'),
    TrendTypeModel('本周', 'weekly'),
    TrendTypeModel('本月', 'monthly'),
  ];
}

// 得到语言的数据
List trendLanguageType () {
  return [
    TrendTypeModel('全部', null),
    TrendTypeModel("Java", "Java"),
    TrendTypeModel("Kotlin", "Kotlin"),
    TrendTypeModel("Dart", "Dart"),
    TrendTypeModel("Objective-C", "Objective-C"),
    TrendTypeModel("Swift", "Swift"),
    TrendTypeModel("JavaScript", "JavaScript"),
    TrendTypeModel("PHP", "PHP"),
    TrendTypeModel("Go", "Go"),
    TrendTypeModel("C++", "C++"),
    TrendTypeModel("C", "C"),
    TrendTypeModel("HTML", "HTML"),
    TrendTypeModel("CSS", "CSS"),
    TrendTypeModel("Python", "Python"),
    TrendTypeModel("C#", "c%23"),
  ];
}