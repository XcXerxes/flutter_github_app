/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 00:18:19
 * @LastEditors: leo
 * @LastEditTime: 2020-06-03 22:11:31
 */ 
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';

part 'branch.g.dart';

abstract class Branch implements Built<Branch, BranchBuilder> {
  static Serializer<Branch> get serializer => _$branchSerializer;

  @nullable
  String get name;

  @nullable
  @BuiltValueField(wireName: 'tarball_url')
  String get tarballUrl;

  @nullable
  @BuiltValueField(wireName: 'zipball_url')
  String get zipballUrl;


  Branch._();
  factory Branch([void Function(BranchBuilder) updates]) = _$Branch;
}