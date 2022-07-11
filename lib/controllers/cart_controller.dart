import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../global/repositories/cart_repo.dart';
import '../models/cart_model.dart';
import '../models/repair_details_model.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems = []; //only for storage and sharedPreferences

  void addItem(RepairDetailsModel repairDetails, int quantity){
    var totalQuantity = 0;
    if(_items.containsKey(repairDetails.id!)){
      _items.update(repairDetails.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id : value.id,
          title : value.title,
          price : value.price,
          img : value.img,
          quantity : value.quantity! + quantity,
          isExist : true,
          time : DateTime.now().toString(),
          repairDetails: repairDetails,
        );
      });
      if(totalQuantity <= 0){
        _items.remove(repairDetails.id);
      }
    }else{
     if(quantity > 0){
       _items.putIfAbsent(repairDetails.id!, () {
         return CartModel(
           id : repairDetails.id,
           title : repairDetails.title,
           price : repairDetails.price,
           img : repairDetails.img,
           quantity : quantity,
           isExist : true,
           time : DateTime.now().toString(),
           repairDetails: repairDetails,
         );
       });
     }else {
       Get.snackbar("Item Count", "You should atleast add one item !",
         backgroundColor: Colors.black45,
         colorText: Colors.white,
       );
     }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(RepairDetailsModel repairDetails){
    if (_items.containsKey(repairDetails.id)){
      return true;
    }
    return false;
  }

  int getQuanity(RepairDetailsModel repairDetails){
    var quantity = 0;
    if(_items.containsKey(repairDetails.id)){
      _items.forEach((key, value) {
        if(key == repairDetails.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems{
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getItems{
    return _items.entries.map((e){
      return e.value;
    }).toList();
  }

  int get totalAmount{
    var total = 0;

    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  //Set - accept something in your parameters
  set setCart(List<CartModel> items){
    storageItems = items;
    print("Length of cart items : " + storageItems.length.toString());
    for (int i = 0; i < storageItems.length; i++){
      _items.putIfAbsent(storageItems[i].repairDetails!.id!, () => storageItems[i]);
    }
  }

}