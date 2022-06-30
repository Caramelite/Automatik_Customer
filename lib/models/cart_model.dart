
class CartModel  {
  int? id;
  String? title;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;

  CartModel ({
    this.id,
    this.title,
    this.quantity,
    this.price,
    this.img,
    this.isExist,
    this.time
  });

  CartModel .fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
  }

}