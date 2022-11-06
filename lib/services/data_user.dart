import 'package:ceiba/helpers/http.dart';
import 'package:ceiba/models/post_model.dart';
import 'package:flutter/foundation.dart';

import '../models/user_model.dart';

class DataUser {
  final Http _http = Http(baseUrl: "https://jsonplaceholder.typicode.com");

  Future<List<UserModel>> users() async {
    final result =
        await _http.request<List<UserModel>>("/users", parser: (data) {
      List<UserModel> f = [];
      for (var i in data) {
        f.add(UserModel.fromJson(i));
      }
      return f;
    });

    return result.data!;
  }

  Future<List<PostModel>> userPost(String idUser) async {
    final result = await _http.request<List<PostModel>>("/posts",
        queryParameters: {"userId": idUser}, parser: (data) {
      List<PostModel> f = [];
      for (var i in data) {
        f.add(PostModel.fromJson(i));
      }
      return f;
    });

    return result.data!;
  }
}
