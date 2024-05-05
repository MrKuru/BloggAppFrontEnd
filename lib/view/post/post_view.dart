import 'package:blog_app/data/models/response/post/post_dto.dart';
import 'package:blog_app/data/service/api_service.dart';
import 'package:blog_app/view/comment/comment_view.dart';
import 'package:blog_app/view/post/post_create_view.dart';
import 'package:blog_app/view/post/post_update_view.dart';
import 'package:flutter/material.dart';

class PostView extends StatefulWidget {
  final int categoryId;
  final String accessToken;

  const PostView(
      {Key? key, required this.categoryId, required this.accessToken})
      : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  late List<PostDto> _postsFuture = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    setState(() {});
  }

  void fetchData() async {
    final List<PostDto> fetchedPosts =
        await ApiService.instance.getPostsByCategory(widget.categoryId.toString());
    setState(() {
      _postsFuture = fetchedPosts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts', textAlign: TextAlign.center),
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
          itemCount: _postsFuture.length,
          itemBuilder: (BuildContext context, int index) {
            final post = _postsFuture[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentView(postId: post.id!.toInt()),
                  ),
                );
              },
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
                            post.title.toString(),
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
                                      builder: (context) => PostUpdate(
                                          accessToken: widget.accessToken,
                                          postId: post.id.toString(),
                                          categoryId:
                                              widget.categoryId.toInt()),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                                color: Colors.grey,
                                iconSize: 20,
                              ),
                              IconButton(
                                onPressed: () {
                                  _showDeletePostDialog(post.id.toString());
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
                        post.description.toString(),
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
              builder: (context) => PostCreate(
                  accessToken: widget.accessToken,
                  categoryId: widget.categoryId.toInt()),
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

  void _showDeletePostDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Are you sure you want to delete this post?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ApiService.instance.deletePostById(id, widget.accessToken);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Post is deleted!')),
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
