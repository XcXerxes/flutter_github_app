/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 12:59:57
 * @LastEditors: leo
 * @LastEditTime: 2020-06-03 16:59:59
 */ 

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum _ColorTween { color1, color2 }
class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_ColorTween>()
      ..add(
        _ColorTween.color1,
        ColorTween(begin: Color(0xffD38312), end: Colors.deepPurple.shade900),
        Duration(seconds: 3)
      )
      ..add(
        _ColorTween.color2,
        ColorTween(begin: Color(0xffA83279), end: (Colors.deepPurple.shade600)),
        Duration(seconds: 3)
      );
    // TODO: implement build
    return MirrorAnimation<MultiTweenValues<_ColorTween>>(
      tween: tween,
      duration: tween.duration,
      builder: (context, animation, value) {
         return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [value.get<Color>(_ColorTween.color1), value.get<Color>(_ColorTween.color2)])),
        );
      },
    );
  }
}
