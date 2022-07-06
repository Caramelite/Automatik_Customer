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

  void addItem(RepairDetailsModel repair, int quantity){
    var totalQuantity = 0;
    if(_items.containsKey(repair.id!)){
      _items.update(repair.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id : value.id,
          title : value.title,
          price : value.price,
          img : value.img,
          quantity : value.quantity! + quantity,
          isExist : true,
          time : DateTime.now().toString(),
          repairDetails: repair,
        );
      });
      if(totalQuantity <= 0){
        _items.remove(repair.id);
      }
    }else{
     if(quantity > 0){
       _items.putIfAbsent(repair.id!, () {
         return CartModel(
           id : repair.id,
           title : repair.title,
           price : repair.price,
           img : repair.img,
           quantity : quantity,
           isExist : true,
           time : DateTime.now().toString(),
           repairDetails: repair,
         );
       });
     }else {
       Get.snackbar("Item Count", "You should atleast add one item !",
         backgroundColor: Colors.black45,
         colorText: Colors.white,
       );
     }
    }
    update();
  }

  bool existInCart(RepairDetailsModel repair){
    if (_items.containsKey(repair.id)){
      return true;
    }
    return false;
  }

  int getQuanity(RepairDetailsModel repair){
    var quantity = 0;
    if(_items.containsKey(repair.id)){
      _items.forEach((key, value) {
        if(key == repair.id){
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
}