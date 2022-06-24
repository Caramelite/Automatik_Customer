import 'package:get/get.dart';
import '../global/repositories/repair_details_repo.dart';
import '../models/repair_details_model.dart';

class RepairDetailsController extends GetxService
{
  final RepairDetailsRepo repairDetailsRepo;
  RepairDetailsController({required this.repairDetailsRepo});

  List<dynamic> _repairDetailsList = [];
  List<dynamic> get repairDetailsList => _repairDetailsList;

  Future<void> getRepairDetailsList() async
  {
    Response response = await repairDetailsRepo.getRepairDetailsList();
    if(response.statusCode == 200)
    {
      print("Got details");
      _repairDetailsList = [];
      _repairDetailsList.addAll(Repair.fromJson(response.body).details);
      print(_repairDetailsList);
    }
    else {

    }
  }
}