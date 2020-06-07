/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-05 10:19:53
 * @LastEditors: leo
 * @LastEditTime: 2020-06-05 23:35:48
 */ 
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_footer.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:github_app/provider/repo.dart';
import 'package:github_app/widget/repository/repository_item.dart';
import 'package:provider/provider.dart';

class RepositoryPage extends StatelessWidget {
  int page = 1;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('$args'),
      ),
      body: FutureBuilder(
        future: Provider.of<RepoProvider>(context, listen: false).getRepoList(args),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Consumer<RepoProvider>(
              builder: (context, repo, widget) {
                return EasyRefresh.custom(
                  header: PhoenixHeader(),
                  footer: PhoenixFooter(),
                  onRefresh: () async{
                    page = 1;
                    return Provider.of<RepoProvider>(context, listen: false).getRepoList(args, page: page);
                  },
                  onLoad: () async {
                    page++;
                    return Provider.of<RepoProvider>(context, listen: false).getRepoList(args, page: page);
                  },
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, int index) {
                          return RepositoryItem(repo.repoList[index]);
                        },
                        childCount: repo.repoList.length
                      ),
                    )
                  ],
                );
              },
            );
          }
          if(snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
  
  _refresh() async{
    
  }
}
