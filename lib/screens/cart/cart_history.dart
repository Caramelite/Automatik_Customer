import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/cart_controller.dart';
import '../../utils/constants.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/dimensions.dart';
import '../../widgets/expandable_text.dart';
import '../../widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>()
        .getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      }else{
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<int> itemsPerOrder = cartOrderTimeToList();

    var listCounter = 0;

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            width: double.maxFinite,
            height: Dimensions.height10*10,
            padding: EdgeInsets.only(top: Dimensions.height30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text("Cart History", style: TextStyle(color: Colors.white, fontSize: 18)),
                  AppIcon(icon: Icons.shopping_cart_outlined, iconColor: Colors.blue, backgroundColor: Colors.yellow)
                ]
            )
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              child: MediaQuery.removePadding(context: context,
                  removeTop: true,
                  child: ListView(
                    children: [
                      for (int i = 0; i < itemsPerOrder.length; i++)
                        Container(
                          height: Dimensions.height30*5,
                          margin: EdgeInsets.only(bottom: Dimensions.height20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ((){
                               DateTime parseDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(getCartHistoryList[listCounter].time!); //get the datetime object
                               var inputDate = DateTime.parse(parseDate.toString());
                                var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
                                var outputDate = outputFormat.format(inputDate);
                                return Text(outputDate);
                              }()),
                              SizedBox(height: Dimensions.height10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(itemsPerOrder[i], (index) {
                                        if(listCounter < getCartHistoryList.length){
                                          listCounter++;
                                        }
                                        return index < 3
                                            ? Container(
                                            margin: EdgeInsets.only(right: Dimensions.width20/4),
                                            height: Dimensions.height20*4,
                                            width: Dimensions.height20*4,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        getCartHistoryList[listCounter-1].img!
                                                    )
                                                )
                                            )
                                        )
                                            : Container();
                                      })
                                  ),
                                  SizedBox(
                                    height: Dimensions.height20*5,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SmallText(text : "Total"),
                                        Text(
                                          itemsPerOrder[i].toString() + " Items",
                                          style: const TextStyle(color: Colors.black, fontSize: 18)
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            print("Total Items : " +itemsPerOrder[i].toString());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: Dimensions.width20/2, vertical: Dimensions.height10/2),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius15/3),
                                                  border: Border.all(color: Colors.lightBlueAccent)
                                            ),
                                            child: SmallText(text: "one more", color: Colors.lightBlueAccent),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                    ],
                  ),
              )
            ),
          ),
        ],
      )
    );
  }
}
