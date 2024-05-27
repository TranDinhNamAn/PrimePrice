import 'package:flutter/material.dart';

class Order {
  int orderID;
  int quantity;
  int totalprice;
  String dateOrder;
  int userID;

  Order({
    required this.orderID,
    required this.quantity,
    required this.totalprice,
    required this.dateOrder,
    required this.userID,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderID: int.parse(json['orderID']),
      quantity: int.parse(json['quantity']),
      totalprice: int.parse(json['totalprice']),
      dateOrder: json['dateOrder'] as String,
      userID: int.parse(json['userID']),
    );
  }

  Map<String, dynamic> toJson() => {
        'orderID': orderID.toString(),
        'quantity': quantity.toString(),
        'totalprice': totalprice.toString(),
        'dateOrder': dateOrder,
        'userID': userID.toString(),
      };
}
