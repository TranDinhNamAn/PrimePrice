// Author Ngo Cu Van
import 'dart:core';

// Lớp Product đại diện cho một sản phẩm
class Product {
  int productID;
  String productname;
  String productimage;
  String description;
  int price;
  int quantity;
  int categoryID;

  // Constructor để khởi tạo đối tượng Product
  Product({
    required this.productID,
    required this.productname,
    required this.productimage,
    required this.description,
    required this.price,
    required this.quantity,
    required this.categoryID,
  });

  // Tạo đối tượng Product từ dữ liệu JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productID: int.parse(json['productID']),
      productname: json['productname'] as String,
      productimage: json['productimage'] as String,
      description: json['description'] as String,
      price: int.parse(json['price']),
      quantity: int.parse(json['quantity']),
      categoryID: int.parse(json['categoryID']),
    );
  }

  // Chuyển đổi đối tượng Product thành JSON
  Map<String, dynamic> toJson() => {
    'productID': productID.toString(),
    'productname': productname,
    'productimage': productimage,
    'description': description,
    'price': price.toString(),
    'quantity': quantity.toString(),
    'categoryID': categoryID.toString(),
  };
}