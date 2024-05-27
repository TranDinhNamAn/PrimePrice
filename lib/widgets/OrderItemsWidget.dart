import 'package:android/data/UserManager.dart';
import 'package:android/model/Order.dart';
import 'package:android/model/User.dart';
import 'package:android/pages/OrderDetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constan/constan.dart';

class OrderItemsWidget extends StatefulWidget {
  @override
  State<OrderItemsWidget> createState() => OrderItemsWidgetState();
}

class OrderItemsWidgetState extends State<OrderItemsWidget> {
  List<Order> list = [];
  ScrollController controller = ScrollController();
  int page = 0;
  bool hasMore = true;
  bool isLoading = false;
  int limit = 10;

  Future<void> getProduct() async {
    if (isLoading) return;
    isLoading = true;
    UserModel? user = await UserManager.getUser();
    int userID = 0;
    if (user != null) {
      userID = user.userID;
    }
    var url =
        serverUrl + "getorder.php"; // Thay đổi giá trị của limit trong URL
    var res = await http.post(Uri.parse(url),
        body: {"page": page.toString(), "userID": userID.toString()});
    if (res.statusCode == 200) {
      Iterable l = jsonDecode(res.body);
      List<Order> posts =
          List<Order>.from(l.map((model) => Order.fromJson(model)));
      setState(() {
        page++;
        isLoading = false;
        if (posts.isEmpty || posts.length < limit) {
          hasMore = false;
        }
        list.addAll(posts);
      });
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  void initState() {
    super.initState();
    getProduct();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        getProduct();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future refresh() async {
    setState(() {
      isLoading = false;
      hasMore = true;
      page = 0;
      list.clear();
    });
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refresh,
      child: ListView.builder(
        controller: controller,
        itemCount: list.length + 1,
        itemBuilder: (context, int index) {
          if (index < list.length) {
            final item = list[index];
            return Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xFFEDECF2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Đơn hàng: ${item.orderID}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF4C53A5),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Ngày đặt hàng: ${item.dateOrder}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF4C53A5),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 8, top: 8, left: 8, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tổng giá: ${list[index].totalprice}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF4C53A5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailPage(
                            detail: item.orderID,
                          ),
                        ),
                      );
                      print("object");
                    },
                    label: Text(
                      "Chi tiết",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    icon: Icon(
                      CupertinoIcons.arrow_right_square,
                      color: Colors.white,
                      size: 16,
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF4C53A5)),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),

                  //here
                ],
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: hasMore
                    ? CircularProgressIndicator()
                    : Text("No more data to load"),
              ),
            );
          }
        },
      ),
    );
  }
}
