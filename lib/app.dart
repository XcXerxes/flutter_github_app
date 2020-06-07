/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 19:20:01
 * @LastEditors: leo
 * @LastEditTime: 2020-06-05 15:26:11
 */ 
import 'package:flutter/material.dart';
import 'package:github_app/page/login/login_page.dart';
import 'package:github_app/page/welcome_page.dart';
import 'package:github_app/provider/event_receive.dart';
import 'package:github_app/provider/profile.dart';
import 'package:github_app/provider/repo.dart';
import 'package:github_app/provider/trend.dart';
import 'package:github_app/provider/user.dart';
import 'package:github_app/routes/routes.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: EventReceiveProvider()),
        ChangeNotifierProvider.value(value: TrendProvider()),
        ChangeNotifierProvider.value(value: RepoProvider()),
        ChangeNotifierProvider.value(value: ProfileProvider()),
      ],
      child: MaterialApp(
      title: 'Github App',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.deepPurple,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: AppRoutes.routes,
        home: WelcomePage(),
      ),
    );
  }
}
