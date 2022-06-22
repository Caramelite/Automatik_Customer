import 'package:flutter/material.dart';

class RepairBodyPage extends StatefulWidget {
  const RepairBodyPage({Key? key}) : super(key: key);

  @override
  _RepairBodyPageState createState() => _RepairBodyPageState();
}

class _RepairBodyPageState extends State<RepairBodyPage> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 220;

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
        //print("Current page value: " + _currentPageValue.toString());
      });
    });
  }

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

  @override
  void dispose() {
    pageController.dispose();
  }

  Widget _buildPageItem(int index)
  {
    Matrix4 matrix = Matrix4.identity();
    if(index == _currentPageValue.floor())
    {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTransformation = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
    }
    else if (index == _currentPageValue.floor()+1){
      var currentScale = _scaleFactor + (_currentPageValue - index + 1) * (1 + _scaleFactor);
      var currentTransformation = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
          children: [
            Container(
              height: 220,
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
                height: 115,
                margin: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Brake Service Repair"),
                      SizedBox(height: 10),
                      Text("INFORMATION"),
                    ],
                  ),
                ),
              ),
            ),
          ]
      ),
    );
  }
}
