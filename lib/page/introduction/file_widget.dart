/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-10 14:45:07
 * @LastEditors: leo
 * @LastEditTime: 2020-06-10 21:39:31
 */ 

import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_app/models/fileModel.dart';
import 'package:github_app/page/code_detail_page_web.dart';
import 'package:github_app/page/introduction/introduction_page.dart';
import 'package:github_app/provider/repo.dart';
import 'package:provider/provider.dart';

class FileContainer extends StatefulWidget {
  final IntroductionArgsModel arguments;
  FileContainer(this.arguments);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FileContainerState();
  }
}

class _FileContainerState extends State<FileContainer> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(bottom: 15.0),
      child: FutureBuilder(
        future: Provider.of<RepoProvider>(context, listen: false).getRepoFileList(widget.arguments.repo),
        builder: (context, snapshot) {
          var list = Provider.of<RepoProvider>(context, listen: false).repoFileList;
          if (snapshot.hasData) {
            return EasyRefresh(
              child: ListView.separated(
                itemBuilder: (context, int index) {
                  return _buildItem(list[index], index);
                },
                itemCount: list.length,
                separatorBuilder: (context, int index) {
                  return Divider();
                },
              ),
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

  /// 编译item
  Widget _buildItem(FileModel fileModel, int index) {
    print('结果是====》》》》》》${fileModel.toJson().toString()}');
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, '/code-detail', arguments:
          CodeDetailModel(
            repoName: widget.arguments.repo,
            title: fileModel.name,
            path: fileModel.path
          )
        );
      },
      title: Text('${fileModel.name}'),
      leading: fileModel.type == 'dir' ? Icon(Icons.folder, color: Colors.deepPurple,) : Icon(Icons.insert_drive_file),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black26, size: ScreenUtil().setSp(32),),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
