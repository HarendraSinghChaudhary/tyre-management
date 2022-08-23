// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:io';

import 'package:PrimeMetrics/controllers/tyre/tyre_controller.dart';
import 'package:PrimeMetrics/models/tyre_module/vehicle_structure.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:PrimeMetrics/utils/toast.dart';
import 'package:animations/animations.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';
import '../../fuel_master/fuel_master_widgets/searchable_dropdown.dart';
import '../../fuel_master/fuel_master_widgets/shadow_textfield.dart';
import '../tyre_home_screen.dart';

class DismountHomeScreen extends StatefulWidget {
  const DismountHomeScreen({Key? key}) : super(key: key);

  @override
  _DismountHomeScreenState createState() => _DismountHomeScreenState();
}

class _DismountHomeScreenState extends State<DismountHomeScreen> {
  int vehicleId = 0;
  String? tyre_psi;
  String? tread_depth;
  String? regNumber;
  String? axle;
  String? positionaxle;
  String? totalUnit;

  String? reason;

  // ignore: prefer_final_fields
  String _1LO = "1LO";

  String? id;

  //  Map<String, dynamic> data;

  VehecleStructure selectedModel = VehecleStructure();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late bool _isFirstCompleted;
  late bool _isSecondCompleted;
  late bool _isThirdCompleted;
  late bool _isFourthCompleted;
  final SharedAxisTransitionType _transitionType =
      SharedAxisTransitionType.horizontal;

  final TextEditingController odometerController = TextEditingController();
  TyreController tyreController = Get.put(TyreController(), permanent: false);
  int value = 0;
  List deployOn = ["Truck", "Trailer"];
  List images = [truck, trailer];

  void _toggleFirst() {
    setState(() {
      _isFirstCompleted = !_isFirstCompleted;
    });
  }

  void _toggleSecond() {
    setState(() {
      _isSecondCompleted = !_isSecondCompleted;
    });
  }

  void _toggleThird() {
    setState(() {
      _isThirdCompleted = !_isThirdCompleted;
    });
  }

  void _toggleFourth() {
    setState(() {
      _isFourthCompleted = !_isFourthCompleted;
    });

    print("press here step 4" + _isFourthCompleted.toString());
  }

  bool isCheckboxSelected = false;
  int selectedCard = 0;

  RxBool frontLeftOut = false.obs,
      frontLeftIn = false.obs,
      frontRightIn = false.obs,
      frontRightOut = false.obs,
      middleLeftOut = false.obs,
      middleLeftIn = false.obs,
      middleRightIn = false.obs,
      middleRightOut = false.obs,
      backLeftOut = false.obs,
      backLeftIn = false.obs,
      backRightIn = false.obs,
      backRightOut = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isFirstCompleted = false;
    _isSecondCompleted = false;
    _isThirdCompleted = false;
    _isFourthCompleted = false;

    tyreController.vehicleStructureList;
    tyreMgmt();
     tyreController.getVehicles("0");

