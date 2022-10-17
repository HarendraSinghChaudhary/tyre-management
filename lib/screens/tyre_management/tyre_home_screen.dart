import 'package:PrimeMetrics/controllers/fuel/fuel_controller.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_dismount/dismount_home_screen.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_inspection/inspection_home_screen.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_mount/mount_home_screen.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_onboarding/onboarding_home_screen.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_retiring/tyre_retiring_home_screen.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_retread/retread_home_screen.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_rotation/tyre_rotation_home_screen.dart';
import 'package:PrimeMetrics/utils/app_extensions.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:PrimeMetrics/utils/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/tyre/tyre_controller.dart';
import '../../utils/colors.dart';
import '../../utils/screen_size.dart';

class TyreHomeScreen extends StatefulWidget {
  const TyreHomeScreen({Key? key}) : super(key: key);

  @override
  _TyreHomeScreenState createState() => _TyreHomeScreenState();
}

class _TyreHomeScreenState extends State<TyreHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TyreController tyreController = Get.find();
  FuelController fuelController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tyreController.getStoreList;
    tyreController.getTyreBrandList();
    tyreController.getTyreModelList();
    tyreController.getTyreSizeList();
    tyreController.getTyreSpecificationList();
    tyreController.getThreadPatternList();
    tyreController.getTyreVendorList();
    tyreController.getTyreList();

    // tyreController.getVehicles();
  }

  @override
  Widget build(BuildContext context) {
    // print("token Home: "+ getUserInfo()!.data!.token.toString());
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: primaryColors,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 50, left: 30, right: 30, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome To",
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                  Text(
                    "Tyre Management",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: green,
                        fontSize: 22),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    Get.to(OnboardingHomeScreen(), transition: Transition.rightToLeft);
                  },
                  child: Container(
                    height: ScreenSize.height * 0.2,
                    width: ScreenSize.width * 0.4,
                    decoration: BoxDecoration(
                      color: HexColor.fromHex('#CCCE58'),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(tyre_onboarding),
                        SizedBox(height: 10,),
                        Text(
                          "Tyre Onboarding",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Get.to(TyreRotationHomeScreen(), transition: Transition.rightToLeft);
                  },
                  child: Container(
                    height: ScreenSize.height * 0.2,
                    width: ScreenSize.width * 0.4,
                    decoration: BoxDecoration(
                        color: HexColor.fromHex('#1BC9D4'),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(tyre_rotation),
                        SizedBox(height: 10,),
                        Text(
                          "Tyre Rotation",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    Get.to(MountHomeScreen(tyreId: 1), transition: Transition.rightToLeft);
                  },
                  child: Container(
                    height: ScreenSize.height * 0.2,
                    width: ScreenSize.width * 0.4,
                    decoration: BoxDecoration(
                        color: HexColor.fromHex('#55AAE6'),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(tyre_mount),
                        SizedBox(height: 10,),
                        Text(
                          "Mount",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Get.to(DismountHomeScreen(), transition: Transition.rightToLeft);
                  },
                  child: Container(
                    height: ScreenSize.height * 0.2,
                    width: ScreenSize.width * 0.4,
                    decoration: BoxDecoration(
                        color: HexColor.fromHex('#E627DD'),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(tyre_dismount),
                        SizedBox(height: 10,),
                        Text(
                          "Dismount",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    Get.to(RetreadScreen(), transition: Transition.rightToLeft);
                  },
                  child: Container(
                    height: ScreenSize.height * 0.2,
                    width: ScreenSize.width * 0.4,
                    decoration: BoxDecoration(
                        color: HexColor.fromHex('#E69D32'),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(tyre_retread),
                        SizedBox(height: 10,),
                        Text(
                          "Retread",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Get.to(InspectionHomeScreen(), transition: Transition.rightToLeft);
                  },
                  child: Container(
                    height: ScreenSize.height * 0.2,
                    width: ScreenSize.width * 0.4,
                    decoration: BoxDecoration(
                        color: HexColor.fromHex('#73E63E'),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(tyre_inspection),
                        SizedBox(height: 10,),
                        Text(
                          "Inspection",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    Get.to(TyreRetiringHomeScreen(), transition: Transition.rightToLeft);
                  },
                  child: Container(
                    height: ScreenSize.height * 0.2,
                    width: ScreenSize.width * 0.4,
                    decoration: BoxDecoration(
                        color: HexColor.fromHex('#E65527'),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(tyre_retire),
                        SizedBox(height: 10,),
                        Text(
                          "Retire Tyre",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: ScreenSize.height * 0.2,
                  width: ScreenSize.width * 0.4,
                ),
              ],
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
