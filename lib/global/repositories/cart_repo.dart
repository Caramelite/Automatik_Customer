import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cart_model.dart';
import '../../utils/constants.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];

  void addToCartList(List<CartModel> cartList){
    cart = [];

    //convert objects to string because sharedpreference only accepts string
    cartList.forEach((element) => cart.add(jsonEncode(element)));

    sharedPreferences.setStringList(Constants.CART_LIST, cart);
    getCartList();
  }


  List<CartModel> getCartList(){
    List<String> carts = [];
    if(sharedPreferences.containsKey(Constants.CART_LIST)){
      carts = sharedPreferences.getStringList(Constants.CART_LIST)!;
      print("Inside geCartList : " + carts.toString());
    }
    List<CartModel> cartList = [];

    carts.forEach((element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }
}