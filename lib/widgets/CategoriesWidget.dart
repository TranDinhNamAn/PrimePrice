import 'dart:convert';

import 'package:android/constan/constan.dart';
import 'package:android/model/Category.dart';
import 'package:android/pages/CategoryPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//Nguyen Pham Quoc Tri 
class CategoriesWidget extends StatefulWidget {
  // Tạo trạng thái mới cho CategoriesWidget
  State<CategoriesWidget> createState() => CategoriesWidgetState();
}

class CategoriesWidgetState extends State<CategoriesWidget> {
  // Danh sách các đối tượng Category
  List<Category> list = [];

  @override
  void initState() {
    super.initState();
    getCategory(); // Gọi hàm lấy danh sách Category khi khởi tạo widget
  }

  // Hàm lấy danh sách Category từ server
  Future getCategory() async {
    var res = await http.get(Uri.parse(serverUrl + "getcategory.php"));
    print(res.body);
    if (res.statusCode == 200) {
      // Nếu phản hồi thành công, chuyển đổi JSON thành danh sách Category
      Iterable l = json.decode(res.body);
      List<Category> posts = List<Category>.from(
        l.map((model) => Category.fromJson(model)),
      ).toList();
      setState(() {
        list.addAll(posts); // Cập nhật danh sách Category
        print(list);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Cuộn ngang
      child: Row(
        children: [
          // Hiển thị danh sách Category
          for (int i = 0; i < list.length; i++)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon của Category
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryPage(list[i]),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Image.network(
                        "${list[i].image}",
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                  // Tên của Category
                  Text(
                    "${list[i].name}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                ],
              ),
            ),
        
        ],
      ),
    );
  
  }
}
