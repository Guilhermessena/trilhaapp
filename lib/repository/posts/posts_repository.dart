import 'package:trilhaapp/model/post.dart';

abstract class PostsRepository {
  Future<List<Post>> getPosts();
  
}