import 'package:flutter/material.dart';
import 'package:trilhaapp/model/comments.dart';
import 'package:trilhaapp/repository/comments/comments_repository.dart';
import 'package:trilhaapp/repository/comments/impl/comments_dio_repository.dart';

class CommentsPage extends StatefulWidget {
  final int postId;
  const CommentsPage({super.key, required this.postId});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  late CommentsRepository commentsRepository;
  var comments = <Comments>[];

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  carregarDados() async {
    commentsRepository = CommentsDioRepository();
    comments = await commentsRepository.getComments(widget.postId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Comentarios do post ${widget.postId}'),
      ),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: comments.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    var comment = comments[index];
                    return Card(
                        child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(comment.name?.substring(0, 6) ?? ''),
                              Text(comment.email ?? ''),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(comment.body ?? ''),
                        ],
                      ),
                    ));
                  },
                )),
    ));
  }
}
