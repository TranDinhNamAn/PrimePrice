import 'package:android/data/UserManager.dart';
import 'package:android/model/User.dart';
import 'package:android/pages/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:android/pages/OrderPage.dart';
class SideNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "name",
            ),
            accountEmail: Text("Email"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xFF4C53A5),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.history,
              color: Color(0xFF4C53A5),
            ),
            title: Text(
              "Lịch sử đơn hàng",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderPage(),
                ),
              );
            },
          ),
          ListTile(
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
            onTap: () {},
          ),
          ListTile(
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
            onTap: () {},
          ),
          ListTile(
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginForm(),
                ),
              );
              UserManager.removeUser();
            },
          ),
        ],
      ),
    );
  }
}
