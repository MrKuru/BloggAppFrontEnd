import '../comment/comment_dto.dart';

class PostDto {
  int? id;
  String? title;
  String? description;
  String? content;
  List<CommentDto>? comments;
  int? categoryId;

  PostDto(
      {this.id,
        this.title,
        this.description,
        this.content,
        this.comments,
        this.categoryId});

  PostDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    content = json['content'];
    if (json['comments'] != null) {
      comments = <CommentDto>[];
      json['comments'].forEach((v) {
        comments!.add(CommentDto.fromJson(v));
      });
    }
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['content'] = this.content;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['categoryId'] = this.categoryId;
    return data;
  }
}