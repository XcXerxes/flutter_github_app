/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-08 23:54:32
 * @LastEditors: leo
 * @LastEditTime: 2020-06-09 00:37:15
 */ 
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:github_app/page/introduction/introduction_page.dart';
import 'package:github_app/provider/repo.dart';
import 'package:provider/provider.dart';

class ReadmeContainer extends StatefulWidget {
  final IntroductionArgsModel arguments;
  ReadmeContainer(this.arguments);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ReadmeContainerState();
  }
}

class _ReadmeContainerState extends State<ReadmeContainer> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FutureBuilder(
        future: Provider.of<RepoProvider>(context, listen: false).getRepoReadmeInfo(widget.arguments.repo),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: MarkdownBody(
                    data: _getMarkDownData(Provider.of<RepoProvider>(context, listen: false).repoReadmeContent ?? '')
                  ),
                )
              ],
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

  _getMarkDownData(String markdownData) {
    ///优化图片显示
    RegExp exp = new RegExp(r'!\[.*\]\((.+)\)');
    RegExp expImg = new RegExp("<img.*?(?:>|\/>)");
    RegExp expSrc = new RegExp("src=[\'\"]?([^\'\"]*)[\'\"]?");

    String mdDataCode = markdownData;
    try {
      Iterable<Match> tags = exp.allMatches(markdownData);
      if (tags != null && tags.length > 0) {
        for (Match m in tags) {
          String imageMatch = m.group(0);
          if (imageMatch != null && !imageMatch.contains(".svg")) {
            String match = imageMatch.replaceAll("\)", "?raw=true)");
            if (!match.contains(".svg") && match.contains("http")) {
              ///增加点击
              String src = match
                  .replaceAll(new RegExp(r'!\[.*\]\('), "")
                  .replaceAll(")", "");
              String actionMatch = "[$match]($src)";
              match = actionMatch;
            } else {
              match = "";
            }
            mdDataCode = mdDataCode.replaceAll(m.group(0), match);
          }
        }
      }

      ///优化img标签的src资源
      tags = expImg.allMatches(markdownData);
      if (tags != null && tags.length > 0) {
        for (Match m in tags) {
          String imageTag = m.group(0);
          String match = imageTag;
          if (imageTag != null) {
            Iterable<Match> srcTags = expSrc.allMatches(imageTag);
            for (Match srcMatch in srcTags) {
              String srcString = srcMatch.group(0);
              if (srcString != null && srcString.contains("http")) {
                String newSrc = srcString.substring(
                        srcString.indexOf("http"), srcString.length - 1) +
                    "?raw=true";

                ///增加点击
                match = "[![]($newSrc)]($newSrc)";
              }
            }
          }
          mdDataCode = mdDataCode.replaceAll(imageTag, match);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return mdDataCode;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
