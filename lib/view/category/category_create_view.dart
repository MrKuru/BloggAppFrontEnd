import 'package:blog_app/data/models/response/category/category_dto.dart';
import 'package:blog_app/data/service/api_service.dart';
import 'package:flutter/material.dart';

class CategoryCreate extends StatefulWidget {
  final String accessToken;
  const CategoryCreate({super.key, required this.accessToken});

  @override
  State<CategoryCreate> createState() => _CategoryCreateState();
}

class _CategoryCreateState extends State<CategoryCreate> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Category', textAlign: TextAlign.center),
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
              ElevatedButton(
                onPressed: () {
                  ApiService.instance.addCategory(
                      CategoryDto(
                        name: _nameController.text,
                        description: _descriptionController.text
                  ), widget.accessToken);
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
