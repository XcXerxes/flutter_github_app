/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 16:27:46
 * @LastEditors: leo
 * @LastEditTime: 2020-06-03 16:34:05
 */ 
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {
  final String src;
  final double width;
  final double height;
  final BoxFit fit;

  CacheImage(this.src, {this.width, this.height, this.fit = BoxFit.fill});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: src,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
