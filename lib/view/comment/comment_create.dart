import 'package:blog_app/data/models/response/category/category_dto.dart';
import 'package:blog_app/data/models/response/comment/comment_dto.dart';
import 'package:blog_app/data/models/response/post/post_dto.dart';
import 'package:blog_app/data/service/api_service.dart';
import 'package:flutter/material.dart';

class CommentCreate extends StatefulWidget {
  final int postId;
  const CommentCreate({super.key, required this.postId});

  @override
  State<CommentCreate> createState() => _CommentCreateState();
}

class _CommentCreateState extends State<CommentCreate> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Comment', textAlign: TextAlign.center),
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
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Name',
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
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Email',
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
                controller: _bodyController,
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
                  ApiService.instance.createComment(
                    widget.postId.toString(),
                      CommentDto(
                        name: _nameController.text,
                        body: _bodyController.text,
                        email: _emailController.text,
                      )
                  );
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
