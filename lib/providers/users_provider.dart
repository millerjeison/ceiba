import 'package:ceiba/models/post_model.dart';
import 'package:ceiba/models/posts_save.dart';
import 'package:ceiba/models/user_model.dart';
import 'package:ceiba/services/data_user.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UsersProvider extends ChangeNotifier {
  List<UserModel> _users = [];

  final DataUser _dataUser = DataUser();
  bool isUserLoading = false;
  bool isLoadPost = false;
  String error = '';
  bool errorBol = false;

  List<UserModel> get users => _users;

  Future getUser() async {
    List<PostsSave> pos = [];
    try {
      isUserLoading = true;
      var box = await Hive.openBox('hive');
      if (box.get('users') == null) {
        try {
          _users = await _dataUser.users();
          box.put('users', _users);
          for (var i in _users) {
            final p = await _dataUser.userPost(i.id.toString());
            pos.add(
                PostsSave.fromJson({"userId": i.id.toString(), "posts": p}));
          }
          box.put('posts', pos);
        } catch (e) {
          isUserLoading = true;
          errorBol = true;
          return null;
        }
      } else {
        List list = box.get('users');
        for (var element in list) {
          _users.add(element);
        }
      }
      notifyListeners();
    } catch (e) {
      // errorBol = true;

      isUserLoading = false;
      notifyListeners();
    }
  }

  List<PostModel> _posts = [];

  Future<List<PostModel>> getPost(String idUser) async {
    var box = await Hive.openBox('hive');
    List<PostModel> pos = [];
    try {
      pos = await _dataUser.userPost(idUser);
    } catch (e) {
      pos = [];
    }
    if (box.get('posts') == null) {
      box.put('posts', [
        PostsSave.fromJson({"userId": idUser, "posts": pos})
      ]);
    } else {
      bool existe = false;
      List list = [];
      list = box.get('posts');
      for (var element in list) {
        if (idUser == element.userId) {
          existe = true;
          // if (element.posts.isEmpty) {
          pos = element.posts;
          // }
        }
      }
      if (!existe) {
        list.add(PostsSave.fromJson({"userId": idUser, "posts": pos}));
      }
    }
    return pos;
  }

  // bool validar(List data, String idUser) {
  //   bool r = false;

  //   for (var i in data) {
  //     if (idUser == i["userId"]) {

  //     }
  //   }

  //   return r;
  // }
}
