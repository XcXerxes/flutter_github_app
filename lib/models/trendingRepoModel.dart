/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 00:18:19
 * @LastEditors: leo
 * @LastEditTime: 2020-06-04 16:59:08
 */ 
import 'package:json_annotation/json_annotation.dart';

/**
 * Created by guoshuyu
 * Date: 2018-08-07
 */
part 'trendingRepoModel.g.dart';

@JsonSerializable()
class TrendingRepoModel {
  String author;
  String url;
  String avatar;

  String description;
  String language;
  String languageColor;
  String meta;
  List<String> contributors;
  String contributorsUrl;

  int stars;
  int forks;
  int currentPeriodStars;
  String name;

  String reposName;

  TrendingRepoModel(
    this.author,
    this.url,
    this.avatar,
    this.description,
    this.language,
    this.languageColor,
    this.meta,
    this.contributors,
    this.contributorsUrl,
    this.stars,
    this.name,
    this.reposName,
    this.forks,
    this.currentPeriodStars
  );

  TrendingRepoModel.empty();

  factory TrendingRepoModel.fromJson(Map<String, dynamic> json) => _$TrendingRepoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrendingRepoModelToJson(this);
}
