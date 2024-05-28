import 'package:android/data/CartData.dart';
import 'package:android/model/Cart.dart';
import 'package:android/model/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//Tran Dinh Nam An
class CartItemsSample extends StatefulWidget {
  VoidCallback totalPrice;

  CartItemsSample({Key? key, required this.totalPrice}) : super(key: key);

  State<CartItemsSample> createState() => CartItemsSampleState();
}

class CartItemsSampleState extends State<CartItemsSample> {
  CartData product = CartData();
  CartData cart = CartData();

  @override
  void initState() {
    super.initState();
    getCartList();
  }

  Future<void> getCartList() async {
    await cart.getCartList();
    setState(() {});
  }

  Future<void> getProductList() async {
    await product.getProductList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //Lấy danh sách sản phẩm đã thêm vào giỏ hàng
    List<Cart> listCart = CartData.cartList;
    return Column(
      children: [
        for (int i = 0; i < listCart.length; i++)
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
                  child: Image.network("${listCart[i].product.productimage}"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${listCart[i].product.productname}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0xFF4C53A5),
                        ),
                      ),
                      Text(
                        "\$${listCart[i].product.price}",
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
                      InkWell(
                        onTap: () {
                          setState(() {
                            CartData.removeProduct1(
                                listCart[i].product.productID);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(seconds: 1),
                              content: Text(
                                'Đã xóa sản phẩm khỏi giỏ hàng',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                  ),
                                ]),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  CartData.decreaseQuantity(
                                      listCart[i].product.productID);
                                });
                                widget.totalPrice;
                              },
                              child: Icon(
                                CupertinoIcons.minus,
                                size: 18,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "${listCart[i].quantity}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4C53A5),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                  ),
                                ]),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  CartData.increaseQuantity(
                                      listCart[i].product.productID);
                                });
                                widget.totalPrice;
                              },
                              child: Icon(
                                CupertinoIcons.plus,
                                size: 18,
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
    );
  }
}
