// TODO Implement this library.import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:android/constan/constan.dart';
import 'package:toast/toast.dart';

import '../constan/getTextFormField.dart';
import 'package:http/http.dart' as http;
import 'Login.dart';

class SignupFrom extends StatefulWidget {
  @override
  State<SignupFrom> createState() => _SignupFromState();
}

class _SignupFromState extends State<SignupFrom> {
  final _formKey = new GlobalKey<FormState>();

  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();
  final _conAddress = TextEditingController();

  void signup() async {
    String username = _conUserName.text;
    String password = _conPassword.text;
    String email = _conEmail.text;
    String address = _conAddress.text;
    String CPassword = _conCPassword.text;

    if (_formKey.currentState!.validate()) {
      if (password != CPassword) {
        alerDialog(context, "Password Mismatch");
      } else {
        _formKey.currentState?.save();
        var url = serverUrl + "insertUser.php";
        var res = await http.post(Uri.parse(url), body: {
          "username": username.toString(),
          "password": password.toString(),
          "email": email.toString(),
          "address": address.toString(),
        });
        alerDialog(context, "Signup Successfully!");
        Navigator.pushNamed(context, "/");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(title: Text('Login or signup')),
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
                    'SignUp',
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
                      hintName: 'User Name'),
                  SizedBox(
                    height: 10,
                  ),
                  getTextFormField(
                      controller: _conPassword,
                      iconData: Icons.lock,
                      inputType: TextInputType.name,
                      hintName: 'Password',
                      isobscureText: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  getTextFormField(
                    controller: _conCPassword,
                    iconData: Icons.lock,
                    hintName: 'Confirm Password',
                    isobscureText: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  getTextFormField(
                      controller: _conEmail,
                      iconData: Icons.email,
                      inputType: TextInputType.emailAddress,
                      hintName: 'Email'),
                  SizedBox(
                    height: 10,
                  ),
                  getTextFormField(
                    controller: _conAddress,
                    iconData: CupertinoIcons.location_solid,
                    hintName: 'Address',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.all(30),
                    width: double.infinity,
                    child: TextButton(
                      onPressed: signup,
                      child: Text(
                        'Sign Up',
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
                        Text('Does have account ?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => LoginForm()),
                                (Route<dynamic> route) => false);
                          },
                          child: Text('Sign In'),
                        ),
                      ],
                    ),
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
