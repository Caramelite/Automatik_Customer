import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../global/repositories/cart_repo.dart';
import '../models/cart_model.dart';
import '../models/repair_details_model.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;

  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  void addItem(RepairDetailsModel repair, int quantity){
    if(_items.containsKey(repair.id!)){
      _items.update(repair.id!, (value) {
        return CartModel(
          id : value.id,
          title : value.title,
          price : value.price,
          img : value.img,
          quantity : value.quantity! + quantity,
          isExist : true,
          time : DateTime.now().toString(),
        );
      });
    }else{
      _items.putIfAbsent(repair.id!, () {
        return CartModel(
          id : repair.id,
          title : repair.title,
          price : repair.price,
          img : repair.img,
          quantity : quantity,
          isExist : true,
          time : DateTime.now().toString(),
        );
      });
    }
  }
}