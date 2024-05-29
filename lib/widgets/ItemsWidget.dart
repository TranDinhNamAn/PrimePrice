import 'package:android/constan/constan.dart';
import 'package:android/data/CartData.dart';
import 'package:android/model/Product.dart';
import 'package:android/pages/ItemPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//Nguyen Pham Quoc Tri
class ItemsWidget extends StatefulWidget {
  // Tạo trạng thái mới cho ItemsWidget
  State<ItemsWidget> createState() => ItemsWidgetState();
  List<Product> products = [];

  // Constructor nhận vào một danh sách Product
  ItemsWidget({required this.products});
}

class ItemsWidgetState extends State<ItemsWidget> {
  // Điều khiển cuộn cho GridView
  final ScrollController scrollController = ScrollController();
  List<Product> list = [];

  // Hàm lấy danh sách sản phẩm từ server
  Future getProduct() async {
    var res = await http.get(Uri.parse(serverUrl + "getloaisp.php"));
    if (res.statusCode == 200) {
      // Nếu phản hồi thành công, chuyển đổi JSON thành danh sách Product
      Iterable l = json.decode(res.body);
      List<Product> posts = List<Product>.from(
        l.map((model) => Product.fromJson(model)),
      ).toList();
      setState(() {
        list.addAll(posts); // Cập nhật danh sách sản phẩm
      });
    }
  }

  // Hàm lắng nghe sự kiện cuộn
  void _scrollListener() {
    // Kiểm tra nếu đã cuộn đến cuối danh sách thì lấy thêm sản phẩm
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getProduct();
    } else {
      print('scroll');
    }
  }

  @override
  void initState() {
    // Gọi hàm lấy danh sách sản phẩm khi khởi tạo widget
    super.initState();
    scrollController.addListener(_scrollListener);
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      controller: scrollController,
      childAspectRatio: 0.68,
      physics: NeverScrollableScrollPhysics(), // Ngăn việc cuộn bên trong GridView
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        // Hiển thị danh sách sản phẩm
        for (int i = 0; i < widget.products.length; i++)
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
                        builder: (context) => ItemPage(widget.products[i]),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Image.network(
                      "${widget.products[i].productimage}",
                      height: 80,
                      width: 120,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${widget.products[i].productname}",
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
                        "${widget.products[i].price}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF4C53A5),
                        ),
                      ),
                      // Nút thêm vào giỏ hàng
                      InkWell(
                        onTap: () {
                          CartData.addProduct1(widget.products[i]);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 1),
                              content: Text(
                                'Đã thêm sản phẩm vào giỏ hàng',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
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
