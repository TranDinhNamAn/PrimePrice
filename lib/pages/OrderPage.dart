import 'package:android/widgets/OrderItemsWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            size: 30,
            color: Color(0xFF4C53A5), //change your color here
          ),
          title: Text(
            "Lịch sử mua hàng",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4C53A5),
            ),
          ),
        ),
        body: OrderItemsWidget()
    );
  }
}
