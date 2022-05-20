import 'dart:async';
import 'package:automatik_users_app/global/global.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../assistants/assistant_methods.dart';
import '../infoHandler/app_info.dart';
import '../widgets/my_drawer.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
{
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

  checkIfLocationPermissionAllowed() async
  {
    _locationPermission = await Geolocator.requestPermission();

    if(_locationPermission == LocationPermission.denied)
    {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  locateCustomerPosition() async
  {
    //give us the position of the current user
    Position cPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    customerCurrentPosition = cPosition;

    LatLng latLngPosition = LatLng(customerCurrentPosition!.latitude, customerCurrentPosition!.longitude);
    CameraPosition cameraPosition = CameraPosition(target: latLngPosition, zoom: 16);
    
    newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String humanRedableAddress = await AssistantMethods.searchAddressForGographicCoordinates(customerCurrentPosition!, context);
    print("This is your address = " + humanRedableAddress);
  }


  @override
  void initState() {
    super.initState();

    checkIfLocationPermissionAllowed();
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
            onMapCreated: (GoogleMapController controller)
            {
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
              onTap: ()
              {
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
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
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
                                  Provider.of<AppInfo>(context).customerCurrentLocation != null
                                  ? (Provider.of<AppInfo>(context).customerCurrentLocation!.locationName!).substring(0, 36) + "..."
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

                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
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
}
