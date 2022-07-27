// ignore_for_file: prefer_const_constructors

import 'package:PrimeMetrics/screens/tyre_management/tyre_inspection/selected_tyre_inspection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';
import '../../fuel_master/fuel_master_widgets/searchable_dropdown.dart';

import 'dart:io';

import 'package:PrimeMetrics/controllers/tyre/tyre_controller.dart';
import 'package:PrimeMetrics/models/tyre_module/vehicle_structure.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_rotation/tyre_rotation_new_position_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';

class TrailerSelectTyreInspection extends StatefulWidget {
  String regNumber;
  int vehicle_id;
  String odometer;
  String? deploy_on;
  TrailerSelectTyreInspection(
      {required this.regNumber,
      required this.vehicle_id,
      required this.deploy_on,
      required this.odometer});

  @override
  _SelectTyreRotationScreenState createState() =>
      _SelectTyreRotationScreenState();
}

class _SelectTyreRotationScreenState
    extends State<TrailerSelectTyreInspection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedCard = 0;

  TyreController tyreController = Get.find();
  VehecleStructure selectedModel = VehecleStructure();
  int vehicleId = 0;
  String? tyre_psi;
  String? tread_depth;
  String? regNumber;
  String? axle;
  String? positionaxle;
  String? totalUnit;
  String? max_psi;
  String? recom_psi;

  bool frontLeftOut = false,
      frontLeftIn = false,
      frontRightIn = false,
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
  void initState() {
    super.initState();

    tyreController.vehicleStructureList;

    tyreController.getVehicleStructure(vehicleId: widget.vehicle_id);

    // checkData();
  }

  // checkData() {
  //   bool exist1LI = false;
  //   bool exist1RO = false;
  //   bool exist2LO = false;
  //   bool exist2LI = false;
  //   bool exist2RI = false;
  //   bool exist2RO = false;
  //   bool exist3LO = false;
  //   bool exist3LI = false;
  //   bool exist3RI = false;
  //   bool exist3RO = false;

  //   if (tyreController.vehicleStructureList.isNotEmpty) {
  //     tyreController.vehicleStructureList.forEach((element) {
  //       if (element.tyre_position == "LO" && element.tyre_axel_id == "1") {
  //         exist1LI = true;
  //       }
  //     });
  //     if (exist1LI) {
  //       selectedModel = tyreController.vehicleStructureList.firstWhere(
  //           (element) =>
  //               element.tyre_axel_id == "1" && element.tyre_position == "LO");

  //       frontLeft = true;
  //     }

  //     tyreController.vehicleStructureList.forEach((element) {
  //       if (element.tyre_position == "RO" && element.tyre_axel_id == "1") {
  //         exist1RO = true;
  //       }
  //     });
  //     if (exist1RO) {
  //       selectedModel = tyreController.vehicleStructureList.firstWhere(
  //           (element) =>
  //               element.tyre_axel_id == "1" && element.tyre_position == "RO");

  //       frontRight = true;
  //     }

  //     tyreController.vehicleStructureList.forEach((element) {
  //       if (element.tyre_position == "LO" && element.tyre_axel_id == "2") {
  //         exist2LO = true;
  //       }
  //     });
  //     if (exist2LO) {
  //       selectedModel = tyreController.vehicleStructureList.firstWhere(
  //           (element) =>
  //               element.tyre_axel_id == "2" && element.tyre_position == "LO");

  //       middleLeftOut = true;
  //     }

  //     tyreController.vehicleStructureList.forEach((element) {
  //       if (element.tyre_position == "LI" && element.tyre_axel_id == "2") {
  //         exist2LI = true;
  //       }
  //     });
  //     if (exist2LI) {
  //       selectedModel = tyreController.vehicleStructureList.firstWhere(
  //           (element) =>
  //               element.tyre_axel_id == "2" && element.tyre_position == "LI");

  //       middleLeftIn = true;
  //     }

  //     tyreController.vehicleStructureList.forEach((element) {
  //       if (element.tyre_position == "RI" && element.tyre_axel_id == "2") {
  //         exist2RI = true;
  //       }
  //     });
  //     if (exist2RI) {
  //       selectedModel = tyreController.vehicleStructureList.firstWhere(
  //           (element) =>
  //               element.tyre_axel_id == "2" && element.tyre_position == "RI");

  //       middleRightIn = true;
  //     }

  //     tyreController.vehicleStructureList.forEach((element) {
  //       if (element.tyre_position == "RO" && element.tyre_axel_id == "2") {
  //         exist2RO = true;
  //       }
  //     });
  //     if (exist2RO) {
  //       selectedModel = tyreController.vehicleStructureList.firstWhere(
  //           (element) =>
  //               element.tyre_axel_id == "2" && element.tyre_position == "RO");

  //       middleRightOut = true;
  //     }

  //     tyreController.vehicleStructureList.forEach((element) {
  //       if (element.tyre_position == "LO" && element.tyre_axel_id == "3") {
  //         exist3LO = true;
  //       }
  //     });
  //     if (exist3LO) {
  //       selectedModel = tyreController.vehicleStructureList.firstWhere(
  //           (element) =>
  //               element.tyre_axel_id == "3" && element.tyre_position == "LO");

  //       backLeftOut = true;
  //     }

  //     tyreController.vehicleStructureList.forEach((element) {
  //       if (element.tyre_position == "LI" && element.tyre_axel_id == "3") {
  //         exist3LI = true;
  //       }
  //     });
  //     if (exist3LI) {
  //       selectedModel = tyreController.vehicleStructureList.firstWhere(
  //           (element) =>
  //               element.tyre_axel_id == "3" && element.tyre_position == "LI");

  //       backLeftIn = true;
  //     }

  //     tyreController.vehicleStructureList.forEach((element) {
  //       if (element.tyre_position == "RI" && element.tyre_axel_id == "3") {
  //         exist3RI = true;
  //       }
  //     });
  //     if (exist3RI) {
  //       selectedModel = tyreController.vehicleStructureList.firstWhere(
  //           (element) =>
  //               element.tyre_axel_id == "3" && element.tyre_position == "RI");

  //       backRightIn = true;
  //     }

  //     tyreController.vehicleStructureList.forEach((element) {
  //       if (element.tyre_position == "RO" && element.tyre_axel_id == "3") {
  //         exist3RO = true;
  //       }
  //     });
  //     if (exist3RO) {
  //       selectedModel = tyreController.vehicleStructureList.firstWhere(
  //           (element) =>
  //               element.tyre_axel_id == "3" && element.tyre_position == "RO");

  //       backRightOut = true;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    print("position: " + backLeftOut.toString());
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: primaryColors,
      body: Obx((() => tyreController.isSubmitting.value
          ? Align(
              alignment: Alignment.center,
              child: Platform.isAndroid
                  ? CircularProgressIndicator()
                  : CupertinoActivityIndicator())
          : SingleChildScrollView(
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
                              "Following Tyres are currently mounted on",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Trailer # " + widget.regNumber.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          getTyreViews(),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                "Click on a tyre to view details",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ))),
      bottomNavigationBar: Container(
        height: 100,
        alignment: Alignment.center,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () async {
            if (frontLeftOut ||
                frontLeftIn ||
                frontRightIn ||
                frontRightOut ||
                middleLeftOut ||
                middleLeftIn ||
                middleRightIn ||
                middleRightOut ||
                backLeftOut ||
                backLeftIn ||
                backRightIn ||
                backRightOut) {
              Get.to(
                  SelectedTyreInspection(
                      tyre_serial_number:
                          selectedModel.tyre_serial_number.toString(),
                      thread_depth: selectedModel.tread_depth.toString(),
                      recorded_psi: selectedModel.tyre_psi.toString(),
                      max_psi: selectedModel.max_psi.toString(),
                      recom_psi: selectedModel.recom_psi.toString(),
                      tyre_id: selectedModel.id.toString(),
                      deploy_on: widget.deploy_on,
                      odometer: widget.odometer),
                  transition: Transition.rightToLeft);
              // Get.to(
              //     TyreRotationNewPositionScreen(
              //       tyre_id: selectedModel.id.toString(),
              //       regNumber: widget.regNumber,
              //       axlePosition: selectedModel.tyre_axel_id.toString(),
              //       tyre_position: selectedModel.tyre_position.toString(),
              //       tyre_size: selectedModel.size_name.toString(),
              //     ),
              //     transition: Transition.rightToLeft);
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
                color: (frontLeftOut ||
                frontLeftIn ||
                frontRightIn ||
                frontRightOut ||
                middleLeftOut ||
                middleLeftIn ||
                middleRightIn ||
                middleRightOut ||
                backLeftOut ||
                backLeftIn ||
                backRightIn ||
                backRightOut)
                    ? green
                    : Colors.grey,
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

  Widget tyreDetailView(int index) {
    return InkWell(
      onTap: () {
        /*setState(() {
          selectedCard = index;
        });*/
      },
      child: Container(
        width: ScreenSize.width * 0.9,
        height: ScreenSize.height * 0.4,
        /*margin: EdgeInsets.symmetric(vertical: 20),*/
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                spreadRadius: 1,
                offset: const Offset(0, 3),
                color: Colors.black.withOpacity(0.3))
          ],
          color: green,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          /*border: (selectedCard == index)
              ? Border.all(color: green, width: 5)
              : null,*/
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bridgestone",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        "Tyre # ",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                      Text(
                        selectedModel.tyre_serial_number.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        spreadRadius: 1.2,
                        offset: const Offset(0, 3),
                        color: Colors.black.withOpacity(0.3))
                  ],
                  /*borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),*/
                  color: primaryColors,
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Thread Depth",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              //"123",
                              selectedModel.tread_depth.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Recorded PSI",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              // "123",

                              selectedModel.tyre_psi.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Expanded(
                              child: Text(
                                "Maximum PSI",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              // "123",
                              selectedModel.max_psi.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Expanded(
                              child: Text(
                                "Recommended PSI",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              // "123",
                              selectedModel.recom_psi.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        child: InkWell(
                          splashColor: Colors.transparent,
                          onTap: () async {
                            Get.to(
                                SelectedTyreInspection(
                                    tyre_serial_number: selectedModel
                                        .tyre_serial_number
                                        .toString(),
                                    thread_depth:
                                        selectedModel.tread_depth.toString(),
                                    recorded_psi:
                                        selectedModel.tyre_psi.toString(),
                                    max_psi: selectedModel.max_psi.toString(),
                                    recom_psi:
                                        selectedModel.recom_psi.toString(),
                                    tyre_id: selectedModel.id.toString(),
                                    deploy_on: widget.deploy_on,
                                    odometer: widget.odometer),
                                transition: Transition.rightToLeft);

                            // if (selectedModel.tyre_position.toString() != "" &&
                            //     selectedModel.tyre_axel_id.toString() != "") {
                            //   Get.to(TyreRotationNewPositionScreen(
                            //     tyre_id: selectedModel.id.toString(),
                            //     regNumber: widget.regNumber,
                            //     axlePosition:
                            //         selectedModel.tyre_axel_id.toString(),
                            //     tyre_position:
                            //         selectedModel.tyre_position.toString(),
                            //     tyre_size:
                            //         selectedModel.size_name.toString(),
                            //   ));
                            // } else {
                            //   Get.snackbar("Please select tyre position", "");
                            // }
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
                              borderRadius: BorderRadius.circular(
                                ScreenSize.width * 0.1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            )
          ],
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
                              bool exist = false;
                              tyreController.vehicleStructureList
                                  .forEach((element) {
                                if (element.tyre_position == "LO" &&
                                    element.tyre_axel_id == "1") {
                                  exist = true;
                                }
                              });
                              if (exist) {
                                selectedModel = tyreController
                                    .vehicleStructureList
                                    .firstWhere((element) =>
                                        element.tyre_axel_id == "1" &&
                                        element.tyre_position == "LO");

                               frontLeftOut = true;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              
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
                              bool exist = false;
                              tyreController.vehicleStructureList
                                  .forEach((element) {
                                if (element.tyre_position == "LI" &&
                                    element.tyre_axel_id == "1") {
                                  exist = true;
                                }
                              });
                              if (exist) {
                                selectedModel = tyreController
                                    .vehicleStructureList
                                    .firstWhere((element) =>
                                        element.tyre_axel_id == "1" &&
                                        element.tyre_position == "LI");

                               frontLeftIn = true;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeftOut = false;
                              
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
                              bool exist = false;
                              tyreController.vehicleStructureList
                                  .forEach((element) {
                                if (element.tyre_position == "RI" &&
                                    element.tyre_axel_id == "1") {
                                  exist = true;
                                }
                              });
                              if (exist) {
                                selectedModel = tyreController
                                    .vehicleStructureList
                                    .firstWhere((element) =>
                                        element.tyre_axel_id == "1" &&
                                        element.tyre_position == "RI");

                                frontRightIn = true;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeftOut = false;
                              frontLeftIn = false;
                              
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
                              bool exist = false;
                              tyreController.vehicleStructureList
                                  .forEach((element) {
                                if (element.tyre_position == "RO" &&
                                    element.tyre_axel_id == "1") {
                                  exist = true;
                                }
                              });
                              if (exist) {
                                selectedModel = tyreController
                                    .vehicleStructureList
                                    .firstWhere((element) =>
                                        element.tyre_axel_id == "1" &&
                                        element.tyre_position == "RO");

                                 frontRightOut = true;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeftOut = false;
                              frontLeftIn = false;
                              frontRightIn = false;
                             
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
                              bool exist = false;
                              tyreController.vehicleStructureList
                                  .forEach((element) {
                                if (element.tyre_position == "LO" &&
                                    element.tyre_axel_id == "2") {
                                  exist = true;
                                }
                              });
                              if (exist) {
                                selectedModel = tyreController
                                    .vehicleStructureList
                                    .firstWhere((element) =>
                                        element.tyre_axel_id == "2" &&
                                        element.tyre_position == "LO");

                                middleLeftOut = true;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                               frontLeftOut = false;
                              frontLeftIn = false;
                              frontRightIn = false;
                              frontRightOut = false;
                           
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
                              bool exist = false;
                              tyreController.vehicleStructureList
                                  .forEach((element) {
                                if (element.tyre_position == "LI" &&
                                    element.tyre_axel_id == "2") {
                                  exist = true;
                                }
                              });
                              if (exist) {
                                selectedModel = tyreController
                                    .vehicleStructureList
                                    .firstWhere((element) =>
                                        element.tyre_axel_id == "2" &&
                                        element.tyre_position == "LI");

                                middleLeftIn = true;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                                frontLeftOut = false;
                              frontLeftIn = false;
                              frontRightIn = false;
                              frontRightOut = false;
                              middleLeftOut = false;

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
                              bool exist = false;
                              tyreController.vehicleStructureList
                                  .forEach((element) {
                                if (element.tyre_position == "RI" &&
                                    element.tyre_axel_id == "2") {
                                  exist = true;
                                }
                              });
                              if (exist) {
                                selectedModel = tyreController
                                    .vehicleStructureList
                                    .firstWhere((element) =>
                                        element.tyre_axel_id == "2" &&
                                        element.tyre_position == "RI");

                                middleRightIn = true;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                                frontLeftOut = false;
                              frontLeftIn = false;
                              frontRightIn = false;
                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;

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
                              bool exist = false;
                              tyreController.vehicleStructureList
                                  .forEach((element) {
                                if (element.tyre_position == "RO" &&
                                    element.tyre_axel_id == "2") {
                                  exist = true;
                                }
                              });
                              if (exist) {
                                selectedModel = tyreController
                                    .vehicleStructureList
                                    .firstWhere((element) =>
                                        element.tyre_axel_id == "2" &&
                                        element.tyre_position == "RO");

                                middleRightOut = true;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                             frontLeftOut = false;
                              frontLeftIn = false;
                              frontRightIn = false;
                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;

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
                              bool exist = false;
                              tyreController.vehicleStructureList
                                  .forEach((element) {
                                if (element.tyre_position == "LO" &&
                                    element.tyre_axel_id == "3") {
                                  exist = true;
                                }
                              });
                              if (exist) {
                                selectedModel = tyreController
                                    .vehicleStructureList
                                    .firstWhere((element) =>
                                        element.tyre_axel_id == "3" &&
                                        element.tyre_position == "LO");

                                backLeftOut = true;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeftOut = false;
                              frontLeftIn = false;
                              frontRightIn = false;
                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;

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
                              bool exist = false;
                              tyreController.vehicleStructureList
                                  .forEach((element) {
                                if (element.tyre_position == "LI" &&
                                    element.tyre_axel_id == "3") {
                                  exist = true;
                                }
                              });
                              if (exist) {
                                selectedModel = tyreController
                                    .vehicleStructureList
                                    .firstWhere((element) =>
                                        element.tyre_axel_id == "3" &&
                                        element.tyre_position == "LI");

                                backLeftIn = true;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                          frontLeftOut = false;
                              frontLeftIn = false;
                              frontRightIn = false;
                              frontRightOut = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;

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
                              bool exist = false;
                              tyreController.vehicleStructureList
                                  .forEach((element) {
                                if (element.tyre_position == "RI" &&
                                    element.tyre_axel_id == "3") {
                                  exist = true;
                                }
                              });
                              if (exist) {
                                selectedModel = tyreController
                                    .vehicleStructureList
                                    .firstWhere((element) =>
                                        element.tyre_axel_id == "3" &&
                                        element.tyre_position == "RI");

                                backRightIn = true;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

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
                              bool exist = false;
                              tyreController.vehicleStructureList
                                  .forEach((element) {
                                if (element.tyre_position == "RO" &&
                                    element.tyre_axel_id == "3") {
                                  exist = true;
                                }
                              });
                              if (exist) {
                                selectedModel = tyreController
                                    .vehicleStructureList
                                    .firstWhere((element) =>
                                        element.tyre_axel_id == "3" &&
                                        element.tyre_position == "RO");

                                backRightOut = true;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

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

 
 
 
 
  showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (context) {
          return tyreDetailView(0);
        });
  }

  tyreMgmt() {
    if (tyreController.vehicleStructureList.length != 0) {
      selectedModel = tyreController.vehicleStructureList.first;
      // id = selectedModel.id.toString();
      //   getClassElementApi();

      print("selected model " + selectedModel.toString());
    }
  }
}
