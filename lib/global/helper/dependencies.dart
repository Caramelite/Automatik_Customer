import 'package:get/get.dart';
import '../../controllers/repair_details_controller.dart';
import '../../global/data/api.dart';
import '../../global/repositories/repair_details_repo.dart';

Future<void> init() async
{
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl : "http://localhost:3000"));

  //repos
  Get.lazyPut(() => RepairDetailsRepo(apiClient:Get.find()));

  //controllers
  Get.lazyPut(() => RepairDetailsController(repairDetailsRepo:Get.find()));
}