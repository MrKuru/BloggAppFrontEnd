import 'dart:convert';
import 'package:blog_app/data/models/response/post/post_dto.dart';
import 'package:http/http.dart' as http;

mixin PostService {
  static const path = 'http://10.0.2.2:8080/api/v1/posts';


  Future<void> createPost(PostDto postDto, String authToken) async {
    final url = Uri.parse(path);
    await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(postDto.toJson()),
    );
  }

  Future<PostDto> updatePost(PostDto postDto, String id, String authToken) async {
    final url = Uri.parse('$path/$id');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(postDto.toJson()),
    );
    if (response.statusCode == 200) {
      return PostDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update post');
    }
  }

  Future<void> deletePostById(String id, String authToken) async {
    final url = Uri.parse('$path/$id');
    final response = await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete post');
    }
  }

  Future<List<PostDto>> getPostsByCategory(String categoryId) async {
    final url = Uri.parse('$path/category/$categoryId');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
      final List<dynamic> responseData = jsonDecode(response.body);
      List<PostDto> posts = responseData.map((data) => PostDto.fromJson(data)).toList();
      return posts;
  }
}
