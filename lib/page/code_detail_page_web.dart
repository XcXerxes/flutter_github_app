import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:github_app/services/address.dart';
import 'package:github_app/services/dio.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CodeDetailPageWeb extends StatefulWidget {
  final CodeDetailModel arguments;
  CodeDetailPageWeb(this.arguments);
  @override
  _CodeDetailPageWebState createState() => _CodeDetailPageWebState();
}

class _CodeDetailPageWebState extends State<CodeDetailPageWeb> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  Future<String> _init() async{
    try {
      var res = await httpManager.netFetch(
        Address.reposFileDir(widget.arguments.repoName, widget.arguments.path),
        null,
        {"Accept": 'application/vnd.github.html'},
        Options(contentType: 'text')
      );
      if(res != null && res.result) {
        String data2 = resolveHtmlFile(res, "java");
        String url = Uri.dataFromString(data2,
              mimeType: 'text/html', encoding: Encoding.getByName("utf-8"))
          .toString();
        print('url>>>>>$url');
        return url;
      }
    } catch (e) {
      print(e);
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.arguments.title}'),
      ),
      body: Container(
        width: double.infinity,
        child: FutureBuilder(
          future: _init(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print('输出内容为-===========${snapshot.data}');
              return WebView(
                initialUrl: snapshot.data,
                javascriptMode: JavascriptMode.unrestricted,
              );
            }
            if(snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ) 
      ),
    );
  }

  resolveHtmlFile(var res, String defaultLang) {
    if (res != null && res.result) {
      String startTag = "class=\"instapaper_body ";
      int startLang = res.data.indexOf(startTag);
      int endLang = res.data.indexOf("\" data-path=\"");
      String lang;
      if (startLang >= 0 && endLang >= 0) {
        String tmpLang =
            res.data.substring(startLang + startTag.length, endLang);
        if (tmpLang != null) {
          lang = formName(tmpLang.toLowerCase());
        }
      }
      if (lang == null) {
        lang = defaultLang;
      }
      if ('markdown' == lang) {
        return generateHtml(res.data, backgroundColor: '#ececec');
      } else {
        return generateCode2HTml(res.data,
            backgroundColor: '#ececec',
            lang: lang);
      }
    } else {
      return "<h1>" + "Not Support" + "</h1>";
    }
  }

  generateCode2HTml(String mdData,
      {String backgroundColor = '#ececec',
      String lang = 'java',
      userBR = true}) {
    String currentData = (mdData != null && mdData.indexOf("<code>") == -1)
        ? "<body>\n" +
            "<pre class=\"pre\">\n" +
            "<code lang='$lang'>\n" +
            mdData +
            "</code>\n" +
            "</pre>\n" +
            "</body>\n"
        : "<body>\n" +
            "<pre class=\"pre\">\n" +
            mdData +
            "</pre>\n" +
            "</body>\n";
    return generateHtml(currentData,
        backgroundColor: backgroundColor, userBR: userBR);
  }
  formName(name) {
    switch (name) {
      case 'sh':
        return 'shell';
      case 'js':
        return 'javascript';
      case 'kt':
        return 'kotlin';
      case 'c':
      case 'cpp':
        return 'cpp';
      case 'md':
        return 'markdown';
      case 'html':
        return 'xml';
    }
    return name;
  }

  generateHtml(String mdData,
      {String backgroundColor = '#ececec',
      userBR = true}) {
    if (mdData == null) {
      return "";
    }
    String mdDataCode = mdData;
    String regExCode =
        "<[\\s]*?code[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?code[\\s]*?>";
    String regExPre =
        "<[\\s]*?pre[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?pre[\\s]*?>";

    try {
      RegExp exp = new RegExp(regExCode);
      Iterable<Match> tags = exp.allMatches(mdData);
      for (Match m in tags) {
        String match = m.group(0).replaceAll(new RegExp("\n"), "\n\r<br>");
        mdDataCode = mdDataCode.replaceAll(m.group(0), match);
      }
    } catch (e) {
      print(e);
    }
    try {
      RegExp exp = new RegExp(regExPre);
      Iterable<Match> tags = exp.allMatches(mdDataCode);
      for (Match m in tags) {
        if (m.group(0).indexOf("<code>") < 0) {
          String match = m.group(0).replaceAll(new RegExp("\n"), "\n\r<br>");
          mdDataCode = mdDataCode.replaceAll(m.group(0), match);
        }
      }
    } catch (e) {
      print(e);
    }

    try {
      RegExp exp = new RegExp("<pre>(([\\s\\S])*?)<\/pre>");
      Iterable<Match> tags = exp.allMatches(mdDataCode);
      for (Match m in tags) {
        if (m.group(0).indexOf("<code>") < 0) {
          String match = m.group(0).replaceAll(new RegExp("\n"), "\n\r<br>");
          mdDataCode = mdDataCode.replaceAll(m.group(0), match);
        }
      }
    } catch (e) {
      print(e);
    }
    try {
      RegExp exp = new RegExp("href=\"(.*?)\"");
      Iterable<Match> tags = exp.allMatches(mdDataCode);
      for (Match m in tags) {
        String capture = m.group(0);
        if (capture.indexOf("http://") < 0 &&
            capture.indexOf("https://") < 0 &&
            capture.indexOf("#") != 0) {
          mdDataCode =
              mdDataCode.replaceAll(m.group(0), "gsygithub://" + capture);
        }
      }
    } catch (e) {
      print(e);
    }

    return generateCodeHtml(mdDataCode, false,
        backgroundColor: backgroundColor,
        actionColor: '#000',
        userBR: userBR);
  }

  generateCodeHtml(mdHTML, wrap,
      {backgroundColor = '#ececec',
      actionColor = '#000',
      userBR = true}) {
    return "<html>\n" +
        "<head>\n" +
        "<meta charset=\"utf-8\" />\n" +
        "<title></title>\n" +
        "<meta name=\"viewport\" content=\"width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;\"/>" +
        "<meta name=\“app-mobile-web-app-capable\”  content=\“yes\" /> " +
        "<link href=\"https:\/\/cdn.bootcss.com/highlight.js/9.12.0/styles/dracula.min.css\" rel=\"stylesheet\">\n" +
        "<script src=\"https:\/\/cdn.bootcss.com/highlight.js/9.12.0/highlight.min.js\"></script>  " +
        "<script>hljs.configure({'useBR': " +
        userBR.toString() +
        "});hljs.initHighlightingOnLoad();</script> " +
        "<style>" +
        "body{background: " +
        backgroundColor +
        "; margin:0; padding: 0;}" +
        "a {color:" +
        actionColor +
        " !important;}" +
        ".highlight pre, pre {" +
        " word-wrap: " +
        (wrap ? "break-word" : "normal") +
        "; " +
        " white-space: " +
        (wrap ? "pre-wrap" : "pre") +
        "; " +
        "}" +
        "thead, tr {" +
        "background:" +
        '#ececec' +
        ";}" +
        "td, th {" +
        "padding: 5px 10px;" +
        "font-size: 12px;" +
        "direction:hor" +
        "}" +
        ".highlight {overflow: scroll; background: " +
        '#ececec' +
        "}" +
        "tr:nth-child(even) {" +
        "background:" +
        '#ececec' +
        ";" +
        "color:" +
        '#ececec' +
        ";" +
        "}" +
        "tr:nth-child(odd) {" +
        "background: " +
        '#ececec' +
        ";" +
        "color:" +
        '#ececec' +
        ";" +
        "}" +
        "th {" +
        "font-size: 14px;" +
        "color:" +
        '#ececec' +
        ";" +
        "background:" +
        '#ececec' +
        ";" +
        "}" +
        "</style>" +
        "</head>\n" +
        "<body>\n" +
        mdHTML +
        "</body>\n" +
        "</html>";
  }


}


class CodeDetailModel {
  String title;
  String repoName;
  String path;

  CodeDetailModel({
    this.title,
    this.repoName,
    this.path
  });
}
