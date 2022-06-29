import 'package:flutter/material.dart';

import 'dimensions.dart';

class TitleIconInfo extends StatelessWidget {
  final IconData icon;
  final String text;
  final String minutes;
  final String? moreInfo;
  final Color iconColor;
  const TitleIconInfo({Key? key,
    required this.icon,
    required this.text,
    this.moreInfo,
    required this.minutes,
    required this.iconColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Icon(icon, color: iconColor, size: 15),
            const SizedBox(width: 5),
            Text(minutes, style: const TextStyle(fontSize: 12, color: Colors.black)),
          ],
        ),
        SizedBox(height: Dimensions.height10),
        Text(moreInfo!, style: const TextStyle(fontSize: 12, color: Colors.black)),
      ],
    );
  }
}
