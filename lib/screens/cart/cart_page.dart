import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/repair_details_controller.dart';
import '../../utils/route_helper.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/dimensions.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: Dimensions.width20,
            right: Dimensions.width20,
            top: Dimensions.height20*2.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      //Get.toNamed(RouteHelper.getRepairDetails());
                    },
                    child: const AppIcon(icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                        backgroundColor: Colors.blue,
                    ),
                  ),
                  SizedBox(width: Dimensions.width30*8),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: const AppIcon(icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  const AppIcon(icon: Icons.shopping_cart_outlined,
                    iconColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                ],
              ),
          ),
          Positioned(
              left: Dimensions.width20,
              right: Dimensions.width20,
              top: Dimensions.height20*5,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height20),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder : (cart) {
                    var _cartList = cart.getItems;
                    return ListView.builder(
                        itemCount: _cartList.length,
                        itemBuilder: (_, index){
                          return SizedBox(
                            height: Dimensions.height20*5,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    var reparIndex = Get.find<RepairDetailsController>()
                                        .repairDetailsList.indexOf(_cartList[index].repairDetails!);
                                    if(reparIndex >= 0){
                                      Get.toNamed(RouteHelper.getRepairDetails(reparIndex, "cartpage"));
                                    }
                                  },
                                  child: Container(
                                    width: Dimensions.height20*5,
                                    height: Dimensions.height20*5,
                                    margin: EdgeInsets.only(bottom: Dimensions.height10),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(cart.getItems[index].img!)
                                      ),
                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.width20/2),
                                Expanded(
                                  child: SizedBox(
                                    height: Dimensions.height20*5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(cart.getItems[index].title!, style: const TextStyle(color: Colors.black, )),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                             Text("₱ " + cart.getItems[index].price.toString(), style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                                            Container(
                                              padding: EdgeInsets.only(top: Dimensions.height20/2, bottom: Dimensions.height20/2, left: Dimensions.width20/2, right: Dimensions.width20/2),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                color: Colors.white,
                                              ),
                                              child:  Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: (){
                                                      cart.addItem(_cartList[index].repairDetails!, -1);
                                                    },
                                                    child: const Icon(Icons.remove, color: Colors.black, size: 13),
                                                  ),
                                                  SizedBox(width: Dimensions.width20/2),
                                                  Text(_cartList[index].quantity.toString(),
                                                      style: const TextStyle(fontSize: 18, color: Colors.black)),
                                                  SizedBox(width: Dimensions.width20/2),
                                                  GestureDetector(
                                                    onTap: (){
                                                      cart.addItem(_cartList[index].repairDetails!, 1);
                                                    },
                                                    child: const Icon(Icons.add, color: Colors.black, size: 13),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  )
                ),
              ),
          ),
        ],
      ),
        bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
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
                      SizedBox(width: Dimensions.width20/2),
                      Text("₱ " + cartController.totalAmount.toString(), style: const TextStyle(fontSize: 20, color: Colors.black)),
                      SizedBox(width: Dimensions.width20/2),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    //repairDetails.addItem(detail);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.blue,
                    ),
                    child: const Text("Check Out", style: TextStyle(color: Colors.white),
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

