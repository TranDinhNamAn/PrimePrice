import 'package:android/constan/constan.dart';
import 'package:android/data/CartData.dart';
import 'package:android/data/UserManager.dart';
import 'package:android/model/Cart.dart';
import 'package:android/model/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
//Tran Dinh Nam An
class CartBottomNavBar extends StatefulWidget {
  final VoidCallback onPressed;
  final int totalPrice;

  CartBottomNavBar(
      {Key? key, required this.onPressed, required this.totalPrice})
      : super(key: key);

  State<CartBottomNavBar> createState() => CartBottomNavBarState();
}

class MyEvent {
  final String message;

  MyEvent(this.message);
}

class CartBottomNavBarState extends State<CartBottomNavBar> {
  String selectedPaymentMethod = 'Credit Card';
  bool isDropdownExpanded = false;
  CartData cart = CartData();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 325,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Phương thức thanh toán: ",
                  style: TextStyle(
                    color: Color(0xFF4C53A5),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                DropdownButton<String>(
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                  ),
                  iconSize: 15,
                  value: selectedPaymentMethod,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPaymentMethod = newValue!;
                    });
                  },
                  items: <String>[
                    'Credit Card',
                    'PayPal',
                    'Cash on Delivery',
                    'Google Pay',
                    'Apple Pay',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value.length > 30
                            ? '${value.substring(0, 9)}...'
                            : value,
                        overflow: TextOverflow.ellipsis,
                        // Rút gọn chữ thành "asd..." nếu vượt quá độ dài 10 ký tự
                        softWrap: true, // Không tự động xuống dòng
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Địa chỉ: ",
                      style: TextStyle(
                        color: Color(0xFF4C53A5),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Đại học Nông Lâm tp.HCM",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4C53A5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Tổng tiền: ",
                  style: TextStyle(
                    color: Color(0xFF4C53A5),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${widget.totalPrice}",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF4C53A5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: widget.onPressed,
                child: Text(
                  "Thanh toán",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
