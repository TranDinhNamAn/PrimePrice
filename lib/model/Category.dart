import 'dart:core';

class Category {
  int categoryID;
  String name;
  String image;

  Category({
    required this.categoryID,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryID: int.parse(json['categoryID']),
      name: json['name'] as String,
      image: json['image'] as String,
    );
  }
  Map<String, dynamic> toJson() => {
    'categoryID': categoryID.toString(),
    'name': name,
    'image': image,

  };
}
