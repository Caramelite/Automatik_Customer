import 'package:automatik_users_app/assistants/request_assistant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import '../global/global.dart';
import '../global/map_key.dart';
import '../models/user_model.dart';

class AssistantMethods
{
  static Future<String> searchAddressForGographicCoordinates(Position position) async
  {
    String apiUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    String humanRedableAddress = "";

    var requestResponse = await RequestAssistant.receivedRequest(apiUrl);
    if(requestResponse != "Error Occured. Failed, no response.")
    {
      humanRedableAddress = requestResponse["results"][0]["formatted_address"];
    }
    return humanRedableAddress;
  }

  static void readCurrentOnLineUserInfo() async
  {
    currentFirebaseUser = fAuth.currentUser;

    DatabaseReference customerRef = FirebaseDatabase.instance.ref()
        .child("customer").child(currentFirebaseUser!.uid);

    customerRef.once().then((snap)
    {
      if(snap.snapshot.value != null)
      {
        customerModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
      }
    });
  }
}