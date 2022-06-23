import 'package:flutter/material.dart';

import 'dimensions.dart';
import 'small_text.dart';

class ExpandableRepairDetails extends StatefulWidget {
  final String text;
  const ExpandableRepairDetails({Key? key, required this.text}) : super(key: key);

  @override
  _ExpandableRepairDetailsState createState() => _ExpandableRepairDetailsState();
}

class _ExpandableRepairDetailsState extends State<ExpandableRepairDetails> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight/5.63;


  @override
  void initState() {
    super.initState();
    if(widget.text.length>textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    }else{
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty ? SmallText(text: firstHalf) : Column(
        children: [
          SmallText(text : hiddenText ? (firstHalf + "...") : (firstHalf + secondHalf)),
          
        ]
      ),
    );
  }
}
