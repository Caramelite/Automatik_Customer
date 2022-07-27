import 'package:automatik_users_app/constants/firebase_auth_controller.dart';
import 'package:automatik_users_app/screens/Authentication%20Screen/Log%20In%20Screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));

  runApp(
      MyApp(
        child : GetMaterialApp(
          title: 'Technician App',
          theme: ThemeData(
          primarySwatch: Colors.blue,
          ),
            debugShowCheckedModeBanner: false,
          home: const LoginScreen(),
        )
      )
  );
}


class MyApp extends StatefulWidget
{
  final Widget? child;
  MyApp({this.child});

  static void restartApp(BuildContext context)
  {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();
  void restartApp(){
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: key, child: widget.child!);
  }
}

