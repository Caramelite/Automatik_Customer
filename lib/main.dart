import 'package:automatik_users_app/screens/Splash%20Screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
      MyApp(
        child : MaterialApp(
          title: 'Technician App',
          theme: ThemeData(
          primarySwatch: Colors.blue,
          ),
            debugShowCheckedModeBanner: false,
          home: const MySplashScreen(),
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

