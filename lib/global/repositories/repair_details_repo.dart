import 'package:get/get.dart';
import '../data/api.dart';

class RepairDetailsRepo extends GetxService
{
  final ApiClient apiClient;
  RepairDetailsRepo({required this.apiClient});

  Future<Response> getRepairDetailsList() async
  {
    return await apiClient.getData("/details");
  }
}