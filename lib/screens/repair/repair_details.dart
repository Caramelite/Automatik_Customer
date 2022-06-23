import 'package:automatik_users_app/widgets/app_icon.dart';
import 'package:automatik_users_app/widgets/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../widgets/title_icon_info.dart';

class RepairDetails extends StatelessWidget {
  const RepairDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //backgournd image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.repairDetailsImgSize,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                  image: AssetImage("images/brake-service-repair.jpg")
                )
              ),
            ),
          ),
          //reusable title
          Positioned(
            top: Dimensions.height45,
            left: 10,
            right: Dimensions.width20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              AppIcon(icon: Icons.arrow_back_ios),
              AppIcon(icon: Icons.shopping_cart_outlined)
            ],
          ),
          ),
          //symptoms
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.repairDetailsImgSize-20,
            child: Container(
             padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleIconInfo(
                    text: "Brake Repair Service",
                    iconColor: Colors.red,
                    icon: Icons.access_time_rounded,
                    minutes: ' 30 minutes',
                  ),
                  SizedBox(height: Dimensions.height10),
                  const Text("Symptoms : "),
                ],
              ),
            ),
          ),
          //expamdable symptoms details
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimensions.bottomHeightBar,
        padding : EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20,left: Dimensions.width20, right: Dimensions.width20),
        decoration: BoxDecoration(
            color: Colors.black12,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius20),
            topRight: Radius.circular(Dimensions.radius20),
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
              ),
              child:  Row(
                children: [
                  const Icon(Icons.remove, color: Colors.black, size: 15),
                  SizedBox(width: Dimensions.width20/4),
                  const Text("0", style: TextStyle(fontSize: 20, color: Colors.black)),
                  SizedBox(width: Dimensions.width20/4),
                  const Icon(Icons.add, color: Colors.black, size: 15),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.blue,
              ),
              child: const Text("₱ 300 | Add to cart", style: TextStyle(color: Colors.white)),
            ),
          ],
        )
      ),
    );
  }
}
