/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 16:51:51
 * @LastEditors: leo
 * @LastEditTime: 2020-06-07 00:55:47
 */ 
import 'package:flutter/material.dart';
import 'package:github_app/provider/user.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() {
    // TODO: implement createState
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
                controller: _unameController,
                decoration: InputDecoration(
                  hintText: '请输入用户名',
                  prefixIcon: Icon(Icons.person)
                ),
                validator: (v) {
                  return v.trim().isNotEmpty ? null : '请输入用户名';
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
                controller: _pwdController,
                decoration: InputDecoration(
                  hintText: '请输入密码',
                  prefixIcon: Icon(Icons.lock)
                ),
                validator: (v) {
                  return v.trim().isNotEmpty ? null : '请输入密码';
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 10.0),
                    child: FlatButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        _login(context);
                      },
                      child: Text('登录', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: FlatButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {

                      },
                      child: Text('认证', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                )
              ],),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text('Designed by Xcxerxes'),
            )
          ],
        ),
      ),
    );
  }

  // 登录
  _login(BuildContext context) async {
    if ((_formKey.currentState as FormState).validate()) {
      try {
        String userName = _unameController.text;
        String password = _pwdController.text;
        _showLoading(context);
        var res = await Provider.of<UserProvider>(context, listen: false).login(userName, password);
        Navigator.of(context).pop();
        if (res != null && res.result) {
          Navigator.pushNamed(context, '/home');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  _showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // 点遮罩不关闭
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text('正在加载，请稍后...'),
              )
            ],
          ),
        );
      }
    );
  }
}
