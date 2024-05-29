import 'dart:core';
//Nguyen Pham Quoc Tri
class Category {
  // Thuộc tính của lớp Category
  int categoryID;
  String name;
  String image;

  // Constructor để khởi tạo một đối tượng Category
  Category({
    required this.categoryID,
    required this.name,
    required this.image,
  });

  // Factory constructor để tạo một đối tượng Category từ một đối tượng JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryID: int.parse(json['categoryID']), // Chuyển đổi categoryID từ String sang int
      name: json['name'] as String, // Phân tích name thành String
      image: json['image'] as String, // Phân tích image thành String
    );
  }

  // Phương thức để chuyển đổi một đối tượng Category thành một đối tượng JSON
  Map<String, dynamic> toJson() => {
    'categoryID': categoryID.toString(), // Chuyển đổi categoryID từ int sang String
    'name': name,
    'image': image,
  }
}