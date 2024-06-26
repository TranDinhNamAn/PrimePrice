import 'package:android/constan/constan.dart';
import 'package:android/model/Product.dart';
import 'package:android/widgets/CategoriesWidget.dart';
import 'package:android/widgets/ItemsWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductPage extends StatefulWidget {
  State<ProductPage> createState() => ProductPageState();
}

class ProductPageState extends State<ProductPage> {
  List<Product> list = [];
  List<Product> foundItem = [];

  Future getProduct() async {
    var res = await http.get(Uri.parse(serverUrl + "getloaisp.php"));
    print(res.body);
    if (res.statusCode == 200) {
      Iterable l = json.decode(res.body);
      List<Product> posts =
          List<Product>.from(l.map((model) => Product.fromJson(model)))
              .toList();
      setState(() {
        list.addAll(posts);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProduct();
    foundItem = list;
  }
  // Tim kiem san pham theo tu khoa
  // Thêm biến trạng thái để hiển thị thông báo khi không tìm thấy sản phẩm nào
  bool noResultsFound = false;

  void search(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        foundItem = list; // Hiển thị toàn bộ sản phẩm nếu từ khóa rỗng
        noResultsFound = false;
      } else {
        foundItem = list.where((product) {
          return product.productname
              .toLowerCase()
              .contains(keyword.toLowerCase()); // Lọc sản phẩm theo từ khóa
        }).toList();

        if (foundItem.isEmpty) {
          noResultsFound = true; // Hiển thị thông báo nếu không tìm thấy sản phẩm nào
        } else {
          noResultsFound = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Sản phẩm',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4C53A5),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.all(
                Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 50,
                        width: 250,
                        child: TextFormField(
                          onChanged: (value) {
                            print('typing');
                            search(value); // Gọi tìm kiếm khi nhập từ khóa
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Nhập tên sản phẩm cần tìm...",
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.search,
                        size: 27,
                        color: Color(0xFF4C53A5),
                      ),
                    ],
                  ),
                ),
                noResultsFound
                    ? Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Không tìm thấy sản phẩm phù hợp",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                )
                    : Container(),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                ),
                CategoriesWidget(), // Hiển thị danh sách danh mục sản phẩm
                ItemsWidget(products: foundItem), // Hiển thị danh sách sản phẩm tìm thấy
              ],
            ),
          ),
        ],
      ),
    );
  }
}
