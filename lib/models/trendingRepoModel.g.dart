/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 00:18:19
 * @LastEditors: leo
 * @LastEditTime: 2020-06-04 17:03:55
 */ 
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trendingRepoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendingRepoModel _$TrendingRepoModelFromJson(Map<String, dynamic> json) {
  return TrendingRepoModel(
    json['author'] as String,
    json['avatar'] as String,
    json['url'] as String,
    json['description'] as String,
    json['language'] as String,
    json['languageColor'] as String,
    json['meta'] as String,
    (json['contributors'] as List)?.map((e) => e as String)?.toList(),
    json['contributorsUrl'] as String,
    json['stars'] as int,
    json['name'] as String,
    json['reposName'] as String,
    json['forks'] as int,
    json['currentPeriodStars'] as int,
  );
}

Map<String, dynamic> _$TrendingRepoModelToJson(TrendingRepoModel instance) =>
    <String, dynamic>{
      'author': instance.author,
      'avatar': instance.avatar,
      'url': instance.url,
      'description': instance.description,
      'language': instance.language,
      'languageColor': instance.languageColor,
      'meta': instance.meta,
      'contributors': instance.contributors,
      'contributorsUrl': instance.contributorsUrl,
      'stars': instance.stars,
      'forks': instance.forks,
      'name': instance.name,
      'reposName': instance.reposName,
      'currentPeriodStars': instance.currentPeriodStars
    };