    tyreController.dismountReason();
    tyreController.dismountReasonList;
  }

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 300),
      reverse: !_isFirstCompleted,
      transitionBuilder: (
        Widget child,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return SharedAxisTransition(
          child: child,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: _transitionType,
        );
      },
      child: _isThirdCompleted
          ? fourthStep()
          : _isSecondCompleted
              ? thirdStep()
              : _isFirstCompleted
                  ? secondStep()
                  : firstStep(),
    );
  }

  firstStep() {
    return Scaffold(
      backgroundColor: primaryColors,
      key: _scaffoldKey,
      body: 



      Obx((() => 


           tyreController.isSubmitting.value
                        ? Align(
                            alignment: Alignment.center,
                            child: Platform.isAndroid
                                ? CircularProgressIndicator()
                                : CupertinoActivityIndicator())
                        :


                            
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: primaryColors,
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
                      "Vehicle Details",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 22),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 35,
                      height: 8,
                      decoration: BoxDecoration(
                          color: green,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      width: 15,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      width: 15,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      width: 15,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
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
                      Text(
                        "Dismount From",
                        style: TextStyle(color: Colors.black, fontSize: 18),
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
                                             tyreController.getVehicles(value.toString());
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
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      Obx((() => 

                        SearchableDropdown(
                        withIcon: false,
                        enabled: true,
                        hintText: "Select Registration Number",
                        listItems: tyreController.companyVehicles
                            .map((e) => "${e.regNumber}")
                            .toList(),
                        onChanged: (value) {
                          vehicleId = tyreController.companyVehicles
                                  .firstWhere(
                                      (element) => value == element.regNumber)
                                  .id ??
                              0;

                          regNumber = tyreController.companyVehicles
                              .firstWhere(
                                  (element) => value == element.regNumber)
                              .regNumber
                              .toString();

                          print("regNumber onChanged $vehicleId");
                          print("regNumber  $regNumber");
                          // data.remove('vehicle_id');
                          // data.putIfAbsent('vehicle_id', () => vehicleId);
                        },
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                            hintText: "Search",
                            border: InputBorder.none,
                          ),
                        ),
                      )
                     
                     
                      
                      
                      
                      )),
                    
                     
                      SizedBox(
                        height: 10,
                      ),
                      ShadowTextField(
                        maxLine: 1,
                        keyboardType: TextInputType.number,
                        controller: odometerController,
                        hintText: "Odometer Reading",
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
      
      
      
      
      
      )),
      
      
      
      
  
      
      bottomNavigationBar: Container(
        height: 100,
        alignment: Alignment.center,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () async {
            print("press here!");
            //  _toggleSecond();
            if (odometerController.text.isNotEmpty && vehicleId != 0) {
              print("press here1!");
              await tyreController
                  .getVehicleStructure(vehicleId: vehicleId, tyre_vehicle_id : regNumber.toString())
                  .then((value) {
                print("press here2");
                if (value) {
                  _toggleFirst();
                }
              });
            } else {
              show("Error", "All Fields are required");
            }

            tyreMgmt();
          },
          child: Container(
            alignment: Alignment.center,
            width: ScreenSize.width * 0.82,
            height: ScreenSize.height * 0.065,
            child:       Obx((() => 

                    tyreController.isVehicleStructureLoading.value
                        ? Align(
                            alignment: Alignment.center,
                            child: Platform.isAndroid
                                ? CircularProgressIndicator(color: Colors.white, strokeWidth: 1,)
                                : CupertinoActivityIndicator())
                        :
                             
             
            Text(
              "Next",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: 18),
            )
           
           
            )),
            decoration: BoxDecoration(
              color: green,
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 1.2,
                  offset: Offset(0, 3),
                  color: Colors.black.withOpacity(0.3),
                )
              ],
              borderRadius: BorderRadius.circular(
                ScreenSize.width * 0.1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  secondStep() {
    print("length: " + tyreController.vehicleStructureList.length.toString());
    return Scaffold(
      backgroundColor: primaryColors,
      key: _scaffoldKey,
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
        child: Container(
          color: primaryColors,
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
                        // Get.back();


                        
                      

                  frontLeftOut.value = false;
      frontLeftIn.value = false;
      frontRightIn.value = false;
      frontRightOut.value = false;
      middleLeftOut.value = false;
      middleLeftIn.value = false;
      middleRightIn.value = false;
      middleRightOut.value = false;
      backLeftOut.value = false;
      backLeftIn.value = false;
      backRightIn.value = false;
      backRightOut.value = false;
                        
                         tyreController.vehicleStructureList.clear();
                        
                _toggleFirst();
                         setState(() {
                           
                         });
                        
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
                      "Mounted Tyres",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 22),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 15,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      width: 35,
                      height: 8,
                      decoration: BoxDecoration(
                          color: green,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      width: 15,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      width: 15,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                     value == 0 ? getTyreViews() : getTrailerTyreViews(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
        ),
      )
     
     
      
      
      
      
      )),
      
      
      
   
     
      bottomNavigationBar: Container(
        height: 100,
        alignment: Alignment.center,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () async {
            if (frontLeftOut.value || 
            frontLeftIn.value || 
            frontRightIn.value ||
            frontRightOut.value ||
                middleLeftOut.value ||
                middleLeftIn.value ||
                middleRightIn.value ||
                middleRightOut.value ||
                backLeftOut.value ||
                backLeftIn.value ||
                backRightIn.value ||
                backRightOut.value) {
              _toggleSecond();
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
              color: (frontLeftOut.value || frontLeftIn .value|| frontRightIn.value ||
                      frontRightOut .value||
                      middleLeftOut .value||
                      middleLeftIn.value ||
                      middleRightIn .value||
                      middleRightOut.value ||
                      backLeftOut.value ||
                      backLeftIn.value ||
                      backRightIn.value ||
                      backRightOut.value)
                  ? green
                  : Colors.grey,
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 1.2,
                  offset: Offset(0, 3),
                  color: Colors.black.withOpacity(0.3),
                )
              ],
              borderRadius: BorderRadius.circular(
                ScreenSize.width * 0.1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  thirdStep() {
    return Scaffold(
      backgroundColor: primaryColors,
      key: _scaffoldKey,
      body: 


         tyreController.isDismountReason.value
                        ? Align(
                            alignment: Alignment.center,
                            child: Platform.isAndroid
                                ? CircularProgressIndicator()
                                : CupertinoActivityIndicator())
                        :

      
      
      
      
      
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: primaryColors,
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
                        // Get.back();
                        _toggleSecond();
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
                      "Select Dismount Reason",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 22),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 15,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      width: 15,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      width: 35,
                      height: 8,
                      decoration: BoxDecoration(
                          color: green,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      width: 15,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
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
                         SearchableDropdown(
                          withIcon: false,
                          enabled: true,
                          hintText: "Reason to Dismount",
                          listItems: tyreController.dismountReasonList
                              .map((e) => "${e.dismount_reason}")
                              .toList(),
                          onChanged: (value) {
                            id = tyreController.dismountReasonList
                                .firstWhere((element) =>
                                    value == element.dismount_reason.toString())
                                .id
                                .toString();

                            reason = tyreController.dismountReasonList
                                .firstWhere((element) =>
                                    value == element.dismount_reason.toString())
                                .dismount_reason
                                .toString();

                            print("id: " + id.toString());
                            print("reason depth: " + reason.toString());

                            // widget.data.remove('store');
                            // widget.data.putIfAbsent('store', () => storeCodeSerialNumber);
                          },
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              hintText: "Search",
                              border: InputBorder.none,
                            ),
                          ),
                        ),

                      // SearchableDropdown(
                      //   withIcon: false,
                      //   enabled: true,
                      //   hintText: "Reason to Dismount",
                      //   listItems: tyreController.dismountReasonList
                      //       .map((e) => "${e.dismountResion}")
                      //       .toList(),
                      //   onChanged: (value) {
                      //     id  = tyreController.dismountReasonList
                      //             .firstWhere(
                      //                 (element) => value == element.id)
                      //             .id ??
                      //         0;

                      //     reason = tyreController.dismountReasonList
                      //         .firstWhere(
                      //             (element) => value == element.dismountResion)
                      //         .dismountResion
                      //         .toString();

                      //     print("reason onChanged $id");
                      //     print("reason  $reason");
                      //     // data.remove('vehicle_id');
                      //     // data.putIfAbsent('vehicle_id', () => vehicleId);
                      //   },
                      //   searchFieldProps: TextFieldProps(
                      //     decoration: InputDecoration(
                      //       suffixIcon: Icon(
                      //         Icons.keyboard_arrow_down,
                      //         color: Colors.black,
                      //       ),
                      //       hintText: "Search",
                      //       border: InputBorder.none,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        value: isCheckboxSelected,
                        onChanged: (value) {
                          setState(() {
                            isCheckboxSelected = value ?? false;
                          });
                        },
                        title: Text("Dismount from Rims"),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        alignment: Alignment.center,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () async {
            print("press..one");

            _toggleThird();
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
              color: (frontLeftOut.value || frontLeftIn.value || frontRightIn.value ||
                      frontRightOut.value ||
                      middleLeftOut.value ||
                      middleLeftIn.value ||
                      middleRightIn.value ||
                      middleRightOut.value ||
                      backLeftOut.value ||
                      backLeftIn .value||
                      backRightIn .value||
                      backRightOut.value)
                  ? green
                  : Colors.grey,
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 1.2,
                  offset: Offset(0, 3),
                  color: Colors.black.withOpacity(0.3),
                )
              ],
              borderRadius: BorderRadius.circular(
                ScreenSize.width * 0.1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  fourthStep() {
    return Scaffold(
      backgroundColor: primaryColors,
      key: _scaffoldKey,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: primaryColors,
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
                        // Get.back();
                        _toggleThird();
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
                      "Confirmation",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 22),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 15,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      width: 15,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      width: 15,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Container(
                      width: 35,
                      height: 8,
                      decoration: BoxDecoration(
                          color: green,
                          borderRadius: BorderRadius.circular(30)),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Are you sure?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text.rich(
                          // ignore: prefer_const_literals_to_create_immutables
                          TextSpan(children: [
                            TextSpan(
                              text: "you want to dismount Tyre #",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: selectedModel.tyre_serial_number.toString(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            TextSpan(
                              text: " from Vehicle " +
                                  regNumber.toString() +
                                  " from position ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            TextSpan(
                              text: selectedModel.tyre_axel_id.toString() +
                                  selectedModel.tyre_position.toString(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            )
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            tyreController.isSubmitting.value
                ? Align(
                    alignment: Alignment.center,
                    child: Platform.isAndroid
                        ? CircularProgressIndicator()
                        : CupertinoActivityIndicator())
                : Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: () async {
                        tyreController.tyreUnMount(
                          deploy_on: value.toString(),
                            vehicle_id: vehicleId.toString(),
                            odometer: odometerController.text.toString().trim(),
                            tyre_id: selectedModel.id.toString(),
                            dismount_resion: reason.toString());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: ScreenSize.width * 0.82,
                        height: ScreenSize.height * 0.065,
                        child: 

                         Obx((() => 


                           tyreController.isSubmitting.value
                        ? Align(
                            alignment: Alignment.center,
                            child: Platform.isAndroid
                                ? CircularProgressIndicator(color: Colors.white, strokeWidth: 1,)
                                : CupertinoActivityIndicator())
                        :

                        
                        
                        
                        Text(
                          "DISMOUNT",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: 18),
                        ))),
                        decoration: BoxDecoration(
                          color: green,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              spreadRadius: 1.2,
                              offset: Offset(0, 3),
                              color: Colors.black.withOpacity(0.3),
                            )
                          ],
                          borderRadius: BorderRadius.circular(
                            ScreenSize.width * 0.1,
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  _toggleThird();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: ScreenSize.width * 0.82,
                  height: ScreenSize.height * 0.065,
                  child: Text(
                    "Change Configuration",
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
                      borderRadius:
                          BorderRadius.circular(ScreenSize.width * 0.1)),
                ),
              ),
            )
          ],
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
                              //  widget.serialNumber.toString().trim() == "null" ?  tyre_psi.toString() : tyreController.maximum_psi.toString(),
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
                            Navigator.pop(context);
                            _toggleSecond();
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

                                        frontLeftOut = true.obs;

                                showBottomSheet(context);
                              } else {
                              Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              

                              print(selectedModel.id);
                              frontLeftIn = false.obs;
                              frontRightIn = false.obs;
                              frontRightOut = false.obs;
                              middleLeftOut = false.obs;
                              middleLeftIn = false.obs;
                              middleRightIn = false.obs;
                              middleRightOut = false.obs;
                              backLeftOut = false.obs;
                              backLeftIn = false.obs;
                              backRightIn = false.obs;
                              backRightOut = false.obs;
                            });
                          },
                          child: Container(
                            height: frontLeftOut.value ? 60 : 40,
                            width: frontLeftOut.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: frontLeftOut.value ? green : Colors.black,
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

                                         frontRightOut = true.obs;

                                showBottomSheet(context);
                              } else {
                              Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeftOut = false.obs;
                             
                              middleLeftOut = false.obs;
                              middleLeftIn = false.obs;
                              middleRightIn = false.obs;
                              middleRightOut = false.obs;
                              backLeftOut = false.obs;
                              backLeftIn = false.obs;
                              backRightIn = false.obs;
                              backRightOut = false.obs;
                            });

                  
                          },
                          child: Container(
                            height: frontRightOut.value ? 60 : 40, //60
                            width: frontRightOut.value ? 20 : 10, //20
                            decoration: BoxDecoration(
                                color: frontRightOut.value ? green : Colors.black,
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

                                         middleLeftOut = true.obs;

                                showBottomSheet(context);
                              } else {
                              Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeftOut = false.obs;
                              frontRightOut = false.obs;
                             
                              middleLeftIn = false.obs;
                              middleRightIn = false.obs;
                              middleRightOut = false.obs;
                              backLeftOut = false.obs;
                              backLeftIn = false.obs;
                              backRightIn = false.obs;
                              backRightOut = false.obs;
                            });
                        
                          },
                          child: Container(
                            height: middleLeftOut.value ? 60 : 40,
                            width: middleLeftOut.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: middleLeftOut.value ? green : Colors.black,
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

                                           middleLeftIn = true.obs;

                                showBottomSheet(context);
                              } else {
                               Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeftOut = false.obs;
                              frontRightOut = false.obs;
                              middleLeftOut = false.obs;
                           
                              middleRightIn = false.obs;
                              middleRightOut = false.obs;
                              backLeftOut = false.obs;
                              backLeftIn = false.obs;
                              backRightIn = false.obs;
                              backRightOut = false.obs;
                            });
                
                          },
                          child: Container(
                            height: middleLeftIn.value ? 60 : 40,
                            width: middleLeftIn.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: middleLeftIn.value ? green : Colors.black,
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

                                          middleRightIn = true.obs;

                                showBottomSheet(context);
                              } else {
                               Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeftOut = false.obs;
                              frontRightOut = false.obs;
                              middleLeftOut = false.obs;
                              middleLeftIn = false.obs;
                            
                              middleRightOut = false.obs;
                              backLeftOut = false.obs;
                              backLeftIn = false.obs;
                              backRightIn = false.obs;
                              backRightOut = false.obs;
                            });
                      
                          },
                          child: Container(
                            height: middleRightIn.value ? 60 : 40,
                            width: middleRightIn.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: middleRightIn.value ? green : Colors.black,
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

                                          middleRightOut = true.obs;

                                showBottomSheet(context);
                              } else {
                              Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeftOut = false.obs;
                              frontRightOut = false.obs;
                              middleLeftOut = false.obs;
                              middleLeftIn = false.obs;
                              middleRightIn = false.obs;
                            
                              backLeftOut = false.obs;
                              backLeftIn = false.obs;
                              backRightIn = false.obs;
                              backRightOut = false.obs;
                            });
                
                          },
                          child: Container(
                            height: middleRightOut.value ? 60 : 40,
                            width: middleRightOut.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: middleRightOut.value ? green : Colors.black,
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

                                           backLeftOut = true.obs;

                                showBottomSheet(context);
                              } else {
                               Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeftOut = false.obs;
                              frontRightOut = false.obs;
                              middleLeftOut = false.obs;
                              middleLeftIn = false.obs;
                              middleRightIn = false.obs;
                              middleRightOut = false.obs;
                           
                              backLeftIn = false.obs;
                              backRightIn = false.obs;
                              backRightOut = false.obs;
                            });
                   
                          },
                          child: Container(
                            height: backLeftOut.value ? 60 : 40,
                            width: backLeftOut.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: backLeftOut.value ? green : Colors.black,
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

                                          backLeftIn = true.obs;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              selectedModel = tyreController
                                  .vehicleStructureList
                                  .firstWhere((element) =>
                                      element.tyre_axel_id == "3" &&
                                      element.tyre_position == "LI");
                              frontLeftOut = false.obs;
                              frontRightOut = false.obs;
                              middleLeftOut = false.obs;
                              middleLeftIn = false.obs;
                              middleRightIn = false.obs;
                              middleRightOut = false.obs;
                              backLeftOut = false.obs;
                            
                              backRightIn = false.obs;
                              backRightOut = false.obs;
                            });
                       
                          },
                          child: Container(
                            height: backLeftIn.value ? 60 : 40,
                            width: backLeftIn.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: backLeftIn.value ? green : Colors.black,
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

                                          backRightIn = true.obs;

                                showBottomSheet(context);
                              } else {
                             Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                          
                              frontLeftOut = false.obs;
                              frontRightOut = false.obs;
                              middleLeftOut = false.obs;
                              middleLeftIn = false.obs;
                              middleRightIn = false.obs;
                              middleRightOut = false.obs;
                              backLeftOut = false.obs;
                              backLeftIn = false.obs;
                            
                              backRightOut = false.obs;
                            });
                         
                          },
                          child: Container(
                            height: backRightIn.value ? 60 : 40,
                            width: backRightIn.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: backRightIn.value ? green : Colors.black,
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

                                         backRightOut = true.obs;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeftOut = false.obs;
                              frontRightOut = false.obs;
                              middleLeftOut = false.obs;
                              middleLeftIn = false.obs;
                              middleRightIn = false.obs;
                              middleRightOut = false.obs;
                              backLeftOut = false.obs;
                              backLeftIn = false.obs;
                              backRightIn = false.obs;
                             
                            });
                          
                          },
                          child: Container(
                            height: backRightOut.value ? 60 : 40,
                            width: backRightOut.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: backRightOut.value ? green : Colors.black,
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

                               frontLeftOut = true.obs;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              
                              frontLeftIn = false.obs;
                              frontRightIn = false.obs;
                              frontRightOut = false.obs;
                              middleLeftOut = false.obs;
                              middleLeftIn = false.obs;
                              middleRightIn = false.obs;
                              middleRightOut = false.obs;
                              backLeftOut = false.obs;
                              backLeftIn = false.obs;
                              backRightIn = false.obs;
                              backRightOut = false.obs;
                            });
                          },
                          child: Container(
                            height: frontLeftOut.value ? 60 : 40,
                            width: frontLeftOut.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: frontLeftOut.value ? green : Colors.black,
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

                               frontLeftIn = true.obs;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeftOut = false.obs;
                              
                              frontRightIn = false.obs;
                              frontRightOut = false.obs;
                              middleLeftOut = false.obs;
                              middleLeftIn = false.obs;
                              middleRightIn = false.obs;
                              middleRightOut = false.obs;
                              backLeftOut = false.obs;
                              backLeftIn = false.obs;
                              backRightIn = false.obs;
                              backRightOut = false.obs;
                            });
                          },
                          child: Container(
                            height: frontLeftIn.value ? 60 : 40,
                            width: frontLeftIn.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: frontLeftIn.value ? green : Colors.black,
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

                                frontRightIn = true.obs;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeftOut = false.obs;
                              frontLeftIn = false.obs;
                              
                              frontRightOut = false.obs;
                              middleLeftOut = false.obs;
                              middleLeftIn = false.obs;
                              middleRightIn = false.obs;
                              middleRightOut = false.obs;
                              backLeftOut = false.obs;
                              backLeftIn = false.obs;
                              backRightIn = false.obs;
                              backRightOut = false.obs;
                            });
                          },
                          child: Container(
                            height: frontRightIn.value ? 60 : 40,
                            width: frontRightIn.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: frontRightIn.value ? green : Colors.black,
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

                                 frontRightOut = true.obs;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeftOut = false.obs;
                              frontLeftIn = false.obs;
                              frontRightIn = false.obs;
                             
                              middleLeftOut = false.obs;
                              middleLeftIn = false.obs;
                              middleRightIn = false.obs;
                              middleRightOut = false.obs;
                              backLeftOut = false.obs;
                              backLeftIn = false.obs;
                              backRightIn = false.obs;
                              backRightOut = false.obs;
                            });
                          },
                          child: Container(
                            height: frontRightOut.value ? 60 : 40,
                            width: frontRightOut.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: frontRightOut.value ? green : Colors.black,
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

                                middleLeftOut = true.obs;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                               frontLeftOut = false.obs;
                              frontLeftIn = false.obs;
                              frontRightIn = false.obs;
                              frontRightOut = false.obs;
                           
                              middleLeftIn = false.obs;
                              middleRightIn = false.obs;
                              middleRightOut = false.obs;
                              backLeftOut = false.obs;
                              backLeftIn = false.obs;
                              backRightIn = false.obs;
                              backRightOut = false.obs;
                            });
                          },
                          child: Container(
                            height: middleLeftOut.value ? 60 : 40,
                            width: middleLeftOut.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: middleLeftOut.value ? green : Colors.black,
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

                                middleLeftIn = true.obs;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                                frontLeftOut = false.obs;
                              frontLeftIn = false.obs;
                              frontRightIn = false.obs;
                              frontRightOut = false.obs;
                              middleLeftOut = false.obs;

                              middleRightIn = false.obs;
                              middleRightOut = false.obs;
                              backLeftOut = false.obs;
                              backLeftIn = false.obs;
                              backRightIn = false.obs;
                              backRightOut = false.obs;
                            });
                          },
                          child: Container(
                            height: middleLeftIn.value ? 60 : 40,
                            width: middleLeftIn.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: middleLeftIn.value ? green : Colors.black,
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

                                middleRightIn = true.obs;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                                frontLeftOut = false.obs;
                              frontLeftIn = false.obs;
                              frontRightIn = false.obs;
                              frontRightOut = false.obs;
                              middleLeftOut = false.obs;
                              middleLeftIn = false.obs;

                              middleRightOut = false.obs;
                              backLeftOut = false.obs;
                              backLeftIn = false.obs;
                              backRightIn = false.obs;
                              backRightOut = false.obs;
                            });
                          },
                          child: Container(
                            height: middleRightIn.value ? 60 : 40,
                            width: middleRightIn.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: middleRightIn.value ? green : Colors.black,
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

                                middleRightOut = true.obs;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                             frontLeftOut = false.obs;
                              frontLeftIn = false.obs;
                              frontRightIn = false.obs;
                              frontRightOut = false.obs;
                              middleLeftOut = false.obs;
                              middleLeftIn = false.obs;
                              middleRightIn = false.obs;

                              backLeftOut = false.obs;
                              backLeftIn = false.obs;
                              backRightIn = false.obs;
                              backRightOut = false.obs;
                            });
                          },
                          child: Container(
                            height: middleRightOut.value ? 60 : 40,
                            width: middleRightOut.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: middleRightOut.value ? green : Colors.black,
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

                                backLeftOut = true.obs;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                              frontLeftOut = false.obs;
                              frontLeftIn = false.obs;
                              frontRightIn = false.obs;
                              frontRightOut = false.obs;
                              middleLeftOut = false.obs;
                              middleLeftIn = false.obs;
                              middleRightIn = false.obs;
                              middleRightOut = false.obs;

                              backLeftIn = false.obs;
                              backRightIn = false.obs;
                              backRightOut = false.obs;
                            });
                          },
                          child: Container(
                            height: backLeftOut.value ? 60 : 40,
                            width: backLeftOut.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: backLeftOut.value ? green : Colors.black,
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

                                backLeftIn = true.obs;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                          frontLeftOut = false.obs;
                              frontLeftIn = false.obs;
                              frontRightIn = false.obs;
                              frontRightOut = false.obs;
                              middleLeftOut = false.obs;
                              middleLeftIn = false.obs;
                              middleRightIn = false.obs;
                              middleRightOut = false.obs;
                              backLeftOut = false.obs;

                              backRightIn = false.obs;
                              backRightOut = false.obs;
                            });
                          },
                          child: Container(
                            height: backLeftIn.value ? 60 : 40,
                            width: backLeftIn.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: backLeftIn.value ? green : Colors.black,
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

                                backRightIn = true.obs;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                               frontLeftOut = false.obs;
                              frontLeftIn = false.obs;
                              frontRightIn = false.obs;
                              frontRightOut = false.obs;
                              middleLeftOut = false.obs;
                              middleLeftIn = false.obs;
                              middleRightIn = false.obs;
                              middleRightOut = false.obs;
                              backLeftOut = false.obs;
                              backLeftIn = false.obs;

                              backRightOut = false.obs;
                            });
                          },
                          child: Container(
                            height: backRightIn.value ? 60 : 40,
                            width: backRightIn.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: backRightIn.value ? green : Colors.black,
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

                                backRightOut = true.obs;

                                showBottomSheet(context);
                              } else {
                                Get.snackbar("No Tyre Found!", "");
                              }
                              print("selected model: " +
                                  selectedModel.toString());

                               frontLeftOut = false.obs;
                              frontLeftIn = false.obs;
                              frontRightIn = false.obs;
                              frontRightOut = false.obs;
                              middleLeftOut = false.obs;
                              middleLeftIn = false.obs;
                              middleRightIn = false.obs;
                              middleRightOut = false.obs;
                              backLeftOut = false.obs;
                              backLeftIn = false.obs;
                              backRightIn = false.obs;
                            });
                          },
                          child: Container(
                            height: backRightOut.value ? 60 : 40,
                            width: backRightOut.value ? 20 : 10,
                            decoration: BoxDecoration(
                                color: backRightOut.value ? green : Colors.black,
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
