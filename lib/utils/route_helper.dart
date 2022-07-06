import 'package:get/get.dart';
import '../screens/cart/cart_page.dart';
import '../screens/mainScreens/main_screen.dart';
import '../screens/repair/repair_details.dart';
import '../screens/repair/repair_screen.dart';

class RouteHelper {
  static const String initial = "/main-screen";
  static const String repairPage = "/repair-page";
  static const String repairDetails = "/repair-details";
  static const String cartPage = "/cart-page";

  static String getInitial() => '$initial';
  static String getRepairPage() => '$repairPage';
  static String getRepairDetails(int pageId, String page) => '$repairDetails?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';


  static List<GetPage> routes = [
    GetPage(name: initial, page : ()=> const MainScreen()),

    GetPage(name: repairPage, page: () {
      return const RepairBodyPage();
    },
        transition: Transition.fadeIn),

    GetPage(name: repairDetails, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RepairDetails(pageId: int.parse(pageId!), page : page!);
    }, transition: Transition.fadeIn),

    GetPage(name: cartPage, page: () {
      return CartPage();
    }, transition: Transition.fadeIn),
  ];
}