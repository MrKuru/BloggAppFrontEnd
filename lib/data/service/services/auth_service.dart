import 'dart:convert';
import '../../models/response/login/login_response.dart';
import 'package:http/http.dart' as http;

mixin AuthService {
  static const path = 'http://10.0.2.2:8080/api/v1/auth';

  Future<LoginResponse> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    final url = Uri.parse('$path/login');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'usernameOrEmail': usernameOrEmail,
        'password': password,
      }),
    );
    final Map<String, dynamic> responseData = json.decode(response.body);
    return LoginResponse.fromJson(responseData);
  }

  Future<void> register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$path/register');
    await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'username': username,
        'email': email,
        'password': password,
      }),
    );
  }
}
