import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/repair_details_controller.dart';
import '../../models/repair_details_model.dart';
import '../../utils/route_helper.dart';
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
          Container(
            margin: const EdgeInsets.only(top: 35, bottom: 15, right: 0),
          ),
          GetBuilder<RepairDetailsController>(builder : (repairDetails) {
            return repairDetails.isLoaded ? SizedBox(
              height: Dimensions.pageView,
              child: PageView.builder(
                controller: pageController,
                itemCount: repairDetails.repairDetailsList.length,
                itemBuilder: (context, position){
                  return _buildPageItem(position, repairDetails.repairDetailsList[position]);
                },
              ),
            ) : const CircularProgressIndicator(color: Colors.grey);
          }),
          SizedBox(height: Dimensions.height20),
          GetBuilder<RepairDetailsController>(builder: (repairDetails){
            return DotsIndicator(
              dotsCount: repairDetails.repairDetailsList.isEmpty ? 1 : repairDetails.repairDetailsList.length,
              position: _currentPageValue,
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            );
          }),
        ],
      );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Widget _buildPageItem(int index, RepairDetailsModel repairDetails)
  {
      return Stack(
          children: [
            Container(
              height: Dimensions.pageViewContainer,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.lightBlue,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(repairDetails.img!)
                  )
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getRepairDetails(index, "home"));
              },
              child: Align(
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
                      children: [
                         TitleIconInfo(
                          title: repairDetails.title!,
                           iconColor: Colors.red,
                           icon: Icons.access_time_rounded,
                           minutes: repairDetails.minutes!,
                           moreInfo: "Click for more information",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]
      );
  }
}

