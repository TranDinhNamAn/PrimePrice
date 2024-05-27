import 'dart:convert';

import 'package:android/model/Cart.dart';
import 'package:android/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartData with ChangeNotifier {
  static String _keyProduct = 'product';
  static List<Product> productList = [];
  static List<Cart> cartList = [];

  static Future<void> saveProductList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String productJson = jsonEncode(productList);
    await prefs.setString('productList', productJson);
  }

  Future<List<Product>> getProductList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? productJson = prefs.getString('productList');
    if (productJson != null) {
      List<dynamic> productJsonList = jsonDecode(productJson);
      List<Product> productList =
          productJsonList.map((json) => Product.fromJson(json)).toList();
      return productList;
    } else {
      return [];
    }
  }

  static Future<void> saveCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartJson = jsonEncode(cartList);
    await prefs.setString('cartList', cartJson);
  }

  Future<List<Cart>> getCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartJson = prefs.getString('cartList');
    if (cartJson != null) {
      List<dynamic> cartJsonList = jsonDecode(cartJson);
      List<Cart> cartList =
          cartJsonList.map((json) => Cart.fromJson(json)).toList();
      return cartList;
    } else {
      return [];
    }
  }

  static Future<void> addProduct1(Product p) async {
    bool isProductExists =
        cartList.any((cart) => cart.product.productID == p.productID);
    if (!isProductExists) {
      Cart c = new Cart(product: p);
      cartList.add(c);
      await saveCartList();
      print("added");
    } else {
      increaseQuantity(p.productID);
      print("added more");
      await saveCartList();
    }
  }

  static Future<void> addProduct(Product p) async {
    bool isProductExists =
        productList.any((product) => product.productID == p.productID);
    if (!isProductExists) {
      productList.add(p);
      await saveProductList();
      print("added");
    } else {
      print("already added");
      await saveProductList();
    }
  }

  static Future<void> removeProduct1(int id) async {
    cartList.removeWhere((cart) => cart.product.productID == id);
    await saveProductList();
  }

  static Future<void> increaseQuantity(int id) async {
    Cart? cart = cartList.firstWhere((cart) => cart.product.productID == id);
    if (cart != null) {
      cart.quantity++;
      await saveProductList();
    }
  }

  static Future<void> decreaseQuantity(int id) async {
    Cart? cart = cartList.firstWhere((cart) => cart.product.productID == id);
    if (cart != null && cart.quantity > 1) {
      cart.quantity--;
      await saveProductList();
    }
  }

  static Future<void> removeProduct(int id) async {
    productList.removeWhere((product) => product.productID == id);
    await saveProductList();
  }

   Future<void> removeAllProduct() async {
    cartList.clear();
    await saveCartList();
  }

  int totalPrice(List<Cart> c) {
    int total = 0;
    for (int i = 0; i < c.length; i++) {
      total += cartList[i].product.price*cartList[i].quantity;
    }
    return total;
  }
  int totalQuantity(List<Cart> c) {
    int total = 0;
    for (int i = 0; i < c.length; i++) {
      total += cartList[i].quantity;
    }
    return total;
  }
}
