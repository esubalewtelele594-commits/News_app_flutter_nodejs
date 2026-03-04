class Categories {
  String name;
  String? icon;

  Categories({required this.name, this.icon});
  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(name: json['name'], icon: json['icon']);
  }
}
