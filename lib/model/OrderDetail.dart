import 'package:flutter/material.dart';

class OrderDetail {
  int orderID;
  int productQuantity;
  int productPrice;
  String productname;
  String productimage;

  OrderDetail({
    required this.orderID,
    required this.productQuantity,
    required this.productPrice,
    required this.productname,
    required this.productimage,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      orderID: int.parse(json['orderID']),
      productQuantity: int.parse(json['productQuantity']),
      productPrice: int.parse(json['productPrice']),
      productname: json['productname'] as String,
      productimage: json['productimage'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'orderID': orderID.toString(),
        'productQuantity': productQuantity.toString(),
        'productPrice': productPrice.toString(),
        'productname': productname,
        'productimage': productimage,
      };
}
