import 'package:automatik_users_app/controllers/cart_controller.dart';
import 'package:automatik_users_app/widgets/app_icon.dart';
import 'package:automatik_users_app/widgets/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/repair_details_controller.dart';
import '../../utils/route_helper.dart';
import '../../widgets/expandable_text.dart';
import '../../widgets/title_icon_info.dart';

class RepairDetails extends StatelessWidget {
  final int pageId;
  final String page;
  RepairDetails({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var detail = Get.find<RepairDetailsController>().repairDetailsList[pageId];
    Get.find<RepairDetailsController>().initDetails(detail, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.repairDetailsImgSize,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(detail.img!)
                  )
              ),
            ),
          ),
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(onTap: (){
                  if(page == "cart-page"){
                    Get.toNamed(RouteHelper.getCartPage());
                  }else{
                    Get.toNamed(RouteHelper.getInitial());
                  }
                },
                child: const AppIcon(icon: Icons.arrow_back_ios),
                ),
                GetBuilder<RepairDetailsController>(builder : (repairDetails) {
                  return GestureDetector(
                    onTap: (){
                      if(repairDetails.totalItems >= 0) {
                        Get.toNamed(RouteHelper.getCartPage());
                      }
                    },
                    child: Stack(
                      children: [
                        const AppIcon(icon: Icons.shopping_cart_outlined),
                        repairDetails.totalItems >= 1
                            ? const Positioned(
                              right: 0, top: 0,
                              child:  AppIcon(icon: Icons.circle, size: 15,
                                  iconColor: Colors.transparent,
                                  backgroundColor: Colors.blue))
                            : Container(),
                        Get.find<RepairDetailsController>().totalItems >= 1
                            ?  Positioned(
                            right: 3.8, top: 0.5,
                            child:  Text(Get.find<RepairDetailsController>().totalItems.toString(),
                            style: const TextStyle(fontSize: 12, color: Colors.black),
                            ))
                            : Container(),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          //expamdable symptoms details
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
                   TitleIconInfo(
                    iconColor: Colors.red,
                    icon: Icons.access_time_rounded,
                    minutes: detail.minutes,
                     title: detail.title!,
                    moreInfo: "Symptoms : ",
                  ),
                  SizedBox(height: Dimensions.height10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableRepairDetails(text: detail.info!),
                  ),
                ),
              ],
            ),
          ),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<RepairDetailsController>(builder: (repairDetails){
        return Container(
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
                      GestureDetector(
                        onTap: (){
                          repairDetails.setQuantity(false);
                        },
                          child: const Icon(Icons.remove, color: Colors.black, size: 15),
                      ),
                      SizedBox(width: Dimensions.width20/2),
                      Text(repairDetails.inCartItems.toString(), style: const TextStyle(fontSize: 20, color: Colors.black)),
                      SizedBox(width: Dimensions.width20/2),
                      GestureDetector(
                        onTap: (){
                          repairDetails.setQuantity(true);
                        },
                        child: const Icon(Icons.add, color: Colors.black, size: 15),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    repairDetails.addItem(detail);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.blue,
                    ),
                    child: Text("₱${detail.price!}  | Add to cart", style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          );
        },
      ),
    );
  }
}