import 'package:blog_app/data/models/response/category/category_dto.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
mixin CategoryService {
  static const path = 'http://10.0.2.2:8080/api/v1/categories';


  Future<List<CategoryDto>> getAllCategory() async {
    final url = Uri.parse(path);
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final List<dynamic> responseData = json.decode(response.body);
    List<CategoryDto> categories = responseData.map((data) => CategoryDto.fromJson(data)).toList();
    return categories;
  }

  Future<void> deleteCategory(String categoryId, String authToken) async {
    final url = Uri.parse('$path/$categoryId');
    await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
    );
  }

  Future<void> updateCategory(CategoryDto categoryDto, String categoryId, String authToken) async {
    final url = Uri.parse('$path/$categoryId');
    await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(categoryDto.toJson()),
    );
  }

  Future<void> addCategory(CategoryDto categoryDto, String authToken) async {
    final url = Uri.parse(path);
    await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(categoryDto.toJson()),
    );
  }
}