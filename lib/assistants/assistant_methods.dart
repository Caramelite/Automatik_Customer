import 'package:automatik_users_app/assistants/request_assistant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../global/map_key.dart';
import '../infoHandler/app_info.dart';
import '../models/directions.dart';


class AssistantMethods
{
  static Future<String> searchAddressForGographicCoordinates(Position position, context ) async
  {
    String apiUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    String humanRedableAddress = "";

    var requestResponse = await RequestAssistant.receivedRequest(apiUrl);
    if(requestResponse != "Error Occured. Failed, no response.")
    {
      // if (requestResponse != null && requestResponse.length != 0){
      //   humanRedableAddress = requestResponse["results"][0]["formatted_address"];
      // }

      humanRedableAddress = requestResponse["results"][0]["formatted_address"];

      Directions customerCurrentAddress = Directions();
      customerCurrentAddress.locationLatitude = position.latitude;
      customerCurrentAddress.locationLongitude = position.longitude;
      customerCurrentAddress.locationName = humanRedableAddress;

      Provider.of<AppInfo>(context, listen: false)
          .updateCurentLocationAddress(customerCurrentAddress);
    }
    return humanRedableAddress;
  }

// static void readCurrentOnLineUserInfo() async
// {
//   currentFirebaseUser = fAuth.currentUser;

//   DatabaseReference customerRef = FirebaseDatabase.instance.ref()
//       .child("customer").child(currentFirebaseUser!.uid);

//   customerRef.once().then((snap)
//   {
//     if(snap.snapshot.value != null)
//     {
//       customerModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
//     }
//   });
// }
}