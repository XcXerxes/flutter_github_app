/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 00:18:19
 * @LastEditors: leo
 * @LastEditTime: 2020-06-03 22:23:08
 */ 
import 'package:json_annotation/json_annotation.dart';

/**
 * Created by guoshuyu
 * Date: 2018-07-31
 */

part 'commitGitUser.g.dart';

@JsonSerializable()
class CommitGitUser{
  String name;
  String email;
  DateTime date;

  CommitGitUser(this.name, this.email, this.date);

  factory CommitGitUser.fromJson(Map<String, dynamic> json) => _$CommitGitUserFromJson(json);


  Map<String, dynamic> toJson() => _$CommitGitUserToJson(this);
}
