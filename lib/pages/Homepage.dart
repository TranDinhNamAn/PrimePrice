import 'dart:convert'; // Thư viện để mã hóa và giải mã JSON
import 'package:android/constan/constan.dart'; // Import hằng số (constants)
import 'package:android/model/Product.dart'; // Import mô hình Product
import 'package:android/widgets/SideNavBar.dart'; // Import widget SideNavBar
import 'package:flutter/cupertino.dart'; // Import thư viện Flutter Cupertino
import 'package:flutter/material.dart'; // Import thư viện Flutter Material
import 'package:http/http.dart' as http; // Import thư viện HTTP
import '../widgets/CategoriesWidget.dart'; // Import widget CategoriesWidget
import '../widgets/HomeAppBar.dart'; // Import widget HomeAppBar
import '../widgets/ItemsWidget.dart'; // Import widget ItemsWidget

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => HomePageState(); // Tạo trạng thái cho HomePage
}

class HomePageState extends State<HomePage> {
  List<Product> list = []; // Danh sách toàn bộ sản phẩm
  List<Product> foundItem = []; // Danh sách sản phẩm được tìm thấy

//Nguyen Thanh Tu
  // Phương thức lấy dữ liệu sản phẩm từ server
  Future getProduct() async {
    var res = await http.get(Uri.parse(serverUrl + "getloaisp.php")); // Gửi yêu cầu HTTP GET
    print(res.body); // In kết quả phản hồi ra console
    if (res.statusCode == 200) { // Kiểm tra nếu phản hồi thành công
      Iterable l = json.decode(res.body); // Giải mã JSON
      List<Product> posts =
          List<Product>.from(l.map((model) => Product.fromJson(model)))
              .toList(); // Chuyển đổi JSON thành danh sách Product
      setState(() {
        list.addAll(posts); // Cập nhật danh sách sản phẩm
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getProduct(); // Gọi phương thức lấy dữ liệu khi khởi tạo
    foundItem = list; // Khởi tạo danh sách sản phẩm được tìm thấy
  }

  // Phương thức tìm kiếm sản phẩm
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
              .contains(keyword.toLowerCase()); // Kiểm tra từ khóa có trong tên sản phẩm
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: HomeAppBar(), // Widget HomeAppBar
        titleSpacing: -5,
      ),
      drawer: SideNavBar(), // Widget SideNavBar
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
                // Thanh tìm kiếm
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
                            print('typing'); // In ra khi đang nhập
                            search(value); // Gọi phương thức tìm kiếm
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Nhập tên sản phẩm cần tìm...", // Gợi ý tìm kiếm
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
                // Tiêu đề "Categories"
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
                CategoriesWidget(), // Widget CategoriesWidget
                // Tiêu đề "Best Selling"
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
                ItemsWidget(products: foundItem), // Widget ItemsWidget hiển thị sản phẩm tìm thấy
              ],
            ),
          ),
        ],
      ),
    );
  }
}
