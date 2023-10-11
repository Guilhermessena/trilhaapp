import 'package:trilhaapp/model/post.dart';
import 'package:trilhaapp/repository/jsonplaceholder_custom_dio.dart';
import 'package:trilhaapp/repository/posts/posts_repository.dart';

class PostsDioRepository implements PostsRepository {
  @override
  Future<List<Post>> getPosts() async {
    var jsonplaceholderCustomDio = JsonplaceholderCustomDio();
    var response = await jsonplaceholderCustomDio.dio.get('/posts');
    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Post.fromJson(e)).toList();
    }
    return [];
  }
}
