/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 00:18:19
 * @LastEditors: leo
 * @LastEditTime: 2020-06-03 22:22:34
 */ 
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commitStats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommitStats _$CommitStatsFromJson(Map<String, dynamic> json) {
  return CommitStats(
    json['total'] as int,
    json['additions'] as int,
    json['deletions'] as int,
  );
}

Map<String, dynamic> _$CommitStatsToJson(CommitStats instance) =>
    <String, dynamic>{
      'total': instance.total,
      'additions': instance.additions,
      'deletions': instance.deletions,
    };
