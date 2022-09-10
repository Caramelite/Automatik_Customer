import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/dimensions.dart';
import '../../widgets/profile_widget.dart';
import '../../widgets/small_text.dart';
import '../auth_screen/login_screen.dart';

class ProfilePage extends StatefulWidget {
   const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
   final FirebaseAuth _auth = FirebaseAuth.instance;
   User? loggedInUser;

   @override
   void initState() {
     super.initState();

     getCurrentUser();
   }

   void getCurrentUser() async {
     try {
       User? user = _auth.currentUser;
       if (user != null) {
         setState(() {
           loggedInUser = user;
           // print('this is:  ${loggedInUser!.email}');
         });
       }
     } catch (e) {
       // print(e);
     }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(top: Dimensions.height20+Dimensions.height30),
          width: double.maxFinite,
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('Customers').where('Email', isEqualTo: loggedInUser!.email).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(!snapshot.hasData) return const Text("Loading...");
                      return ListView(
                      children: snapshot.data!.docs.map((DocumentSnapshot snap) {
                        return  Column(
                          children: [
                            //profile icon
                            const AppIcon(icon: Icons.person,
                              backgroundColor: Colors.blue,
                              iconColor: Colors.white,
                              iconSize: 85,
                              size: 130,
                            ),
                            SizedBox(height: Dimensions.height20),
                            ProfileWidget(
                                appIcon: const AppIcon(icon: Icons.person,
                                  backgroundColor: Colors.blue,
                                  iconColor: Colors.white,
                                  iconSize: 25,
                                  size: 40,
                                ),
                                smallText: SmallText(text: snap['Name'])
                            ),
                            SizedBox(height: Dimensions.height20),
                            //phone
                            ProfileWidget(
                                appIcon: const AppIcon(icon: Icons.phone,
                                  backgroundColor: Colors.yellow,
                                  iconColor: Colors.white,
                                  iconSize: 25,
                                  size: 40,
                                ),
                                smallText: SmallText(text: snap['Phone'])
                            ),
                            SizedBox(height: Dimensions.height20),
                            //email
                            ProfileWidget(
                                appIcon: const AppIcon(icon: Icons.email,
                                  backgroundColor: Colors.yellow,
                                  iconColor: Colors.white,
                                  iconSize: 25,
                                  size: 40,
                                ),
                                smallText: SmallText(text: snap['Email'])
                            ),
                            SizedBox(height: Dimensions.height20),
                            //address
                            ProfileWidget(
                                appIcon: const AppIcon(icon: Icons.location_on,
                                  backgroundColor: Colors.yellow,
                                  iconColor: Colors.white,
                                  iconSize: 25,
                                  size: 40,
                                ),
                                smallText: SmallText(text: snap['Address'])
                            ),
                            SizedBox(height: Dimensions.height20),
                            GestureDetector(
                              onTap: (){
                                FirebaseAuth.instance.signOut();
                                Get.to(() => const LoginScreen());
                              },
                              child: ProfileWidget(
                                  appIcon: const AppIcon(icon: Icons.logout,
                                    backgroundColor: Colors.redAccent,
                                    iconColor: Colors.white,
                                    iconSize: 25,
                                    size: 40,
                                  ),
                                  smallText: SmallText(text: "Logout")
                              ),
                            )
                          ],
                        );
                      }).toList(),
                      );
                    }
                ),
              ),


            ],
          )
      ),
    );
  }
}
