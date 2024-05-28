import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // Thư viện cung cấp các widget cơ bản của Flutter
import 'package:android/constan/constan.dart'; // Tập tin chứa các hằng số tùy chỉnh
import 'package:toast/toast.dart'; // Thư viện hiển thị thông báo dạng toast
import '../constan/getTextFormField.dart'; // Widget tùy chỉnh để lấy trường nhập liệu
import 'package:http/http.dart' as http; // Thư viện để gửi yêu cầu HTTP
import 'Login.dart'; // Màn hình đăng nhập

class SignupFrom extends StatefulWidget {
  @override
  State<SignupFrom> createState() => _SignupFromState();
}

class _SignupFromState extends State<SignupFrom> {
  final _formKey = GlobalKey<FormState>(); // Key để xác định form và quản lý trạng thái của nó

  // Các TextEditingController để kiểm soát các trường nhập liệu
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();
  final _conAddress = TextEditingController();

  // Phương thức đăng ký người dùng
  void signup() async {
    String username = _conUserName.text;
    String password = _conPassword.text;
    String email = _conEmail.text;
    String address = _conAddress.text;
    String CPassword = _conCPassword.text;

    if (_formKey.currentState!.validate()) { // Kiểm tra xem form có hợp lệ không
      if (password != CPassword) { // Kiểm tra mật khẩu và xác nhận mật khẩu có khớp nhau không
        alerDialog(context, "Password Mismatch"); // Hiển thị thông báo lỗi nếu mật khẩu không khớp
      } else {
        _formKey.currentState?.save(); // Lưu trạng thái form
        var url = serverUrl + "insertUser.php"; // URL của API để đăng ký người dùng
        var res = await http.post(Uri.parse(url), body: { // Gửi yêu cầu POST tới server
          "username": username,
          "password": password,
          "email": email,
          "address": address,
        });

        if (res.statusCode == 200) { // Kiểm tra phản hồi từ server
          alerDialog(context, "Signup Successfully!"); // Hiển thị thông báo thành công
          Navigator.pushNamed(context, "/"); // Điều hướng người dùng tới trang chủ
        } else {
          alerDialog(context, "Signup Failed. Please try again."); // Hiển thị thông báo lỗi nếu đăng ký thất bại
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context); // Khởi tạo Toast context
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')), // Thanh AppBar với tiêu đề
      body: Form(
        key: _formKey, // Đặt key cho form
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical, // Cho phép cuộn dọc
          child: Container(
            padding: EdgeInsets.all(16.0), // Padding cho Container
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Canh giữa các phần tử
                children: [
                  SizedBox(height: 50.0), // Khoảng cách giữa các phần tử
                  Text(
                    'SignUp',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 40),
                  ),
                  SizedBox(height: 10.0),
                  Image.asset(
                    "images/4.jpg",
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Online Shop',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                        fontSize: 30),
                  ),
                  getTextFormField(
                      controller: _conUserName,
                      iconData: Icons.person,
                      hintName: 'User Name'), // Trường nhập liệu cho tên người dùng
                  SizedBox(height: 10),
                  getTextFormField(
                      controller: _conPassword,
                      iconData: Icons.lock,
                      inputType: TextInputType.text,
                      hintName: 'Password',
                      isobscureText: true), // Trường nhập liệu cho mật khẩu
                  SizedBox(height: 10),
                  getTextFormField(
                    controller: _conCPassword,
                    iconData: Icons.lock,
                    hintName: 'Confirm Password',
                    isobscureText: true, // Trường nhập liệu cho xác nhận mật khẩu
                  ),
                  SizedBox(height: 10),
                  getTextFormField(
                      controller: _conEmail,
                      iconData: Icons.email,
                      inputType: TextInputType.emailAddress,
                      hintName: 'Email'), // Trường nhập liệu cho email
                  SizedBox(height: 10),
                  getTextFormField(
                    controller: _conAddress,
                    iconData: CupertinoIcons.location_solid,
                    hintName: 'Address',
                    inputType: TextInputType.text, // Trường nhập liệu cho địa chỉ
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.all(30), // Khoảng cách ngoài của Container
                    width: double.infinity, // Chiều rộng toàn phần
                    child: TextButton(
                      onPressed: signup, // Gọi phương thức signup khi nhấn nút
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue, // Màu nền của nút
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Bo tròn góc
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Canh giữa các phần tử trong hàng
                    children: [
                      Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => LoginForm()), // Điều hướng đến màn hình đăng nhập
                              (Route<dynamic> route) => false);
                        },
                        child: Text('Sign In'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
