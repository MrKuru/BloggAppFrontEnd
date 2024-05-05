import 'package:blog_app/data/service/services/auth_service.dart';
import 'package:blog_app/data/service/services/category_service.dart';
import 'package:blog_app/data/service/services/comment_service.dart';
import 'package:blog_app/data/service/services/post_service.dart';

class ApiService
    with
        AuthService,
        CategoryService,
        PostService,
        CommentService
         {
  static final ApiService instance = ApiService();
}