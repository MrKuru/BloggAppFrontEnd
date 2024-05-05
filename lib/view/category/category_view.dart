import 'package:blog_app/data/models/response/category/category_dto.dart';
import 'package:blog_app/data/service/api_service.dart';
import 'package:blog_app/view/category/category_create_view.dart';
import 'package:blog_app/view/category/category_update_view.dart';
import 'package:blog_app/view/post/post_view.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final String accessToken;

  const CategoryPage({Key? key, required this.accessToken}) : super(key: key);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late List<CategoryDto> _categories = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    setState(() {});
  }

  void fetchData() async {
    final List<CategoryDto> fetchedCategories =
        await ApiService.instance.getAllCategory();
    setState(() {
      _categories = fetchedCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories', textAlign: TextAlign.center),
        centerTitle: true,
        backgroundColor: const Color(0xffB81736),
        leading: IconButton(
          icon: const Icon(Icons.close),
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
        child: ListView.builder(
          itemCount: _categories.length,
          itemBuilder: (BuildContext context, int index) {
            final category = _categories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostView(
                        accessToken: widget.accessToken,
                        categoryId: category.id!.toInt()),
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
                            category.name.toString(),
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
                                      builder: (context) => CategoryUpdate(
                                          accessToken: widget.accessToken,
                                          categoryId: category.id.toString()),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit),
                                color: Colors.grey,
                                iconSize: 20,
                              ),
                              IconButton(
                                onPressed: () {
                                  _showDeleteCategoryDialog(
                                      category.id.toString());
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
                        category.description.toString(),
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
              builder: (context) =>
                  CategoryCreate(accessToken: widget.accessToken),
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

  void _showDeleteCategoryDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm'),
          content: const Text('Are you sure you want to delete this category?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                ApiService.instance.deleteCategory(id, widget.accessToken);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Category is deleted!')),
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
