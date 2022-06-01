import 'dart:async';
import 'package:automatik_users_app/global/global.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../assistants/assistant_methods.dart';
import '../assistants/geofire_assistant.dart';
import '../infoHandler/app_info.dart';
import '../main.dart';
import '../models/active_nearby_available_technician.dart';
import '../widgets/my_drawer.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(10.271752, 123.850748),
    zoom: 14.4746,
  );

  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();
  double searchLocationContainerHeight = 220;

  Position? customerCurrentPosition;
  var geoLocator = Geolocator();

  LocationPermission? _locationPermission;
  double bottomPaddingOfMap = 0;

  // String userName = "Name";
  // String userEmail = "Email";

  Set<Polyline> polyLineSet = {};

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  bool activeNearbyTechnicianKeysLoaded = false;

  List<ActiveNearbyAvailableTechnician> onlineNearbyAvailableTechnicianList = [];


  checkIfLocationPermissionAllowed() async
  {
    _locationPermission = await Geolocator.requestPermission();

    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  locateCustomerPosition() async
  {
    //give us the position of the current user
    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    customerCurrentPosition = cPosition;

    LatLng latLngPosition = LatLng(
        customerCurrentPosition!.latitude, customerCurrentPosition!.longitude);
    CameraPosition cameraPosition = CameraPosition(
        target: latLngPosition, zoom: 16);

    newGoogleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition));

    String humanReadableAddress = await AssistantMethods
        .searchAddressForGographicCoordinates(
        customerCurrentPosition!, context);
    print("This is your address = " + humanReadableAddress);

    // userName = customerModelCurrentInfo!.name!;
    // userEmail = customerModelCurrentInfo!.email!;
    //
    // print("name = " + userName);
    // print("email = " + userEmail);

    initializeGeofireListener();
  }


  @override
  void initState() {
    super.initState();

    checkIfLocationPermissionAllowed();
  }

  saveRequestInformation()
  {
    //save the request Information
    onlineNearbyAvailableTechnicianList = GeofireAssistant.activeNearbyAvailableTechnicianList;
    searchNearestOnlineTechnician();
  }

  searchNearestOnlineTechnician()
  async {
    if(onlineNearbyAvailableTechnicianList.length == 0)
    {
      //cancel/delete the request

      setState(() {
        polyLineSet.clear();
        markersSet.clear();
        circlesSet.clear();
      });
      Fluttertoast.showToast(msg: "No online nearest technician available");
      Fluttertoast.showToast(msg: "Restarting App Now");

      Future.delayed(const Duration(milliseconds: 4000), (){
        MyApp.restartApp(context);
      });
      return ;
    }

    await retrieveOnlineTechniciansInformation(onlineNearbyAvailableTechnicianList);
  }

  retrieveOnlineTechniciansInformation(List onlineNearestTechnicianList) async
  {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child("technician");
    for(int i = 0; i < onlineNearestTechnicianList.length; i++)
    {
      await ref.child(onlineNearestTechnicianList[i].key.toString()).once().then((dataSnapshot)
      {
        var techncianKeyInfo = dataSnapshot.snapshot.value;
        tList.add(techncianKeyInfo);
        print("TechnicianKey Information = " + tList.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: sKey,
      drawer: MyDrawer(
        name: customerModelCurrentInfo!.name,
        email: customerModelCurrentInfo!.email,
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              setState(() {
                bottomPaddingOfMap = 240;
              });

              locateCustomerPosition();
            },
          ),
          //custom hamburger Button for drawer
          Positioned(
            top: 45,
            left: 22,
            child: GestureDetector(
              onTap: () {
                sKey.currentState!.openDrawer();
              },
              child: const CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                    Icons.menu,
                    color: Colors.black54
                ),
              ),
            ),
          ),
          //UI for search location
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSize(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 120),
                child: Container(
                  height: searchLocationContainerHeight,
                  decoration: const BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 18),
                    child: Column(
                      children: [
                        //from
                        Row(
                          children: [
                            const Icon(
                              Icons.add_location_alt_outlined,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Use my current location",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    )
                                ),
                                Text(
                                    Provider
                                        .of<AppInfo>(context)
                                        .customerCurrentLocation != null
                                        ? (Provider
                                        .of<AppInfo>(context)
                                        .customerCurrentLocation!
                                        .locationName!).substring(0, 24) + "..."
                                        : "Not getting address.",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 10),

                        //use different location
                        // Row(
                        //   children: [
                        //     const Icon(
                        //       Icons.add_location_alt_outlined,
                        //       color: Colors.grey,
                        //     ),
                        //     const SizedBox(width: 12),
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         const Text("Select different location",
                        //             style: TextStyle(
                        //               color: Colors.grey,
                        //               fontSize: 14,
                        //             )
                        //         ),
                        //         Text("Where to go?",
                        //             style: const TextStyle(
                        //               color: Colors.grey,
                        //               fontSize: 18,
                        //             )
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 10),
                        // const Divider(
                        //   height: 1,
                        //   thickness: 1,
                        //   color: Colors.grey,
                        // ),
                        // const SizedBox(height: 10),


                        ElevatedButton(
                          child: const Text("Request a Technician",),
                          onPressed: ()
                          {
                            if(Provider.of<AppInfo>(context, listen: false).customerCurrentLocation != null)
                            {
                              saveRequestInformation();
                            }
                            else
                              {
                                Fluttertoast.showToast(msg: "Please select a specific location");
                              }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              textStyle: const TextStyle(fontSize: 16,
                                  fontWeight: FontWeight.bold)
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }

  initializeGeofireListener() {
    Geofire.initialize("activeTechnicians");

    Geofire.queryAtLocation(
        customerCurrentPosition!.latitude,
        customerCurrentPosition!.longitude, 10)!.listen((map) {
      print(map);
      if (map != null) {
        var callBack = map['callBack'];

        //latitude will be retrieved from map['latitude']
        //longitude will be retrieved from map['longitude']

        switch (callBack) {
          case Geofire.onKeyEntered: //whenever any technician become active-online
            ActiveNearbyAvailableTechnician activeNearbyAvailableTechnician = ActiveNearbyAvailableTechnician();
            activeNearbyAvailableTechnician.locationLatitude = map['latitude'];
            activeNearbyAvailableTechnician.locationLongitude = map['longitude'];
            activeNearbyAvailableTechnician.technicianId = map['key'];
            GeofireAssistant.activeNearbyAvailableTechnicianList.add(activeNearbyAvailableTechnician);
            if(activeNearbyTechnicianKeysLoaded == true)
            {
              displayActiveTechnicianOnCustomerMap();
            }
            break;

          case Geofire.onKeyExited: //whenever any technician become non-active-offline
            GeofireAssistant.deleteOfflineTechnicianFromList(map['key']);
            break;

          case Geofire.onKeyMoved:  //whenever the technician moves - update the technician location
            ActiveNearbyAvailableTechnician activeNearbyAvailableTechnician = ActiveNearbyAvailableTechnician();
            activeNearbyAvailableTechnician.locationLatitude = map['latitude'];
            activeNearbyAvailableTechnician.locationLongitude = map['longitude'];
            activeNearbyAvailableTechnician.technicianId = map['key'];
            GeofireAssistant.updateActiveNearbyAvailableTechnicianLocation(activeNearbyAvailableTechnician);
            displayActiveTechnicianOnCustomerMap();
            break;

          case Geofire.onGeoQueryReady: //display those online/active technicians to customer's map
            displayActiveTechnicianOnCustomerMap();
            break;
        }
      }

      setState(()
      {

      });
    });
  }

  displayActiveTechnicianOnCustomerMap()
  {
    setState(() {
      markersSet.clear();
      circlesSet.clear();

      Set<Marker> technicianMarkerSet = Set<Marker>();

      for(ActiveNearbyAvailableTechnician eachTechnician in GeofireAssistant.activeNearbyAvailableTechnicianList)
      {
        LatLng eachTechnicianActivePosition = LatLng(eachTechnician.locationLongitude!, eachTechnician.locationLatitude!);
        Marker marker = Marker(
          markerId:  MarkerId(eachTechnician.technicianId!),
          position: eachTechnicianActivePosition,
          icon:  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          rotation: 360,
        );
        
        technicianMarkerSet.add(marker);
      }

      setState(() {
        markersSet = technicianMarkerSet;
      });
    });
  }
}
