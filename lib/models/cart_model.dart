
import 'repair_details_model.dart';

class CartModel  {
  int? id;
  String? title;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  RepairDetailsModel? repairDetails;

  CartModel ({
    this.id,
    this.title,
    this.quantity,
    this.price,
    this.img,
    this.isExist,
    this.time,
    this.repairDetails
  });

  CartModel .fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    repairDetails = RepairDetailsModel.fromJson(json['repairDetails']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : this.id,
      'title' : this.title,
      'price' : this.price,
      'img' : this.img,
      'quantity' : this.quantity,
      'isExist' : this.isExist,
      'time' : this.time,
      'repairDetails' : this.repairDetails!.toJson()
     };
  }

}