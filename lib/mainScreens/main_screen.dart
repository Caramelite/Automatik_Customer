import 'package:flutter/material.dart';
import '../screens/repair_screen.dart';
import '../widgets/dimensions.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = PageController(viewportFraction: 0.85);
  final double _scaleFactor = 0.8;
  final double _height =  Dimensions.pageViewContainer;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: PageView.builder(
          controller: pageController,
          itemCount: 4,
          itemBuilder: (context, position){
            return _buildPageItem(position);
          }),
    );
  }

  Widget _buildPageItem(int index)
  {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30, bottom: 15, right: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(),
              ],
            ),
          ),
          const RepairBodyPage(),
        ],
      ),
    );
  }
}
