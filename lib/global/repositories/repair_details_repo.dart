import 'package:automatik_users_app/utils/constants.dart';
import 'package:get/get.dart';
import '../data/api.dart';

class RepairDetailsRepo extends GetxService
{
  final ApiClient apiClient;
  RepairDetailsRepo({required this.apiClient});

  Future<Response> getRepairDetailsList() async
  {
    return await apiClient.getData(Constants.DETAILS_URI);
    //full download link https://drive.google.com/uc?export=download&id=1kXJynPtq-uaQ1NJUujlP5Jeldyw1kLJD
    //full json file link https://drive.google.com/file/d/1kXJynPtq-uaQ1NJUujlP5Jeldyw1kLJD/view?usp=sharing
    //full folder link https://drive.google.com/drive/folders/1s8I0yZ1xzEWqeMSLGTalBLUtYcuASV6B?usp=sharing
  }
}