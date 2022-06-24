import 'package:automatik_users_app/global/global.dart';
import 'package:automatik_users_app/screens/Authentication%20Screen/Registration%20Screen/registration_screen.dart';
import 'package:automatik_users_app/screens/Splash%20Screen/splash_screen.dart';
import 'package:automatik_users_app/widgets/progress_dialog.dart';
import 'package:automatik_users_app/widgets/roundedbutton.dart';
import 'package:automatik_users_app/widgets/textfield.dart';
import 'package:automatik_users_app/widgets/validators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  FocusNode emailFN = FocusNode();
  FocusNode passwordFN = FocusNode();
  bool hidePassword = true;

  validateForm() {
    if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email Address is not valid.");
    } else if (passwordTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password is required.");
    } else {
      loginCustomerNow();
    }
  }

  loginCustomerNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(message: "Processing... Please wait");
        });

    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text.trim(),
                password: passwordTextEditingController.text.trim())
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: " + msg.toString());
    }))
        .user;

    if (firebaseUser != null) {
      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Logged in Successfully!");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (c) => const MySplashScreen(),
        ),
      );
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been created.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/Logo.png"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                validator: UnifiedValidators.emailValidator,
                controller: emailTextEditingController,
                focusNode: emailFN,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.start,
                onEditingComplete: () {
                  passwordFN.requestFocus();
                },
                style: const TextStyle(color: Colors.blueAccent),
                decoration: kTextFieldDecoration.copyWith(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                validator: UnifiedValidators.passwordValidator,
                controller: passwordTextEditingController,
                focusNode: passwordFN,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.text,
                obscureText: hidePassword,
                onEditingComplete: () {
                  passwordFN.unfocus();
                },
                style: const TextStyle(color: Colors.blueAccent),
                decoration: kTextFieldDecoration.copyWith(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 20.0),
              RoundedButton(
                color: Colors.lightBlueAccent,
                buttonTitle: 'LOGIN',
                buttonOnPressed: () {
                  validateForm();
                },
              ),
              TextButton(
                child: const Text(
                  "Don't have an account yet? Click here",
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (c) => const SignUpScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
