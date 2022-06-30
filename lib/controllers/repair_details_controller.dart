import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../global/repositories/repair_details_repo.dart';
import '../models/repair_details_model.dart';

class RepairDetailsController extends GetxController
{
  final RepairDetailsRepo repairDetailsRepo;
  RepairDetailsController({required this.repairDetailsRepo});
  List<dynamic> _repairDetailsList = [];
  List<dynamic> get repairDetailsList => _repairDetailsList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  Future<void> getRepairDetailsList() async {
    Response response = await repairDetailsRepo.getRepairDetailsList();
    if(response.statusCode == 200)
    {
      print("Got details");
      _repairDetailsList = [];
      _repairDetailsList.addAll(Repair.fromJson(response.body).details);
      _isLoaded = true;
      update();
      print(_repairDetailsList);
    }
    else {

    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      print("increment");
      _quantity = checkQuantity(_quantity + 1);
    }else{
      print("decrement");
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
    else if(quantity > 3){
      Get.snackbar("Item Count", "You've reached the maximum order !",
        backgroundColor: Colors.black45,
        colorText: Colors.white,
      );
      return 3;
    }
    else{
      return quantity;
    }
  }

  void initDetails(){
    _quantity = 0;
  }
}