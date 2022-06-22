import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../widgets/dimensions.dart';

class RepairBodyPage extends StatefulWidget {
  const RepairBodyPage({Key? key}) : super(key: key);

  @override
  _RepairBodyPageState createState() => _RepairBodyPageState();
}

class _RepairBodyPageState extends State<RepairBodyPage> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Dimensions.pageView,
          child: PageView.builder(
              controller: pageController,
              itemCount: 4,
              itemBuilder: (context, position){
                return _buildPageItem(position);
              },
          ),
        ),
        SizedBox(height: Dimensions.height20),
        DotsIndicator(
          dotsCount: 4,
          position: _currentPageValue,
          decorator: DotsDecorator(
          size: const Size.square(9.0),
          activeSize: const Size(18.0, 9.0),
          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  Widget _buildPageItem(int index)
  {
      return Stack(
          children: [
            Container(
              height: Dimensions.pageViewContainer,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.lightBlue,
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("images/brake-service-repair.jpg")
                  )
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: const EdgeInsets.only(left: 30, right: 30),
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey,
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Brake Service Repair"),
                      SizedBox(height: Dimensions.height10),
                      const Text("Click for more informartion"),
                      SizedBox(height: Dimensions.height20),
                      Row(
                        children: const [
                          Icon(Icons.access_time_rounded, color: Colors.red, size: 18),
                          SizedBox(width: 10),
                          Text("30 minutes"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]
      );
  }
}

