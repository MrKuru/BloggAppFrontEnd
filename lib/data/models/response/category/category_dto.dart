class CategoryDto {
  int? id;
  String? name;
  String? description;

  CategoryDto({this.id, this.name, this.description});

  CategoryDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}
