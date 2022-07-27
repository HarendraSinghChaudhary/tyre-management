// ignore_for_file: prefer_const_constructors

import 'package:PrimeMetrics/screens/tyre_management/tyre_home_screen.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_inspection/inspection_registarion_number.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_inspection/shop_inspection_screen.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';

class InspectionHomeScreen extends StatefulWidget {
  const InspectionHomeScreen({Key? key}) : super(key: key);

  @override
  _InspectionHomeScreenState createState() => _InspectionHomeScreenState();
}

class _InspectionHomeScreenState extends State<InspectionHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int value = 0;
  List deployOn = ["Truck", "Trailer", "Store"];
  List images = [truck, trailer, shop];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: primaryColors,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.offAll(TyreHomeScreen(),
                          transition: Transition.leftToRight);
                    },
                    child: CircleAvatar(
                      backgroundColor: green,
                      radius: 18,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    "Select Tyre",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 22),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(30),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Select Tyre From",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(10),
                            child: Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Image.asset(images[index])),
                                Expanded(
                                  child: RadioListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    activeColor: green,
                                    value: index,
                                    groupValue: value,
                                    onChanged: (index) {
                                      setState(
                                        () {
                                          value = int.parse(index.toString());
                                        },
                                      );
                                    },
                                    title: Text(deployOn[index] ?? ""),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: deployOn.length,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        alignment: Alignment.center,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () async {
            print("value: " + value.toString());

            switch (value) {
              case 0:
                {
                  Get.to(InspectionRegistrationCode(value: value, deploy_on: value.toString(),),
                      transition: Transition.rightToLeft);
                }
                // do something
                break;
              case 1:
                {
                  Get.to(InspectionRegistrationCode(value: value, deploy_on: value.toString(),),
                      transition: Transition.rightToLeft);
                }
                // do something else
                break;
              case 2:
                {
                  Get.to(ShopInspectionScreen(
                    deploy_on: value.toString(),
                  ),
                      transition: Transition.rightToLeft);
                }
                break;
        
            }

        
          },
          child: Container(
            alignment: Alignment.center,
            width: ScreenSize.width * 0.82,
            height: ScreenSize.height * 0.065,
            child: Text(
              "Next",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: 18),
            ),
            decoration: BoxDecoration(
                color: green,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 3,
                      spreadRadius: 1.2,
                      offset: Offset(0, 3),
                      color: Colors.black.withOpacity(0.3))
                ],
                borderRadius: BorderRadius.circular(ScreenSize.width * 0.1)),
          ),
        ),
      ),
    );
  }
}
