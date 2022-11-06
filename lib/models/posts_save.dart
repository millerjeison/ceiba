// To parse this JSON data, do
//
//     final postsSave = postsSaveFromJson(jsonString);

import 'dart:convert';

import 'post_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'posts_save.g.dart';

PostsSave postsSaveFromJson(String str) => PostsSave.fromJson(json.decode(str));

String postsSaveToJson(PostsSave data) => json.encode(data.toJson());

@HiveType(typeId: 6)
class PostsSave {
  PostsSave({
    this.userId,
    this.posts,
  });
  @HiveField(0)
  String? userId;
  @HiveField(1)
  List<PostModel>? posts;

  factory PostsSave.fromJson(Map<String, dynamic> json) => PostsSave(
        userId: json["userId"],
        posts: json["posts"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "posts":
            posts == null ? null : List<PostModel>.from(posts!.map((x) => x)),
      };
}
