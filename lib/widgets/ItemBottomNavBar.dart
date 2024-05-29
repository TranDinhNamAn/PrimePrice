import 'package:android/data/CartData.dart';
import 'package:android/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//Nguyen Pham Quoc Tri
class ItemBottomNavBar extends StatefulWidget {
  // Constructor nhận vào một đối tượng Product
  ItemBottomNavBar(this.product);
  final Product product;

  // Tạo một trạng thái mới cho ItemBottomNavBar
  State<ItemBottomNavBar> createState() => ItemBottomNavBarState();
}

class ItemBottomNavBarState extends State<ItemBottomNavBar> {

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 125,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Màu bóng đổ
              spreadRadius: 3, // Độ lan tỏa bóng đổ
              blurRadius: 10, // Độ mờ bóng đổ
              offset: Offset(0, 3), // Vị trí bóng đổ
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Hiển thị giá sản phẩm
            Text(
              "\$${widget.product.price}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color(0xFF4C53A5),
              ),
            ),
            // Nút bấm thêm vào giỏ hàng
            ElevatedButton.icon(
              onPressed: () {
                CartData.addProduct1(widget.product); // Thêm sản phẩm vào giỏ hàng
                print("object");
              },
              icon: Icon(
                CupertinoIcons.cart_badge_plus,
                color: Colors.white,
              ),
              label: Text(
                "Thêm vào giỏ hàng",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF4C53A5)),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
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

