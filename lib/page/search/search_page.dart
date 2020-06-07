import 'package:flutter/material.dart';
import 'package:github_app/widget/empty.dart';
import 'package:github_app/widget/search_bar.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar((String value) => _onSubmitted(value, context)),
      body: Center(
        child: Empty(),
      )
    );
  }
  // _onReresh(String value, context) {
  // }
  // _fetchData(String value, BuildContext context) async{
  //   var query = Provider.of<RepoProvider>(context, listen: false).searchQuery;
  //   query.q = value;
  //   Provider.of<RepoProvider>(context, listen: false).changeSearchState(query);
  // }
  // 搜索结果的回调
  _onSubmitted(String value, BuildContext context) async{
    if (value.length > 0) {
      Navigator.pushNamed(context, '/search-result', arguments: value);
    }
  }
}
