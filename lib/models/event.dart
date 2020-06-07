/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 00:18:19
 * @LastEditors: leo
 * @LastEditTime: 2020-06-03 22:22:10
 */ 
import 'user.dart';
import 'package:json_annotation/json_annotation.dart';

import 'eventPayload.dart';
import 'repository.dart';

/**
 * Created by guoshuyu
 * Date: 2018-07-31
 */

part 'event.g.dart';

@JsonSerializable()
class Event {
  String id;
  String type;
  User actor;
  Repository repo;
  User org;
  EventPayload payload;
  @JsonKey(name: "public")
  bool isPublic;
  @JsonKey(name: "created_at")
  DateTime createdAt;

  Event(
    this.id,
    this.type,
    this.actor,
    this.repo,
    this.org,
    this.payload,
    this.isPublic,
    this.createdAt,
  );

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);

}
