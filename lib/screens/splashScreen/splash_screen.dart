import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/repair_details_controller.dart';
import '../../global/global.dart';
import '../auth_screen/login_screen.dart';
import '../homeScreens/home_screen.dart';

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
    //fAuth.currentUser != null ? AssistantMethods.readCurrentOnLineUserInfo() : null;

    Timer(const Duration(seconds: 2), () async {
      if(await fAuth.currentUser != null)
      {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(context, MaterialPageRoute(builder: (c) => const HomeScreen()));
      }
      else
      {
        Navigator.push(context, MaterialPageRoute(builder: (c) => const LoginScreen()));
      }
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
              const Text("Automatik Booking App",
                  style: TextStyle(
                    fontSize: 24, color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}