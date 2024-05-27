import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:android/data/UserManager.dart';
import 'package:android/model/User.dart';
import 'package:toast/toast.dart';
import '../constan/constan.dart';
import '../constan/getTextFormField.dart';
import 'package:http/http.dart' as http;
import 'Signup.dart';

class LoginForm extends StatefulWidget {
  _LoginForm createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  final _formKey = new GlobalKey<FormState>();

  final _conUserName = TextEditingController();
  final _conPassword = TextEditingController();
  List<UserModel> users = [];

  Future getUser() async {
    var url = serverUrl + "getUser.php";
    var res = await http.get(Uri.parse(url));
    // print(res.body);
    if (res.statusCode == 200) {
      Iterable l = json.decode(res.body);
      List<UserModel> posts =
          List<UserModel>.from(l.map((model) => UserModel.fromJson(model)));
      setState(() {
        users.addAll(posts);
      });
    } else {
      throw Exception('Failed login!!');
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void login() async {
    String username = _conUserName.text;
    String pass = _conPassword.text;

    if (username.isEmpty || pass.isEmpty) {
      alerDialog(context, "Username or Password is null");
      return;
    }

    bool isLoggedIn = false;

    for (UserModel user in users) {
      if (user.username == username && user.password == pass) {
        UserManager.saveUser(user);
        isLoggedIn = true;
        break;
      }
    }

    if (isLoggedIn) {
      alerDialog(context, "Login Successfully");
      Navigator.pushNamed(context, "navBar");
    } else {
      alerDialog(context, "Invalid username or password");
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: null,
          title: Text('Login or Signup'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50.0,
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
                      'PrimePrice',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                          fontSize: 30),
                    ),
                    getTextFormField(
                        controller: _conUserName,
                        iconData: Icons.person,
                        hintName: 'UserName'),
                    SizedBox(
                      height: 10,
                    ),
                    getTextFormField(
                      controller: _conPassword,
                      iconData: Icons.lock,
                      hintName: 'Password',
                      isobscureText: true,
                    ),
                    Container(
                      margin: EdgeInsets.all(30),
                      width: double.infinity,
                      child: TextButton(
                        onPressed: login,
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Does not have account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SignupFrom()));
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
