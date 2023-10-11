import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trilhaapp/model/post.dart';
import 'package:trilhaapp/repository/posts/posts_repository.dart';

class PostsHttpRepository implements PostsRepository{
  @override
  Future<List<Post>> getPosts() async {
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      var jsonPosts = jsonDecode(response.body);
      return (jsonPosts as List).map((e) => Post.fromJson(e)).toList();
    }
    return [];
  }
}
