import 'package:android/model/Product.dart';
import 'package:android/pages/CartPage.dart';
import 'package:android/pages/Homepage.dart';
import 'package:android/pages/ItemPage.dart';
import 'package:android/pages/Login.dart';
import 'package:android/pages/ProductPage.dart';
import 'package:android/widgets/BottomNavBar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {

        "/" : (context) => LoginForm(),
        "navBar" : (context) => BottomNavBar(),
        "homePage" : (context) => HomePage(),
        "cartPage" : (context) => CartPage(),
        "productPage" : (context) => ProductPage(),
      },
    );
  }
}
