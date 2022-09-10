import 'package:automatik_users_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'app_icon.dart';
import 'dimensions.dart';

class ProfileWidget extends StatelessWidget {
  AppIcon appIcon;
  SmallText smallText;
  ProfileWidget({Key? key, required this.appIcon, required this.smallText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10, left: Dimensions.width20, right: Dimensions.width20),
      decoration: BoxDecoration(
          color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: const Offset(0, 2),
            color: Colors.grey.withOpacity(0.2)
          )
        ]
      ), child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20),
          smallText
        ],
      )
    );
  }
}
