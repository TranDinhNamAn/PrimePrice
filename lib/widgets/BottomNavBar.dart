import 'package:android/pages/Homepage.dart'; // Import trang HomePage
import 'package:android/pages/ProductPage.dart'; // Import trang ProductPage
import 'package:curved_navigation_bar/curved_navigation_bar.dart'; // Import thư viện Curved Navigation Bar
import 'package:flutter/cupertino.dart'; // Import thư viện Flutter Cupertino
import 'package:flutter/material.dart'; // Import thư viện Flutter Material

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

//Nguyen Thanh Tu
  @override
  State<BottomNavBar> createState() => BottomNavBarState(); // Tạo trạng thái cho BottomNavBar
}

class BottomNavBarState extends State<BottomNavBar> {
  List Pages = [
    HomePage(), // Trang chủ
    ProductPage(), // Trang sản phẩm
  ];
  int selectedIndex = 0; // Chỉ số của trang được chọn

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: selectedIndex, // Chỉ số của mục được chọn
        backgroundColor: Colors.transparent, // Màu nền trong suốt
        onTap: (index){
          setState(() {
            selectedIndex = index; // Cập nhật chỉ số của trang được chọn
          });
        },
        height: 70, // Chiều cao của thanh điều hướng
        color: Color(0xFF4C53A5), // Màu của thanh điều hướng
        items: [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white, // Màu của icon
          ),
          Icon(
            CupertinoIcons.cart_fill,
            size: 30,
            color: Colors.white, // Màu của icon
          ),
        ],
      ),
      body: Pages[selectedIndex], // Hiển thị trang được chọn
    );
  }
}
