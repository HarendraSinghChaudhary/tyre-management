// ignore_for_file: unrelated_type_equality_checks

import 'package:PrimeMetrics/controllers/tyre/tyre_controller.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_home_screen.dart';
import 'package:PrimeMetrics/utils/colors.dart';
import 'package:PrimeMetrics/utils/screen_size.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../fuel_master/fuel_master_widgets/searchable_dropdown.dart';

class TyreRotationNewPositionScreen extends StatefulWidget {
  String regNumber;
  String axlePosition;
  String tyre_id;
  String tyre_position;
  String tyre_size;
  String deploy_on;

  TyreRotationNewPositionScreen(
      {required this.regNumber,
      required this.axlePosition,
      required this.tyre_id,
      required this.tyre_position,
      required this.tyre_size,
      required this.deploy_on,
      });

  @override
  _TyreRotationNewPositionScreenState createState() =>
      _TyreRotationNewPositionScreenState();
}

class _TyreRotationNewPositionScreenState
    extends State<TyreRotationNewPositionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? axleNew = "";
  String? tyre_positionNew = "";

  TyreController tyreController = Get.find();
  bool frontLeftOut = false, frontLeftIn = false, frontRightIn = false,
      frontRightOut = false,
      middleLeftOut = false,
      middleLeftIn = false,
      middleRightIn = false,
      middleRightOut = false,
      backLeftOut = false,
      backLeftIn = false,
      backRightIn = false,
      backRightOut = false;

  @override
  Widget build(BuildContext context) {
    print("object: "+widget.deploy_on.toString());
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
                    "Tyre New Position",
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bridgestone",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Tyre # " + widget.regNumber,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Tyre Size",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            // "123",
                            widget.tyre_size.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Position",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            //"2-RI",

                            widget.axlePosition.toString() +
                                "-" +
                                widget.tyre_position.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Select New Location",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    widget.deploy_on.trim() == "0" ?  getTyreViews() : getTrailerTyreViews()
                    ],
                  ),
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
            //Get.offAll(TyreHomeScreen(), transition: Transition.rightToLeft);


            if (tyre_positionNew.toString() != "" &&
                              axleNew.toString() != "") {

               showGeneralDialog(
              context: context,
              barrierColor: Colors.black.withOpacity(0.9),
              // Background color
              barrierDismissible: false,
              transitionDuration: Duration(milliseconds: 400),
              pageBuilder: (_, __, ___) {
                return StatefulBuilder(builder: (context, setState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                            text: 'Are you sure you want to move this tyre',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 24,
                              decoration: TextDecoration.none,
                            ),
                            children: [
                              TextSpan(
                                text: " from " +
                                    widget.axlePosition +
                                    "-" +
                                    widget.tyre_position +
                                    " to " +
                                    axleNew.toString() +
                                    "-" +
                                    tyre_positionNew.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: green,
                                  fontSize: 24,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              TextSpan(
                                text: ' ?',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 24,
                                  decoration: TextDecoration.none,
                                ),
                              )
                            ]),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (tyre_positionNew.toString() != "" &&
                              axleNew.toString() != "") {
                            Get.to(tyreController.rotateTyre(
                              deploy_on: widget.deploy_on,
                                tyre_position: tyre_positionNew.toString(),
                                tyreId: widget.tyre_id.toString(),
                                tyre_axel_id: axleNew.toString()));
                          } else {
                            Get.snackbar("Please select new tyre position", "");
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: ScreenSize.width * 0.82,
                          height: ScreenSize.height * 0.065,
                          child: const Text(
                            "Yes",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: 18,
                              decoration: TextDecoration.none,
                            ),
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
                              borderRadius: BorderRadius.circular(
                                  ScreenSize.width * 0.1)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: ScreenSize.width * 0.82,
                          height: ScreenSize.height * 0.065,
                          child: Text(
                            "No",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: green,
                              fontSize: 18,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3,
                                    spreadRadius: 1.2,
                                    offset: Offset(0, 3),
                                    color: Colors.black.withOpacity(0.3))
                              ],
                              borderRadius: BorderRadius.circular(
                                  ScreenSize.width * 0.1)),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  );
                });
              },
            );
        
        

            }else {

               Get.snackbar("Please select new tyre position", "");

            }



           
        
          },
          child: Container(
            alignment: Alignment.center,
            width: ScreenSize.width * 0.82,
            height: ScreenSize.height * 0.065,
            child: Text(
              "Done",
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

  Widget getTyreViews() {
    return Stack(
      fit: StackFit.loose,
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: ScreenSize.width * 0.5 - 40,
          child: VerticalDivider(
            color: Colors.black,
            thickness: 4,
            indent: 40,
            endIndent: 40,
          ),
        ),
        Column(
          children: [
            Container(
              height: ScreenSize.height * 0.1,
              color: Colors.grey.withOpacity(0.1),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              print("1 Left outer");

                              axleNew = "1";

                              tyre_positionNew = "LO";

                              frontLeftOut = true;
                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;
                            });
                          },
                          child: Container(
                            height: frontLeftOut ? 60 : 40,
                            width: frontLeftOut ? 20 : 10,
                            decoration: BoxDecoration(
                                color: frontLeftOut ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                  ),
                  Container(
                    width: 100,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    child: Divider(
                      color: Colors.black,
                      thickness: 4,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              axleNew = "1";

                              tyre_positionNew = "RO";

                              frontLeftOut = false;
                              frontRightOut = true;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;
                            });
                          },
                          child: Container(
                            height: frontRightOut ? 60 : 40, //60
                            width: frontRightOut ? 20 : 10, //20
                            decoration: BoxDecoration(
                                color: frontRightOut ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              height: ScreenSize.height * 0.1,
              color: Colors.grey.withOpacity(0.1),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              axleNew = "2";

                              tyre_positionNew = "LO";

                              frontLeftOut = false;
                              frontRightOut = false;
                              middleLeftOut = true;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;
                            });
                          },
                          child: Container(
                            height: middleLeftOut ? 60 : 40,
                            width: middleLeftOut ? 20 : 10,
                            decoration: BoxDecoration(
                                color: middleLeftOut ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              axleNew = "2";

                              tyre_positionNew = "LI";

                               frontLeftOut = false;
                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = true;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;
                            });
                          },
                          child: Container(
                            height: middleLeftIn ? 60 : 40,
                            width: middleLeftIn ? 20 : 10,
                            decoration: BoxDecoration(
                                color: middleLeftIn ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    width: 100,
                    child: Divider(
                      color: Colors.black,
                      thickness: 4,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              axleNew = "2";

                              tyre_positionNew = "RI";
                               frontLeftOut = false;
                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = true;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;
                            });
                          },
                          child: Container(
                            height: middleRightIn ? 60 : 40,
                            width: middleRightIn ? 20 : 10,
                            decoration: BoxDecoration(
                                color: middleRightIn ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              axleNew = "2";

                              tyre_positionNew = "RO";

                              frontLeftOut = false;
                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = true;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;
                            });
                          },
                          child: Container(
                            height: middleRightOut ? 60 : 40,
                            width: middleRightOut ? 20 : 10,
                            decoration: BoxDecoration(
                                color: middleRightOut ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: ScreenSize.height * 0.1,
              color: Colors.grey.withOpacity(0.1),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              axleNew = "3";

                              tyre_positionNew = "LO";

                               frontLeftOut = false;
                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = true;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;
                            });
                          },
                          child: Container(
                            height: backLeftOut ? 60 : 40,
                            width: backLeftOut ? 20 : 10,
                            decoration: BoxDecoration(
                                color: backLeftOut ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              axleNew = "3";

                              tyre_positionNew = "LI";

                              frontLeftOut = false;
                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = true;
                              backRightIn = false;
                              backRightOut = false;
                            });
                          },
                          child: Container(
                            height: backLeftIn ? 60 : 40,
                            width: backLeftIn ? 20 : 10,
                            decoration: BoxDecoration(
                                color: backLeftIn ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                  ),
                  Container(
                    width: 100,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    child: Divider(
                      color: Colors.black,
                      thickness: 4,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              axleNew = "3";

                              tyre_positionNew = "RI";

                              frontLeftOut = false;
                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = true;
                              backRightOut = false;
                            });
                          },
                          child: Container(
                            height: backRightIn ? 60 : 40,
                            width: backRightIn ? 20 : 10,
                            decoration: BoxDecoration(
                                color: backRightIn ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              axleNew = "3";

                              tyre_positionNew = "RO";

                              frontLeftOut = false;
                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = true;
                            });
                          },
                          child: Container(
                            height: backRightOut ? 60 : 40,
                            width: backRightOut ? 20 : 10,
                            decoration: BoxDecoration(
                                color: backRightOut ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }


 Widget getTrailerTyreViews() {
    return Stack(
      fit: StackFit.loose,
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: ScreenSize.width * 0.5 - 40,
          child: VerticalDivider(
            color: Colors.black,
            thickness: 4,
            indent: 40,
            endIndent: 40,
          ),
        ),
        Column(
          children: [
            Container(
              height: ScreenSize.height * 0.1,
              color: Colors.grey.withOpacity(0.1),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {

                                  setState(() {
                              frontLeftOut = true;
                              frontLeftIn = false;
                              frontRightIn = false;

                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;

                                 axleNew = "1";

                              tyre_positionNew = "LO";






                            });
                         
                         
                          },
                          child: Container(
                            height: frontLeftOut ? 60 : 40,
                            width: frontLeftOut ? 20 : 10,
                            decoration: BoxDecoration(
                                color: frontLeftOut ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                                  setState(() {
                              frontLeftOut = false;
                              frontLeftIn = true;
                              frontRightIn = false;

                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;

                                 axleNew = "1";

                              tyre_positionNew = "LI";






                            });
                          
                         
                         
                          },
                          child: Container(
                            height: frontLeftIn ? 60 : 40,
                            width: frontLeftIn ? 20 : 10,
                            decoration: BoxDecoration(
                                color: frontLeftIn ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    width: 100,
                    child: Divider(
                      color: Colors.black,
                      thickness: 4,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                                 setState(() {
                              frontLeftOut = false;
                              frontLeftIn = false;
                              frontRightIn = true;

                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;

                                  axleNew = "1";

                              tyre_positionNew = "RI";






                            });
                          
                          },
                          child: Container(
                            height: frontRightIn ? 60 : 40,
                            width: frontRightIn ? 20 : 10,
                            decoration: BoxDecoration(
                                color: frontRightIn ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                                  setState(() {
                              frontLeftOut = false;
                              frontLeftIn = false;
                              frontRightIn = false;

                              frontRightOut = true;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;

                                  axleNew = "1";

                              tyre_positionNew = "RO";






                            });
                           
                         
                          },
                          child: Container(
                            height: frontRightOut ? 60 : 40,
                            width: frontRightOut ? 20 : 10,
                            decoration: BoxDecoration(
                                color: frontRightOut ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              height: ScreenSize.height * 0.1,
              color: Colors.grey.withOpacity(0.1),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                                 setState(() {
                              frontLeftOut = false;
                              frontLeftIn = false;
                              frontRightIn = false;

                              frontRightOut = false;
                              middleLeftOut = true;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;

                                 axleNew = "2";

                              tyre_positionNew = "LO";






                            });
                           
                          },
                          child: Container(
                            height: middleLeftOut ? 60 : 40,
                            width: middleLeftOut ? 20 : 10,
                            decoration: BoxDecoration(
                                color: middleLeftOut ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                                 setState(() {
                              frontLeftOut = false;
                              frontLeftIn = false;
                              frontRightIn = false;

                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = true;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;

                                  axleNew = "2";

                              tyre_positionNew = "LI";






                            });
                
                          
                          },
                          child: Container(
                            height: middleLeftIn ? 60 : 40,
                            width: middleLeftIn ? 20 : 10,
                            decoration: BoxDecoration(
                                color: middleLeftIn ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    width: 100,
                    child: Divider(
                      color: Colors.black,
                      thickness: 4,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                                 setState(() {
                              frontLeftOut = false;
                              frontLeftIn = false;
                              frontRightIn = false;

                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = true;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;

                                 axleNew = "2";

                              tyre_positionNew = "RI";






                            });
                          
                         
                          },
                          child: Container(
                            height: middleRightIn ? 60 : 40,
                            width: middleRightIn ? 20 : 10,
                            decoration: BoxDecoration(
                                color: middleRightIn ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                                  setState(() {
                              frontLeftOut = false;
                              frontLeftIn = false;
                              frontRightIn = false;

                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = true;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;

                             

                                   axleNew = "2";

                              tyre_positionNew = "RO";






                            });
                         
                          },
                          child: Container(
                            height: middleRightOut ? 60 : 40,
                            width: middleRightOut ? 20 : 10,
                            decoration: BoxDecoration(
                                color: middleRightOut ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: ScreenSize.height * 0.1,
              color: Colors.grey.withOpacity(0.1),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                                  setState(() {
                              frontLeftOut = false;
                              frontLeftIn = false;
                              frontRightIn = false;

                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = true;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;

                       

                                   axleNew = "3";

                              tyre_positionNew = "LO";






                            });
                       
                          },
                          child: Container(
                            height: backLeftOut ? 60 : 40,
                            width: backLeftOut ? 20 : 10,
                            decoration: BoxDecoration(
                                color: backLeftOut ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                                 setState(() {
                              frontLeftOut = false;
                              frontLeftIn = false;
                              frontRightIn = false;

                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = true;
                              backRightIn = false;
                              backRightOut = false;

                 

                                   axleNew = "3";

                              tyre_positionNew = "LI";






                            });
                 
                         
                          },
                          child: Container(
                            height: backLeftIn ? 60 : 40,
                            width: backLeftIn ? 20 : 10,
                            decoration: BoxDecoration(
                                color: backLeftIn ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                  ),
                  Container(
                    width: 100,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    child: Divider(
                      color: Colors.black,
                      thickness: 4,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                                 setState(() {
                              frontLeftOut = false;
                              frontLeftIn = false;
                              frontRightIn = false;

                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = true;
                              backRightOut = false;


                                   axleNew = "3";

                              tyre_positionNew = "RI";






                            });
       
                         
                          },
                          child: Container(
                            height: backRightIn ? 60 : 40,
                            width: backRightIn ? 20 : 10,
                            decoration: BoxDecoration(
                                color: backRightIn ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                                  setState(() {
                              frontLeftOut = false;
                              frontLeftIn = false;
                              frontRightIn = false;

                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = true;

                         

                                   axleNew = "3";

                              tyre_positionNew = "RO";






                            });
                    
                          
                          
                          },
                          child: Container(
                            height: backRightOut ? 60 : 40,
                            width: backRightOut ? 20 : 10,
                            decoration: BoxDecoration(
                                color: backRightOut ? green : Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

 

}
