import 'dart:convert';

import 'package:trilhaapp/model/comments.dart';
import 'package:http/http.dart' as http;
import 'package:trilhaapp/repository/comments/comments_repository.dart';

class CommentsHttpRepository implements CommentsRepository{
  @override
  Future<List<Comments>> getComments(int postId) async {
    var response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts/$postId/comments'));
    if (response.statusCode == 200) {
      var jsonComment = jsonDecode(response.body);
      return (jsonComment as List).map((e) => Comments.fromJson(e)).toList();
    }
    return [];
  }
}
