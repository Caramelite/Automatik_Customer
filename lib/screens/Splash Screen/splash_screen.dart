import 'dart:async';
import 'package:automatik_users_app/global/global.dart';
import 'package:automatik_users_app/mainScreens/main_screen.dart';
import 'package:automatik_users_app/screens/Welcome%20Screen/welcome_screen.dart';
import 'package:flutter/material.dart';
<<<<<<<< HEAD:lib/screens/Splash Screen/splash_screen.dart
========
import 'package:get/get.dart';
import '../../assistants/assistant_methods.dart';
import '../../controllers/repair_details_controller.dart';
import '../../global/global.dart';
import '../auth_screen/login_screen.dart';
import '../homeScreens/home_screen.dart';
>>>>>>>> Carms:lib/screens/splashScreen/splash_screen.dart

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  Future<void> _loadResources () async {
    await Get.find<RepairDetailsController>().getRepairDetailsList();
  }

  startTimer() {
    fAuth.currentUser != null ? AssistantMethods.readCurrentOnLineUserInfo() : null;

    Timer(const Duration(seconds: 2), () async {
      if (await fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;
<<<<<<<< HEAD:lib/screens/Splash Screen/splash_screen.dart
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const MainScreen()));
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => const WelcomeScreen(),
          ),
        );
      }
========
        Navigator.push(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
      }
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (c) => const LoginScreen()));
      }
>>>>>>>> Carms:lib/screens/splashScreen/splash_screen.dart
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();

    _loadResources();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/Logo.png"),
              const SizedBox(height: 15),
<<<<<<<< HEAD:lib/screens/Splash Screen/splash_screen.dart
              const Text(
                "Automatik Booking App",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
========
              const Text("Automatik Booking App",
                  style: TextStyle(
                    fontSize: 24, color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
>>>>>>>> Carms:lib/screens/splashScreen/splash_screen.dart
            ],
          ),
        ),
      ),
    );
  }
}