/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 00:18:19
 * @LastEditors: leo
 * @LastEditTime: 2020-06-03 22:22:24
 */ 
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloadSource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadSource _$DownloadSourceFromJson(Map<String, dynamic> json) {
  return DownloadSource(
    json['url'] as String,
    json['isSourceCode'] as bool,
    json['name'] as String,
    json['size'] as int,
  );
}

Map<String, dynamic> _$DownloadSourceToJson(DownloadSource instance) =>
    <String, dynamic>{
      'url': instance.url,
      'isSourceCode': instance.isSourceCode,
      'name': instance.name,
      'size': instance.size,
    };
