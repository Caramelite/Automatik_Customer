import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'controllers/cart_controller.dart';
import 'infoHandler/app_info.dart';
import 'global/helper/dependencies.dart' as dependency;
import 'utils/route_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dependency.init();
  Get.find<CartController>().getCartData();

  runApp(
      MyApp(
        child : ChangeNotifierProvider(
          create: (context) => AppInfo(),
          child: GetMaterialApp(
            title: 'Customer App',
              debugShowCheckedModeBanner: false,
            initialRoute: RouteHelper.getsplashScreen(),
            getPages: RouteHelper.routes,
          ),
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

