import 'package:PrimeMetrics/screens/tyre_management/tyre_rotation/select_truck_registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/screen_size.dart';

class TyreRotationHomeScreen extends StatefulWidget {
  const TyreRotationHomeScreen({Key? key}) : super(key: key);

  @override
  _TyreRotationHomeScreenState createState() => _TyreRotationHomeScreenState();
}

class _TyreRotationHomeScreenState extends State<TyreRotationHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int value = 0;
  List deployOn = ["Truck", "Trailer"];
  List images = [truck, trailer];

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
                      Get.back();
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
                    "Select Vehicle Type",
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
                        "Select Tyre for Rotation from:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18),
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
                                Container(padding: EdgeInsets.only(left: 10),child: Image.asset(images[index])),
                                Expanded(
                                  child: RadioListTile(
                                    controlAffinity: ListTileControlAffinity.trailing,
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
            Get.to(SelectTruckRegistrationScreen(), transition: Transition.rightToLeft);
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
