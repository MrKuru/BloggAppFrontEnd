class CommentDto {
  int? id;
  String? name;
  String? email;
  String? body;

  CommentDto({this.id, this.name, this.email, this.body});

  CommentDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['body'] = this.body;
    return data;
  }
}