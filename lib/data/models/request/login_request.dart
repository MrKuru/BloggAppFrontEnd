class LoginRequest {
  String usernameOrEmail;
  String password;

  LoginRequest({
    required this.usernameOrEmail,
    required this.password,
  });
}