import 'package:blog_app/data/models/response/category/category_dto.dart';
import 'package:blog_app/data/models/response/post/post_dto.dart';
import 'package:blog_app/data/service/api_service.dart';
import 'package:flutter/material.dart';

class PostUpdate extends StatefulWidget {
  final String accessToken;
  final String postId;
  final int categoryId;
  const PostUpdate({super.key, required this.accessToken, required this.postId, required this.categoryId});

  @override
  State<PostUpdate> createState() => _PostUpdateState();
}

class _PostUpdateState extends State<PostUpdate> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Post', textAlign: TextAlign.center),
        centerTitle: true,
        backgroundColor: const Color(0xffB81736),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffB81736), Color(0xff281537)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _contentController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Content',
                  labelStyle: TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ApiService.instance.updatePost(
                      PostDto(
                        title: _titleController.text,
                        description: _descriptionController.text,
                        content: _contentController.text,
                        categoryId: widget.categoryId
                      ),
                      widget.postId.toString(),
                      widget.accessToken);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffB81736),
                ),
                child: const Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
