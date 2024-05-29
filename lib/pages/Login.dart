import 'dart:convert'; // Thư viện để chuyển đổi JSON
import 'package:flutter/material.dart'; // Thư viện cung cấp các widget cơ bản của Flutter
import 'package:android/data/UserManager.dart'; // Quản lý người dùng
import 'package:android/model/User.dart'; // Mô hình người dùng
import 'package:toast/toast.dart'; // Thư viện hiển thị thông báo dạng toast
import '../constan/constan.dart'; // Các hằng số tùy chỉnh
import '../constan/getTextFormField.dart'; // Widget tùy chỉnh để lấy trường nhập liệu
import 'package:http/http.dart' as http; // Thư viện để gửi yêu cầu HTTP
import 'Signup.dart'; // Màn hình đăng ký

class LoginForm extends StatefulWidget {
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>(); // Key để xác định form và quản lý trạng thái của nó

//Nguyen Thanh Tu
  // Các TextEditingController để kiểm soát các trường nhập liệu
  final _conUserName = TextEditingController();
  final _conPassword = TextEditingController();
  List<UserModel> users = []; // Danh sách người dùng

  // Phương thức lấy thông tin người dùng từ server
  Future getUser() async {
    var url = serverUrl + "getUser.php"; // URL của API để lấy người dùng
    var res = await http.get(Uri.parse(url)); // Gửi yêu cầu GET tới server
    if (res.statusCode == 200) { // Kiểm tra phản hồi từ server
      Iterable l = json.decode(res.body);
      List<UserModel> posts = 
          List<UserModel>.from(l.map((model) => UserModel.fromJson(model))); // Chuyển đổi JSON thành danh sách người dùng
      setState(() {
        users.addAll(posts); // Thêm người dùng vào danh sách
      });
    } else {
      throw Exception('Failed login!!'); // Ném ngoại lệ nếu có lỗi
    }
  }

  @override
  void initState() {
    super.initState();
    getUser(); // Gọi phương thức lấy người dùng khi khởi tạo
  }

  // Phương thức đăng nhập người dùng
  void login() async {
    String username = _conUserName.text;
    String pass = _conPassword.text;

    if (username.isEmpty || pass.isEmpty) { // Kiểm tra tên người dùng và mật khẩu không được để trống
      alerDialog(context, "Username or Password is null"); // Hiển thị thông báo lỗi
      return;
    }

    bool isLoggedIn = false;

    for (UserModel user in users) {
      if (user.username == username && user.password == pass) { // Kiểm tra tên người dùng và mật khẩu có khớp không
        UserManager.saveUser(user); // Lưu thông tin người dùng
        isLoggedIn = true;
        break;
      }
    }

    if (isLoggedIn) {
      alerDialog(context, "Login Successfully"); // Hiển thị thông báo đăng nhập thành công
      Navigator.pushNamed(context, "navBar"); // Điều hướng tới trang chủ
    } else {
      alerDialog(context, "Invalid username or password"); // Hiển thị thông báo lỗi nếu đăng nhập thất bại
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context); // Khởi tạo Toast context
    return Scaffold(
        appBar: AppBar(
          leading: null,
          title: const Text('Login with Signup'), // Thanh AppBar với tiêu đề
        ),
        body: Form(
          key: _formKey, // Đặt key cho form
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical, // Cho phép cuộn dọc
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Canh giữa các phần tử
                  children: [
                    SizedBox(
                      height: 50.0, // Khoảng cách giữa các phần tử
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 40),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Image.asset(
                      "images/4.jpg",
                      height: 150,
                      width: 150,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'OnlineShopping',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                          fontSize: 30),
                    ),
                    getTextFormField(
                        controller: _conUserName,
                        iconData: Icons.person,
                        hintName: 'UserName'), // Trường nhập liệu cho tên người dùng
                    SizedBox(
                      height: 10,
                    ),
                    getTextFormField(
                      controller: _conPassword,
                      iconData: Icons.lock,
                      hintName: 'Password',
                      isobscureText: true, // Trường nhập liệu cho mật khẩu
                    ),
                    Container(
                      margin: EdgeInsets.all(30), // Khoảng cách ngoài của Container
                      width: double.infinity, // Chiều rộng toàn phần
                      child: TextButton(
                        onPressed: login, // Gọi phương thức login khi nhấn nút
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue, // Màu nền của nút
                        borderRadius: BorderRadius.circular(30), // Bo tròn góc
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Canh giữa các phần tử trong hàng
                        children: [
                          Text('Does not have account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SignupFrom())); // Điều hướng đến màn hình đăng ký
                            },
                            child: Text('Signup'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
