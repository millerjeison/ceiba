@GenerateMocks([UserModel, PostModel])

import 'package:ceiba/models/post_model.dart';
import 'package:ceiba/models/user_model.dart';
import 'package:ceiba/services/data_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'functions_test.mocks.dart';

final MockUserModel user = MockUserModel();
final MockPostModel post = MockPostModel();

class MockProvider extends Mock implements DataUser {
  @override
  Future<List<MockUserModel>> users() async {
    return List.filled(10, user);
  }

  @override
  Future<List<MockPostModel>> userPost(userId) async {
    return List.filled(10, post);
  }
}

void main() {
  test('users', () async {
    var users = await MockProvider().users();
    expect(users, List<MockUserModel>.generate(10, (index) => user));
  });

  test('posts', () async {
    var posts = await MockProvider().userPost("1");
    expect(posts, List<MockPostModel>.generate(10, (index) => post));
  });
}
