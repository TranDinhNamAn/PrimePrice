import 'package:android/model/Category.dart';
import 'package:android/widgets/BottomNavBar.dart';
import 'package:android/widgets/CategoriesWidget.dart';
import 'package:android/widgets/CategoryItems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage(this.category);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: Color(0xFF4C53A5),
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '${category.name}',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4C53A5),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            // height: 500,
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.all(
                Radius.circular(35),
                // topLeft: Radius.circular(35),
                // topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                CategoryItems(category: category),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
