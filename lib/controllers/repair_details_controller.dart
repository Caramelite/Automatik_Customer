import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../global/repositories/repair_details_repo.dart';
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
    }else{
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }
  checkQuantity(int quantity){
    if(quantity < 0){
      Get.snackbar("Item Count", "You can't reduce more !",
        backgroundColor: Colors.black45,
        colorText: Colors.white,
      );
      return 0;
    }
    else if(quantity > 2){
      Get.snackbar("Item Count", "You've reached the maximum order !",
        backgroundColor: Colors.black45,
        colorText: Colors.white,
      );
      return 2;
    }
    else{
      return quantity;
    }
  }

  void initDetails(CartController cart){
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;

    //get from storage and save it in _inCartItems (If exist)
  }

  void addItem(RepairDetailsModel repair){
    if (_quantity > 0 ){
      _cart.addItem(repair, _quantity);
      _quantity = 0;
      _cart.items.forEach((key, value) {
        print("The id is : " + value.id.toString() + " | The quantity is : " + value.quantity.toString());
      });
    }else{
      Get.snackbar("Item Count", "You should atleast add one item !",
        backgroundColor: Colors.black45,
        colorText: Colors.white,
      );
    }
  }
}