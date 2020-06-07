/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 00:18:19
 * @LastEditors: leo
 * @LastEditTime: 2020-06-03 22:14:23
 */ 
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Template _$TemplateFromJson(Map<String, dynamic> json) {
  return Template(
    json['name'] as String,
    json['id'] as int,
    json['push_id'] as int,
  );
}

Map<String, dynamic> _$TemplateToJson(Template instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'push_id': instance.pushId,
    };
