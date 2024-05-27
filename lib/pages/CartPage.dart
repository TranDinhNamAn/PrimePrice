import 'package:android/constan/constan.dart';
import 'package:android/data/CartData.dart';
import 'package:android/data/UserManager.dart';
import 'package:android/model/Cart.dart';
import 'package:android/model/User.dart';
import 'package:android/widgets/CartBottomNavBar.dart';
import 'package:flutter/material.dart';
import '../widgets/CartItemsSample.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  Future insertOrder() async {
    CartData cart = CartData();
    if(CartData.cartList.isNotEmpty) {
      List<Cart> list = CartData.cartList;
      String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      int price = cart.totalPrice(list);
      int quantity = cart.totalQuantity(list);
      UserModel? user = await UserManager.getUser();
      int userID = 0;
      if (user != null) {
        userID = user.userID;
      }
      print("price " +
          price.toString() +
          " sl " +
          quantity.toString() +
          " " +
          formattedDate.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: Text(
            'Bạn đã thanh toán thành công',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
      var res = await http.post(
        Uri.parse(serverUrl + "payment.php"),
        body: {
          "quantity": quantity.toString(),
          "totalprice": price.toString(),
          "dateOrder": formattedDate,
          "userID": userID.toString()
        },
      );
      if (res.statusCode == 200) {
        int orderID = int.parse(res.body);
        for (int i = 0; i < list.length; i++) {
          var res1 = await http.post(
            Uri.parse(serverUrl + "orderdetail.php"),
            body: {
              "orderID": orderID.toString(),
              "productID": list[i].product.productID.toString(),
              "productQuantity": list[i].quantity.toString(),
              "productPrice":
              (list[i].product.price * list[i].quantity).toString()
            },
          );
        }
      }
    }else{
      print('Cart have no product');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: Text(
            'Bạn chưa thêm sản phẩm vào giỏ hàng',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
  }

  Future<void> removeAll() async {
    await CartData().removeAllProduct();
    setState(() {});
  }

  int total = 0;

  Future<int> totalPrice() async {
    int newTotal = CartData().totalPrice(CartData.cartList);
    setState(() {
      total = newTotal;
    });

    return total;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          size: 30,
          color: Color(0xFF4C53A5), //change your color here
        ),
        title: Text(
          'Giỏ hàng',
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
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 15, bottom: 350),
            decoration: BoxDecoration(
                color: Color(0xFFECEDF2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                )),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CartItemsSample(totalPrice: totalPrice),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    padding: EdgeInsets.all(10),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: CartBottomNavBar(
          onPressed: () async {
            await insertOrder();
            await removeAll();
          },
          totalPrice: total),
    );
  }
}
