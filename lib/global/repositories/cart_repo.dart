import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cart_model.dart';
import '../../utils/constants.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList){
    //sharedPreferences.remove(Constants.CART_LIST);
    //sharedPreferences.remove(Constants.CART_HISTORY_LIST);
    var time = DateTime.now().toString();
    cart = [];

    //convert objects to string because sharedpreference only accepts string
    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(Constants.CART_LIST, cart);
    //getCartList();
  }

  List<CartModel> getCartList(){
    List<String> carts = [];
    if(sharedPreferences.containsKey(Constants.CART_LIST)){
      carts = sharedPreferences.getStringList(Constants.CART_LIST)!;
      print("Inside getCartList : $carts");
    }
    List<CartModel> cartList = [];

    carts.forEach((element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }

  List<CartModel> getCartHistoryList(){
    if(sharedPreferences.containsKey(Constants.CART_HISTORY_LIST)){
      //cartHistory = [];
      cartHistory = sharedPreferences.getStringList(Constants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) => cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

  void addToCartHistoryList(){
    if(sharedPreferences.containsKey(Constants.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(Constants.CART_HISTORY_LIST)!;
    }
    for(int i = 0; i < cart.length; i++){
      print("History list : " + cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(Constants.CART_HISTORY_LIST, cartHistory);
    print("The length of history list is : " + getCartHistoryList().length.toString());
    for (int j = 0; j < getCartHistoryList().length; j++){
      print("The time of order is : " + getCartHistoryList()[j].time.toString());
    }
  }

  void removeCart(){
    cart = [];
    sharedPreferences.remove(Constants.CART_LIST);
  }
}