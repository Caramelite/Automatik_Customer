import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../../widgets/dimensions.dart';
import '../../widgets/title_icon_info.dart';

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
                  borderRadius: BorderRadius.circular(18),
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
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 12, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  const [
                       TitleIconInfo(
                        text: "Brake Repair Service",
                         iconColor: Colors.red,
                         icon: Icons.access_time_rounded,
                         minutes: ' 30 minutes',
                      ),
                      Text("Click for more information")
                    ],
                  ),
                ),
              ),
            ),
          ]
      );
  }
}

