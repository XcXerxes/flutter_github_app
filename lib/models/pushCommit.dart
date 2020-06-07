/*
 * @Description: 
 * @Author: leo
 * @Date: 2020-06-03 00:18:19
 * @LastEditors: leo
 * @LastEditTime: 2020-06-03 22:19:10
 */ 
import 'commitFile.dart';
import 'commitGitInfo.dart';
import 'commitStats.dart';
import 'user.dart';
import 'package:json_annotation/json_annotation.dart';

import 'repoCommit.dart';

/**
 * Created by guoshuyu
 * Date: 2018-07-31
 */

part 'pushCommit.g.dart';

@JsonSerializable()
class PushCommit {
  List<CommitFile> files;

  CommitStats stats;

  String sha;
  String url;
  @JsonKey(name: "html_url")
  String htmlUrl;
  @JsonKey(name: "comments_url")
  String commentsUrl;

  CommitGitInfo commit;
  User author;
  User committer;
  List<RepoCommit> parents;

  PushCommit(
    this.files,
    this.stats,
    this.sha,
    this.url,
    this.htmlUrl,
    this.commentsUrl,
    this.commit,
    this.author,
    this.committer,
    this.parents,
  );

  factory PushCommit.fromJson(Map<String, dynamic> json) => _$PushCommitFromJson(json);

  Map<String, dynamic> toJson() => _$PushCommitToJson(this);
}
