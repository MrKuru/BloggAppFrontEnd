import 'package:blog_app/data/models/response/comment/comment_dto.dart';
import 'package:blog_app/data/service/api_service.dart';
import 'package:blog_app/view/comment/comment_create.dart';
import 'package:blog_app/view/comment/comment_update.dart';
import 'package:flutter/material.dart';

class CommentView extends StatefulWidget {
  final int postId;


  const CommentView(
      {Key? key, required this.postId})
      : super(key: key);

  @override
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  late List<CommentDto> _commentsFuture = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    setState(() {});
  }

  void fetchData() async {
    final List<CommentDto> fetchedComments =
    await ApiService.instance.getCommentsByPostId(widget.postId.toString());
    setState(() {
      _commentsFuture = fetchedComments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments', textAlign: TextAlign.center),
        centerTitle: true,
        backgroundColor: const Color(0xffB81736),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffB81736), Color(0xff281537)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: _commentsFuture.length,
          itemBuilder: (BuildContext context, int index) {
            final comment = _commentsFuture[index];
            return GestureDetector(
              onTap: () {},
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            comment.name.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CommentUpdate(
                                          postId: widget.postId.toString(),
                                        commentId: comment.id.toString(),
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                                color: Colors.grey,
                                iconSize: 20,
                              ),
                              IconButton(
                                onPressed: () {
                                  _showDeleteCommentDialog(
                                    widget.postId.toString(),
                                      comment.id.toString());
                                },
                                icon: const Icon(Icons.delete),
                                color: Colors.grey,
                                iconSize: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        comment.body.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CommentCreate(postId: widget.postId),
            ),
          );
        },
        backgroundColor: const Color(0xffB81736),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showDeleteCommentDialog(String postId, String commentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Are you sure you want to delete this comment?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ApiService.instance.deleteComment(postId.toString(), commentId.toString());
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Comment is deleted!')),
                );
                fetchData();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
