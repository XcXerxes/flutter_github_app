/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-05 18:56:21
 * @LastEditors: leo
 * @LastEditTime: 2020-06-06 11:57:49
 */ 
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget with PreferredSizeWidget {
  final Function onChangeText;
  final Function onSubmitted;
  final Function onFilterPressed;
  SearchBar(this.onSubmitted, {this.onChangeText, this.onFilterPressed});
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String _searchValue = '';
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // 卸载时
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(4),
        child: Container(
          color: Colors.white70,
          height: 4,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back),
      ),
      title: _buildInput(),
      actions: _buildAction(),
    );
  }

  Widget _buildInput () {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.black12
          )
        )
      ),
      child: TextField(
        controller: _controller,
        autofocus: true,
        cursorColor: Colors.white,
        textInputAction: TextInputAction.search,
        onChanged: (val) {
          setState(() {
            _searchValue = val;
          });
          widget.onChangeText(val);
        },
        style: TextStyle(
          color: Colors.white
        ),
        onSubmitted: (String value) {
          widget.onSubmitted(value);
        },
        decoration: InputDecoration(
          hintText: '搜索关键字...',
          hintStyle: TextStyle(
            color: Colors.white70
          )
        ),
      ),
    );
  }

  _buildAction () {
    if (_searchValue.length > 0) {
      return <Widget>[
        IconButton(
          icon: Icon(Icons.clear, color: Colors.white),
          onPressed: () {
            _controller.text = _searchValue = '';
            _controller.clear();
          },
        )
      ];
    }
    return null;
  }
}
