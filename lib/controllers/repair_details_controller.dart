import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../global/repositories/repair_details_repo.dart';
import '../models/cart_model.dart';
import '../models/repair_details_model.dart';
import 'cart_controller.dart';

class RepairDetailsController extends GetxController
{
  final RepairDetailsRepo repairDetailsRepo;
  RepairDetailsController({required this.repairDetailsRepo});
  List<dynamic> _repairDetailsList = [];
  List<dynamic> get repairDetailsList => _repairDetailsList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getRepairDetailsList() async {
    Response response = await repairDetailsRepo.getRepairDetailsList();
    if(response.statusCode == 200)
    {
      _repairDetailsList = [];
      _repairDetailsList.addAll(Repair.fromJson(response.body).details);
      _isLoaded = true;
      update();
    }
    else {

    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity + 1);
      //print("Number of Items :  " +  _quantity.toString());
    }else{
      _quantity = checkQuantity(_quantity - 1);
      //print("Decrement :  " +  _quantity.toString());
    }
    update();
  }

   int checkQuantity(int quantity){
    if((_inCartItems + quantity) < 0){
      Get.snackbar("Item Count", "You can't reduce more !",
        backgroundColor: Colors.black45,
        colorText: Colors.white,
      );
      if(_inCartItems > 0){
        _quantity =- _inCartItems;
        return _quantity;
      }
      return 0;
    }
    else if((_inCartItems + quantity) > 5){
      Get.snackbar("Item Count", "You've reached the maximum order !",
        backgroundColor: Colors.black45,
        colorText: Colors.white,
      );
      return 5;
    }
    else{
      return quantity;
    }
  }

  void initDetails(RepairDetailsModel repair, CartController cart){
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(repair);

    print("Status : " + exist.toString());
    if(exist){
      _inCartItems = _cart.getQuanity(repair);
    }
    print("Quantity : " + _inCartItems.toString());
  }

  void addItem(RepairDetailsModel repair){
      _cart.addItem(repair, _quantity);

      _quantity = 0;
      _inCartItems = _cart.getQuanity(repair);

      _cart.items.forEach((key, value) {
        print("The id is : " + value.id.toString() + " | The quantity is : " + value.quantity.toString());
      });
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get getItems{
    return _cart.getItems;
  }

}