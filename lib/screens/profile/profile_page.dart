import 'package:flutter/material.dart';

import '../../widgets/app_icon.dart';
import '../../widgets/dimensions.dart';
import '../../widgets/profile_widget.dart';
import '../../widgets/small_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text("Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: Dimensions.height20),
        width: double.maxFinite,
        child: Column(
          children: [
            //profile icon
            const AppIcon(icon: Icons.person,
              backgroundColor: Colors.blue,
              iconColor: Colors.white,
              iconSize: 85,
              size: 130,
            ),
            SizedBox(height: Dimensions.height20),
           Expanded(
             child:  SingleChildScrollView(
               child: Column(
                 children: [
                   //name
                   ProfileWidget(
                       appIcon: const AppIcon(icon: Icons.person,
                         backgroundColor: Colors.blue,
                         iconColor: Colors.white,
                         iconSize: 25,
                         size: 40,
                       ),
                       smallText: SmallText(text: "camrs")
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
                       smallText: SmallText(text: "912314123")
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
                       smallText: SmallText(text: "carmelatrujillo@gmail.com")
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
                       smallText: SmallText(text: "Fill in your address")
                   ),
                   SizedBox(height: Dimensions.height20),
                   //message
                   ProfileWidget(
                       appIcon: const AppIcon(icon: Icons.message_outlined,
                         backgroundColor: Colors.redAccent,
                         iconColor: Colors.white,
                         iconSize: 25,
                         size: 40,
                       ),
                       smallText: SmallText(text: "camrs")
                   ),
                 ],
               ),
             ),
           )
          ],
        )
      ),
    );
  }
}
