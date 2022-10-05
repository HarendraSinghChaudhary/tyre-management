

// ignore_for_file: prefer_const_constructors

import 'package:PrimeMetrics/screens/tyre_management/tyre_inspection/selected_tyre_inspection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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

class InspectionSelectTyre extends StatefulWidget {
  String regNumber;
  int vehicle_id;
  String deploy_on;
String odometer;
  InspectionSelectTyre({required this.regNumber, required this.vehicle_id, required this.odometer, required this.deploy_on});

  @override
  _SelectTyreRotationScreenState createState() =>
      _SelectTyreRotationScreenState();
}

class _SelectTyreRotationScreenState extends State<InspectionSelectTyre> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedCard = 0;

  TyreController tyreController = Get.put(TyreController(), permanent: false);
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

  bool frontLeft = false,
      frontRight = false,
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

    tyreController.getVehicleStructure(vehicleId: widget.vehicle_id, tyre_vehicle_id: widget.regNumber);

  



    // checkData();


  }


  @override
  Widget build(BuildContext context) {
    print("position: " + backLeftOut.toString());
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: primaryColors,
      body:

       Obx((() => 

     

       tyreController.isVehicleStructureLoading.value
                        ? Align(
                            alignment: Alignment.center,
                            child: Platform.isAndroid
                                ? CircularProgressIndicator()
                                : CupertinoActivityIndicator())
                        : 

      
      
      
      
       SingleChildScrollView(
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
                        "Truck # " + widget.regNumber.toString(),
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
            if (frontLeft ||
                frontRight ||
                middleLeftOut ||
                middleLeftIn ||
                middleRightIn ||
                middleRightOut ||
                backLeftOut ||
                backLeftIn ||
                backRightIn ||
                backRightOut) {

                        Get.to(SelectedTyreInspection(
                                    tyre_serial_number:  selectedModel.tyre_serial_number.toString(),
                                    thread_depth: selectedModel.tread_depth.toString(),
                                    recorded_psi: selectedModel.tyre_psi.toString(),
                                     max_psi: selectedModel.max_psi.toString(),
                                    recom_psi: selectedModel.recom_psi.toString(),
                                    tyre_id: selectedModel.id.toString(),
                                    odometer: widget.odometer,
                                    deploy_on: widget.deploy_on,
                                    
                                  ),
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
                color: (frontLeft ||
                        frontRight ||
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


                                  Get.to(SelectedTyreInspection(
                                    tyre_serial_number:  selectedModel.tyre_serial_number.toString(),
                                    thread_depth: selectedModel.tread_depth.toString(),
                                    recorded_psi: selectedModel.tyre_psi.toString(),
                                    max_psi: selectedModel.max_psi.toString(),
                                    recom_psi: selectedModel.recom_psi.toString(),
                                    tyre_id: selectedModel.id.toString(),
                                    odometer: widget.odometer,
                                    deploy_on: widget.deploy_on,
                                    
                                  ),
                                transition: Transition.rightToLeft);





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
                              print("1 Left outer");

                              positionaxle = "1LO";

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

                                frontLeft = true;

                                showBottomSheet(context);
                              } else {
                                      Get.defaultDialog(
                                    contentPadding: EdgeInsets.all(10),
                                    title: "",

                                    // titleStyle: TextStyle(color: Colors.black, fontSize: 17),

                                    content: Column(
                                      children: [
                                        Lottie.asset(
                                          "assets/images/loading.json",
                                          width: 200,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Tyre not found!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 140,
                                          height: 40,
                                          child: TextButton(
                                              style: TextButton.styleFrom(
                                              foregroundColor: Colors.amber,
                                               shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),

                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(
                                              "Ok",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                             
                             
                             
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              print(selectedModel.id);
                              frontRight = false;
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
                            height: frontLeft ? 60 : 40,
                            width: frontLeft ? 20 : 10,
                            decoration: BoxDecoration(
                                color: frontLeft ? green : Colors.black,
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
                              positionaxle = "1RO";

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

                                frontRight = true;

                                showBottomSheet(context);
                              } else {

                                   Get.defaultDialog(
                                    contentPadding: EdgeInsets.all(10),
                                    title: "",

                                    // titleStyle: TextStyle(color: Colors.black, fontSize: 17),

                                    content: Column(
                                      children: [
                                        Lottie.asset(
                                          "assets/images/loading.json",
                                          width: 200,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Tyre not found!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 140,
                                          height: 40,
                                          child: TextButton(
                                                style: TextButton.styleFrom(
                                              foregroundColor: Colors.amber,
                                               shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),

                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(
                                              "Ok",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                             
                             
                           
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeft = false;

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
                            height: frontRight ? 60 : 40, //60
                            width: frontRight ? 20 : 10, //20
                            decoration: BoxDecoration(
                                color: frontRight ? green : Colors.black,
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
                                   Get.defaultDialog(
                                    contentPadding: EdgeInsets.all(10),
                                    title: "",

                                    // titleStyle: TextStyle(color: Colors.black, fontSize: 17),

                                    content: Column(
                                      children: [
                                        Lottie.asset(
                                          "assets/images/loading.json",
                                          width: 200,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Tyre not found!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 140,
                                          height: 40,
                                          child: TextButton(
                                               style: TextButton.styleFrom(
                                              foregroundColor: Colors.amber,
                                               shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),

                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(
                                              "Ok",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                             
                             
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeft = false;
                              frontRight = false;

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
                                   Get.defaultDialog(
                                    contentPadding: EdgeInsets.all(10),
                                    title: "",

                                    // titleStyle: TextStyle(color: Colors.black, fontSize: 17),

                                    content: Column(
                                      children: [
                                        Lottie.asset(
                                          "assets/images/loading.json",
                                          width: 200,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Tyre not found!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 140,
                                          height: 40,
                                          child: TextButton(
                                                style: TextButton.styleFrom(
                                              foregroundColor: Colors.amber,
                                               shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),

                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(
                                              "Ok",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                             
                             
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeft = false;
                              frontRight = false;
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
                                   Get.defaultDialog(
                                    contentPadding: EdgeInsets.all(10),
                                    title: "",

                                    // titleStyle: TextStyle(color: Colors.black, fontSize: 17),

                                    content: Column(
                                      children: [
                                        Lottie.asset(
                                          "assets/images/loading.json",
                                          width: 200,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Tyre not found!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 140,
                                          height: 40,
                                          child: TextButton(
                                               style: TextButton.styleFrom(
                                              foregroundColor: Colors.amber,
                                               shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),

                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(
                                              "Ok",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                             
                             
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeft = false;
                              frontRight = false;
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
                                Get.defaultDialog(
                                    contentPadding: EdgeInsets.all(10),
                                    title: "",

                                    // titleStyle: TextStyle(color: Colors.black, fontSize: 17),

                                    content: Column(
                                      children: [
                                        Lottie.asset(
                                          "assets/images/loading.json",
                                          width: 200,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Tyre not found!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 140,
                                          height: 40,
                                          child: TextButton(
                                                style: TextButton.styleFrom(
                                              foregroundColor: Colors.amber,
                                               shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),

                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(
                                              "Ok",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                             
                             
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeft = false;
                              frontRight = false;
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
                                 Get.defaultDialog(
                                    contentPadding: EdgeInsets.all(10),
                                    title: "",

                                    // titleStyle: TextStyle(color: Colors.black, fontSize: 17),

                                    content: Column(
                                      children: [
                                        Lottie.asset(
                                          "assets/images/loading.json",
                                          width: 200,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Tyre not found!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 140,
                                          height: 40,
                                          child: TextButton(
                                                style: TextButton.styleFrom(
                                              foregroundColor: Colors.amber,
                                               shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),

                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(
                                              "Ok",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                             
                             
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeft = false;
                              frontRight = false;
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
                                 Get.defaultDialog(
                                    contentPadding: EdgeInsets.all(10),
                                    title: "",

                                    // titleStyle: TextStyle(color: Colors.black, fontSize: 17),

                                    content: Column(
                                      children: [
                                        Lottie.asset(
                                          "assets/images/loading.json",
                                          width: 200,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Tyre not found!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 140,
                                          height: 40,
                                          child: TextButton(
                                                style: TextButton.styleFrom(
                                              foregroundColor: Colors.amber,
                                               shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),

                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(
                                              "Ok",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                             
                             
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeft = false;
                              frontRight = false;
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
                               Get.defaultDialog(
                                    contentPadding: EdgeInsets.all(10),
                                    title: "",

                                    // titleStyle: TextStyle(color: Colors.black, fontSize: 17),

                                    content: Column(
                                      children: [
                                        Lottie.asset(
                                          "assets/images/loading.json",
                                          width: 200,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Tyre not found!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 140,
                                          height: 40,
                                          child: TextButton(
                                                style: TextButton.styleFrom(
                                              foregroundColor: Colors.amber,
                                               shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),

                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(
                                              "Ok",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                             
                             
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeft = false;
                              frontRight = false;
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
                                   Get.defaultDialog(
                                    contentPadding: EdgeInsets.all(10),
                                    title: "",

                                    // titleStyle: TextStyle(color: Colors.black, fontSize: 17),

                                    content: Column(
                                      children: [
                                        Lottie.asset(
                                          "assets/images/loading.json",
                                          width: 200,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                            "Tyre not found!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: 140,
                                          height: 40,
                                          child: TextButton(
                                                style: TextButton.styleFrom(
                                              foregroundColor: Colors.amber,
                                               shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),

                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text(
                                              "Ok",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ));
                             
                             
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeft = false;
                              frontRight = false;
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
