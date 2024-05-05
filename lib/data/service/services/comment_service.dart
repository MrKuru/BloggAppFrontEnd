import 'dart:convert';
import 'package:blog_app/data/models/response/comment/comment_dto.dart';
import 'package:http/http.dart' as http;

mixin CommentService {
  static const String baseUrl = 'http://10.0.2.2:8080/api/v1';

  Future<CommentDto> createComment(String postId, CommentDto commentDto) async {
    final url = Uri.parse('$baseUrl/posts/$postId/comments');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(commentDto.toJson()),
    );
    if (response.statusCode == 201) {
      return CommentDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create comment');
    }
  }

  Future<List<CommentDto>> getCommentsByPostId(String postId) async {
    final url = Uri.parse('$baseUrl/posts/$postId/comments');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
      final List<dynamic> responseData = jsonDecode(response.body);
      List<CommentDto> comments = responseData.map((data) => CommentDto.fromJson(data)).toList();
      return comments;
  }

  Future<CommentDto> getCommentById(String postId, String commentId) async {
    final url = Uri.parse('$baseUrl/posts/$postId/comments/$commentId');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return CommentDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch comment by ID');
    }
  }

  Future<CommentDto> updateComment(String postId, String commentId, CommentDto commentDto) async {
    final url = Uri.parse('$baseUrl/posts/$postId/comments/$commentId');
    final response = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(commentDto.toJson()),
    );
    if (response.statusCode == 200) {
      return CommentDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update comment');
    }
  }

  Future<void> deleteComment(String postId, String id) async {
    final url = Uri.parse('$baseUrl/posts/$postId/comments/$id');
    await http.delete(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }
}
