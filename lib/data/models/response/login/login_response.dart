class LoginResponse {
  String? accessToken;
  String? tokenType;

  LoginResponse({this.accessToken, this.tokenType});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    tokenType = json['tokenType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = this.accessToken;
    data['tokenType'] = this.tokenType;
    return data;
  }
}