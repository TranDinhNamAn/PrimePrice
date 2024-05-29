import 'package:android/data/UserManager.dart'; // Quản lý người dùng
import 'package:android/pages/Login.dart'; // Màn hình đăng nhập
import 'package:flutter/cupertino.dart'; // Thư viện Flutter cho iOS
import 'package:flutter/material.dart'; // Thư viện Flutter cho Material Design
import 'package:android/pages/OrderPage.dart'; // Màn hình lịch sử đơn hàng

class SideNavBar extends StatelessWidget {
  @override

  //Nguyen Thanh Tu
  Widget build(BuildContext context) {
    return Drawer( // Widget Drawer tạo thanh điều hướng bên cạnh
      child: ListView(
        padding: EdgeInsets.zero, // Xóa phần đệm mặc định
        children: [
          UserAccountsDrawerHeader( // Đầu thanh điều hướng hiển thị thông tin người dùng
            accountName: Text(
              "name", // Tên tài khoản
            ),
            accountEmail: Text("Email"), // Email tài khoản
            currentAccountPicture: CircleAvatar( // Ảnh đại diện tài khoản
              child: ClipOval(
                child: Icon(
                  Icons.person, // Biểu tượng người dùng
                  size: 50,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFF4C53A5), // Màu nền của header
            ),
          ),
          ListTile( // Mục lịch sử đơn hàng
            leading: Icon(
              Icons.history,
              color: Color(0xFF4C53A5), // Màu biểu tượng
            ),
            title: Text(
              "Lịch sử đơn hàng",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () { // Xử lý khi mục này được nhấn
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderPage(), // Chuyển đến màn hình lịch sử đơn hàng
                ),
              );
            },
          ),
          ListTile( // Mục thông tin cá nhân
            leading: Icon(
              Icons.person,
              color: Color(0xFF4C53A5),
            ),
            title: Text(
              "Thông tin cá nhân",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {}, // Hiện tại chưa có chức năng
          ),
          ListTile( // Mục cài đặt
            leading: Icon(
              Icons.settings,
              color: Color(0xFF4C53A5),
            ),
            title: Text(
              "Cài đặt",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {}, // Hiện tại chưa có chức năng
          ),
          ListTile( // Mục đăng xuất
            leading: Icon(
              Icons.logout,
              color: Color(0xFF4C53A5),
            ),
            title: Text(
              "Đăng xuất",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () { // Xử lý khi nhấn đăng xuất
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginForm(), // Chuyển đến màn hình đăng nhập
                ),
              );
              UserManager.removeUser(); // Xóa thông tin người dùng
            },
          ),
        ],
      ),
    );
  }
}
