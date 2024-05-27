import 'package:android/constan/constan.dart';
import 'package:android/model/OrderDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderDetailPage extends StatefulWidget {
  OrderDetailPage({required this.detail});
  final int detail;
  State<OrderDetailPage> createState() => OrderDetailPageState();
}
class OrderDetailPageState extends State<OrderDetailPage> {
  List<OrderDetail> detailList = [];

  Future getOrderDetail() async {
    var res = await http.post(
        Uri.parse(serverUrl+"/getorderdetail.php"),
        body: {"orderID": widget.detail.toString()});
        print(res.body);
    if (res.statusCode == 200) {
      Iterable l = json.decode(res.body);
      List<OrderDetail> posts =
      List<OrderDetail>.from(l.map((model) => OrderDetail.fromJson(model)))
          .toList();
      setState(() {
        detailList.addAll(posts);
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getOrderDetail();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(
          'Chi tiết đơn hàng',
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
            height: 800,
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.all(
                Radius.circular(35),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < detailList.length; i++)
                    Container(
                      height: 110,
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            value: "",
                            groupValue: "",
                            activeColor: Color(0xFF4C53A5),
                            onChanged: (index) {},
                          ),
                          Container(
                            height: 55,
                            width: 55,
                            margin: EdgeInsets.only(right: 15),
                            child: Image.network(
                                "${detailList[i].productimage}"),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${detailList[i].productname}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Color(0xFF4C53A5),
                                  ),
                                ),
                                Text(
                                  "\$${detailList[i].productPrice}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4C53A5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        "${detailList[i].productQuantity}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4C53A5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
