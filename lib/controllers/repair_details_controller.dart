import 'package:get/get.dart';
import '../global/repositories/repair_details_repo.dart';
import '../models/repair_details_model.dart';

class RepairDetailsController extends GetxController
{
  final RepairDetailsRepo repairDetailsRepo;
  RepairDetailsController({required this.repairDetailsRepo});

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  List<dynamic> _repairDetailsList = [];
  List<dynamic> get repairDetailsList => _repairDetailsList;

  Future<void> getRepairDetailsList() async
  {
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
}