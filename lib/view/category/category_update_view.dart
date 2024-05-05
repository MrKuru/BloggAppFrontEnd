import 'package:blog_app/data/models/response/category/category_dto.dart';
import 'package:blog_app/data/service/api_service.dart';
import 'package:flutter/material.dart';

class CategoryUpdate extends StatefulWidget {
  final String accessToken;
  final String categoryId;
  const CategoryUpdate(
      {super.key, required this.accessToken, required this.categoryId});

  @override
  State<CategoryUpdate> createState() => _CategoryUpdateState();
}

class _CategoryUpdateState extends State<CategoryUpdate> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffB81736),
        title: const Text(
          'Update Category',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Category Name',
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
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
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ApiService.instance.updateCategory(
                    CategoryDto(
                        name: _nameController.text,
                        description: _descriptionController.text),
                    widget.categoryId,
                    widget.accessToken);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xffB81736),
                onPrimary: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
