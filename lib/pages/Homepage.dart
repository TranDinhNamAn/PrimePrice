import 'dart:convert';
import 'package:android/constan/constan.dart';
import 'package:android/model/Product.dart';
import 'package:android/widgets/SideNavBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/CategoriesWidget.dart';
import '../widgets/HomeAppBar.dart';
import '../widgets/ItemsWidget.dart';

class HomePage extends StatefulWidget {
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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

  void search(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        // Nếu từ khóa tìm kiếm rỗng, hiển thị toàn bộ danh sách sản phẩm
        foundItem = list;
      } else {
        // Nếu có từ khóa tìm kiếm, lọc danh sách sản phẩm dựa trên từ khóa đó
        foundItem = list.where((product) {
          return product.productname
              .toLowerCase()
              .contains(keyword.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: HomeAppBar(),
        titleSpacing: -5,
      ),
      drawer: SideNavBar(),
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
                            search(value);
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
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  //search
                  child: Text(
                    "Categories",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                ),
                CategoriesWidget(),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    "Best Selling",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                ),
                ItemsWidget(products: foundItem),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
