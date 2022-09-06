
import 'package:automatik_users_app/screens/auth_screen/signup_screen.dart';
import 'package:automatik_users_app/screens/homeScreens/home_screen.dart';
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
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  FocusNode emailFN = FocusNode();
  FocusNode passwordFN = FocusNode();
  bool hidePassword = true;

  final _auth = FirebaseAuth.instance;

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
                child: Image.asset("assets/images/Logo.png"),
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
                  sigIn(emailTextEditingController.text, passwordTextEditingController.text);
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

  void sigIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
        Fluttertoast.showToast(msg: "Login Successful"),
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()))
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}