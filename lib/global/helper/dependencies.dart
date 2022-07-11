import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/repair_details_controller.dart';
import '../../global/data/api.dart';
import '../../global/repositories/repair_details_repo.dart';
import '../../utils/constants.dart';
import '../repositories/cart_repo.dart';

Future<void> init() async
{
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl : Constants.BASE_URL));

  //repos
  Get.lazyPut(() => RepairDetailsRepo(apiClient:Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //controllers
  Get.lazyPut(() => RepairDetailsController(repairDetailsRepo:Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}