import 'package:android/constan/constan.dart';
import 'package:android/data/CartData.dart';
import 'package:android/model/Category.dart';
import 'package:android/model/Product.dart';
import 'package:android/pages/ItemPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//Nguyen Pham Quoc Tri
class CategoryItems extends StatefulWidget {
  // Tạo trạng thái mới cho CategoryItems
  State<CategoryItems> createState() => CategoryItemsState();
  final Category category;

  // Constructor nhận vào một đối tượng Category
  CategoryItems({required this.category});
  List<Product> list = [];
}

class CategoryItemsState extends State<CategoryItems> {
  // Hàm lấy danh sách sản phẩm từ server
  Future getProduct() async {
    var res = await http.get(Uri.parse(serverUrl + "getloaisp.php"));
    print(res.body);
    if (res.statusCode == 200) {
      // Nếu phản hồi thành công, chuyển đổi JSON thành danh sách Product
      Iterable l = json.decode(res.body);
      List<Product> posts = List<Product>.from(
        l.map((model) => Product.fromJson(model)),
      ).toList();
      setState(() {
        // Lọc các sản phẩm thuộc Category hiện tại
        for (int i = 0; i < posts.length; i++) {
          if (posts[i].categoryID == widget.category.categoryID) {
            widget.list.add(posts[i]);
          }
        }
      });
    }
  }

  @override
  void initState() {
    // Gọi hàm lấy danh sách sản phẩm khi khởi tạo widget
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.68,
      physics: NeverScrollableScrollPhysics(), // Ngăn việc cuộn bên trong GridView
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        // Hiển thị danh sách sản phẩm
        for (int i = 0; i < widget.list.length; i++)
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xFF4C53A5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ],
                ),
                // Icon của Product
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemPage(widget.list[i]),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Image.network(
                      "${widget.list[i].productimage}",
                      height: 80,
                      width: 120,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${widget.list[i].productname}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.list[i].price}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF4C53A5),
                        ),
                      ),
                      // Nút thêm vào giỏ hàng
                      InkWell(
                        onTap: () {
                          CartData.addProduct(widget.list[i]);
                        },
                        child: Icon(
                          Icons.shopping_cart_checkout,
                          color: Color(0xFF4C53A5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

