/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 00:50:37
 * @LastEditors: leo
 * @LastEditTime: 2020-06-04 10:29:08
 */
import 'package:flutter/material.dart';
import 'package:github_app/provider/user.dart';
import 'package:provider/provider.dart';


class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Future.delayed(const Duration(seconds: 3, microseconds: 500), () {
      Provider.of<UserProvider>(context, listen: false).initUserInfo().then((token) {
        if (token != null) {
          Navigator.pushNamed(context, '/home');
        } else {
          Navigator.pushNamed(context, '/login');
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return (
      Scaffold(
        body: Center(
          child: Text('欢迎光临!!!'),
        ),
      )
    );
  }
}
