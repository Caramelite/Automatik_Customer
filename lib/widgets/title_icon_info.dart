import 'package:flutter/material.dart';

import 'dimensions.dart';

class TitleIconInfo extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? minutes;
  final String? moreInfo;
  final Color? iconColor;
  const TitleIconInfo({Key? key,
     this.icon,
     this.title,
    this.moreInfo,
     this.minutes,
     this.iconColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Icon(icon, color: iconColor, size: 15),
            const SizedBox(width: 5),
            Text(minutes!, style: const TextStyle(fontSize: 12, color: Colors.black)),
          ],
        ),
        SizedBox(height: Dimensions.height10),
        Text(moreInfo!, style: const TextStyle(fontSize: 12, color: Colors.black)),
      ],
    );
  }
}
