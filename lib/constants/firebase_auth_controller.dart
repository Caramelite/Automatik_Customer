import 'dart:ffi';

import 'package:automatik_users_app/screens/Authentication%20Screen/Log%20In%20Screen/login_screen.dart';
import 'package:automatik_users_app/screens/Authentication%20Screen/Registration%20Screen/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class AuthController extends GetxController {
  //AuthCOntroller.instance
  static AuthController instance = Get.find();
  //email, password, name
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print("login page");
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const SignUpScreen());
    }
  }

  void register(String email, password) async{
    try {
     await auth.createUserWithEmailAndPassword(email: email, password: password);
    } catchError((msg){
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error:"+ msg.toString());
    }).user;
  }
}
