import 'package:automatik_users_app/screens/Authentication%20Screen/Log%20In%20Screen/login_screen.dart';
import 'package:automatik_users_app/screens/Authentication%20Screen/Registration%20Screen/registration_screen.dart';
import 'package:automatik_users_app/widgets/roundedbutton.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'images/Logo.png',
                      width: 250.0,
                      height: 250.0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                RoundedButton(
                  color: Colors.lightBlueAccent,
                  buttonTitle: 'LOGIN',
                  buttonOnPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((c) => const LoginScreen()),
                      ),
                    );
                  },
                ),
                RoundedButton(
                  color: Colors.blue,
                  buttonTitle: 'SIGN UP',
                  buttonOnPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((c) => const SignUpScreen()),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
