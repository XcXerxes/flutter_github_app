/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 00:53:35
 * @LastEditors: leo
 * @LastEditTime: 2020-06-04 17:35:41
 */ 
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_footer.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:github_app/page/trend/trend_item_widget.dart';
import 'package:github_app/page/trend/trend_top_widget.dart';
import 'package:github_app/provider/trend.dart';
import 'package:provider/provider.dart';

class TrendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(235, 235, 235, 1),
      child: FutureBuilder(
        future: Provider.of<TrendProvider>(context, listen: false).getTrendList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Consumer<TrendProvider>(
              builder: (context, trend, widget) {
                print(trend.trendList);
                return EasyRefresh.custom(
                  header: PhoenixHeader(),
                  footer: PhoenixFooter(),
                  onRefresh: () {

                  },
                  onLoad: () {
                    
                  },
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: TrendTop(),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return TrendItem(trend.trendList[index]);
                        },
                        childCount: trend.trendList.length
                      ),
                    )
                  ],
                );
              },
            );
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }
}
