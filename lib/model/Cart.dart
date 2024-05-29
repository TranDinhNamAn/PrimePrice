import 'package:android/model/Product.dart';
//Nguyen Pham Quoc Tri
class Cart {
  // Thuộc tính của lớp Cart
  final Product product; // Sản phẩm
  int quantity; // Số lượng sản phẩm trong giỏ hàng

  // Constructor để khởi tạo một đối tượng Cart
  Cart({required this.product, this.quantity = 1});

  // Factory constructor để tạo một đối tượng Cart từ một đối tượng JSON
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      product: Product.fromJson(json['product']), // Chuyển đổi JSON thành đối tượng Product
      quantity: json['quantity'], // Lấy số lượng từ JSON
    );
  }

  // Phương thức để chuyển đổi một đối tượng Cart thành một đối tượng JSON
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(), // Chuyển đổi đối tượng Product thành JSON
      'quantity': quantity, // Số lượng sản phẩm
    };
  }

  // Phương thức lấy tên sản phẩm trong giỏ hàng
  String getProduct(){
    return this.product.productname; // Trả về tên sản phẩm
  }
}
