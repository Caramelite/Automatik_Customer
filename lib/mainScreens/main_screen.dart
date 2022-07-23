import 'package:automatik_users_app/global/global.dart';
import 'package:automatik_users_app/screens/Authentication%20Screen/Log%20In%20Screen/login_screen.dart';
import 'package:flutter/material.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text("Logout"),
        onPressed: ()
        {
          fAuth.signOut();
          Navigator.push(context, MaterialPageRoute(builder: (c) => const LoginScreen()));
        },
      ),
    );
  }
}