import 'dart:convert';

import 'package:android/constan/constan.dart';
import 'package:android/model/Category.dart';
import 'package:android/pages/CategoryPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriesWidget extends StatefulWidget {
  State<CategoriesWidget> createState() => CategoriesWidgetState();
}
class CategoriesWidgetState extends State<CategoriesWidget> {
  List<Category> list = [];

  @override
  void initState() {
    super.initState();
    getCategory();
  }
  Future getCategory() async {
    var res = await http
        .get(Uri.parse(serverUrl+"getcategory.php"));
    print(res.body);
    if (res.statusCode == 200) {
      Iterable l = json.decode(res.body);
      List<Category> posts =
          List<Category>.from(l.map((model) => Category.fromJson(model)))
              .toList();
      setState(() {
        list.addAll(posts);
        print(list);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
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
