import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dimensions.dart';

class TitleIconInfo extends StatelessWidget {
  final IconData icon;
  final String text;
  final String minutes;
  final Color iconColor;
  const TitleIconInfo({Key? key,
    required this.icon,
    required this.text,
    required this.minutes,
    required this.iconColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Icon(icon, color: iconColor, size: 15),
            Text(minutes, style: const TextStyle(fontSize: 14, color: Colors.black)),
          ],
        ),
        const SizedBox(width: 5),
        SizedBox(height: Dimensions.height10),
      ],
    );
  }
}
