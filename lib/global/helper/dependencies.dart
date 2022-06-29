import 'package:get/get.dart';
import '../../controllers/repair_details_controller.dart';
import '../../global/data/api.dart';
import '../../global/repositories/repair_details_repo.dart';
import '../../utils/constants.dart';

Future<void> init() async
{
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl : Constants.BASE_URL));

  //repos
  Get.lazyPut(() => RepairDetailsRepo(apiClient:Get.find()));

  //controllers
  Get.lazyPut(() => RepairDetailsController(repairDetailsRepo:Get.find()));
}