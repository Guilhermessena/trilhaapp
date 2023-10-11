import 'package:trilhaapp/model/comments.dart';

abstract class CommentsRepository {
  Future<List<Comments>> getComments(int postId);
}
