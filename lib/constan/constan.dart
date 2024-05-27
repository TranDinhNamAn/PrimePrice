import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

String serverUrl = "http://172.17.91.185/banhang/";

validdateEmail(String email){
  final emailReg = new RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  return emailReg.hasMatch(email);
}
alerDialog(BuildContext context, String mgs){
  Toast.show(mgs,
      duration: Toast.lengthShort, gravity: Toast.bottom);
}
