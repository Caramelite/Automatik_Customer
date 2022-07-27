import '../models/active_nearby_available_technician.dart';

class GeofireAssistant
{
  static List<ActiveNearbyAvailableTechnician> activeNearbyAvailableTechnicianList = [];

  static void deleteOfflineTechnicianFromList(String technicianId)
  {
    int indexNumber = activeNearbyAvailableTechnicianList.indexWhere((element) => element.technicianId == technicianId);
    activeNearbyAvailableTechnicianList.removeAt(indexNumber);
  }

  static void updateActiveNearbyAvailableTechnicianLocation(ActiveNearbyAvailableTechnician technicianMoves)
  {
    int indexNumber = activeNearbyAvailableTechnicianList.indexWhere((element) => element.technicianId == technicianMoves.technicianId);

    activeNearbyAvailableTechnicianList[indexNumber].locationLatitude = technicianMoves.locationLatitude;
    activeNearbyAvailableTechnicianList[indexNumber].locationLongitude = technicianMoves.locationLongitude;
  }
}