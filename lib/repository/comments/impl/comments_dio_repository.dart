import 'package:trilhaapp/model/comments.dart';
import 'package:trilhaapp/repository/comments/comments_repository.dart';
import 'package:trilhaapp/repository/jsonplaceholder_custom_dio.dart';

class CommentsDioRepository implements CommentsRepository {
  @override
  Future<List<Comments>> getComments(int postId) async {
    var jsonplaceholderCustomDio = JsonplaceholderCustomDio();
    var response =
        await jsonplaceholderCustomDio.dio.get('/posts/$postId/comments');
    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Comments.fromJson(e)).toList();
    }
    return [];
  }
}
