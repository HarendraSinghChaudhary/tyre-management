// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:PrimeMetrics/controllers/tyre/tyre_controller.dart';
import 'package:PrimeMetrics/models/tyre_module/vehicle_structure.dart';
import 'package:PrimeMetrics/screens/fuel_master/fuel_master_widgets/shadow_textfield.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_home_screen.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_onboarding/onboarding_home_screen.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:PrimeMetrics/utils/toast.dart';
import 'package:animations/animations.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../controllers/fuel/fuel_controller.dart';
import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';
import '../../fuel_master/fuel_master_widgets/searchable_dropdown.dart';

class MountHomeScreen extends StatefulWidget {
  final int? tyreId;
  final String? serialNumber;

  const MountHomeScreen({Key? key, this.tyreId, this.serialNumber})
      : super(key: key);

  @override
  _MountHomeScreenState createState() => _MountHomeScreenState();
}

class _MountHomeScreenState extends State<MountHomeScreen> {
  VehecleStructure selectedModel = VehecleStructure();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController pressureController = TextEditingController();
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController odometerController = TextEditingController();
  TextEditingController odometer = TextEditingController();
  int value = 0;
  List deployOn = ["Truck", "Trailer"];
  List images = [truck, trailer];

  final SharedAxisTransitionType _transitionType =
      SharedAxisTransitionType.horizontal;
  String? tyre_psi;
  String? tread_depth;
  String? regNumber;
  String? axle;
  String? positionaxle;
  String? totalUnit;
  String? max_psi;
  String? recom_psi;

  String? id;

  late bool _isFirstCompleted;
  late bool _isSecondCompleted;
  late bool _isThirdCompleted;
  late bool _isFourthCompleted;

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

  void _toggleFirst() {
    setState(() {
      _isFirstCompleted = !_isFirstCompleted;
    });

    print("press here step 1" + _isFirstCompleted.toString());
  }

  void _toggleSecond() {
    setState(() {
      _isSecondCompleted = !_isSecondCompleted;
    });
    print("press here step 2" + _isSecondCompleted.toString());
  }

  void _toggleThird() {
    setState(() {
      _isThirdCompleted = !_isThirdCompleted;
    });
    print("press here step 3" + _isThirdCompleted.toString());
  }

  void _toggleFourth() {
    setState(() {
      _isFourthCompleted = !_isFourthCompleted;
    });

    print("press here step 4" + _isFourthCompleted.toString());
  }

  int selectedCard = 0;

  late Map<String, dynamic> data;
  int vehicleId = 0;
  String storeCodeSerialNumber = "";
  String recordedPsi = "";
 

  //FuelController fuelController=Get.find();
  TyreController tyreController = Get.put(TyreController(), permanent: false);

  List<MountedTyre> mountedTyre = [];

  @override
  void initState() {
    tyreController.getNewUnmountTyreApi();
    tyreController.newUnmountTyreList;

    // TODO: implement initState
    super.initState();
    // TODO: implement initState

    serialNumberController.text = widget.serialNumber.toString();

    super.initState();
    _isFirstCompleted = false;
    _isSecondCompleted = false;
    _isThirdCompleted = false;
    _isFourthCompleted = false;
    data = {};
    data.remove('tyre_id');
    data.putIfAbsent('tyre_id', () => widget.tyreId);

      

  }

  @override
  Widget build(BuildContext context) {
    print("serial numner mount:" + widget.serialNumber.toString());
    print("tyre id:" + tyreController.tyreId.toString());
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
    print("serial number mount:" + widget.serialNumber.toString());
    return Scaffold(
      backgroundColor: primaryColors,
      key: _scaffoldKey,
      body: 
      






        
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
                        Get.offAll(const TyreHomeScreen());
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
                      "Select Rim",
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
                    )
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
                        enabled: true,
                        hintText: "Select Rim (Optional)",
                        listItems:
                            ['Rim 1', 'Rim 2'].map((e) => "${e}").toList(),
                        onChanged: (value) {},
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
                        withIcon: false,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ShadowTextField(
                        controller: pressureController,
                        maxLine: 1,
                        keyboardType: TextInputType.number,
                        hintText: "Pressure of inflation (PSI)",
                        onChanged: (value) {
                          // data.remove('tyre_psi');
                          // data.putIfAbsent(
                          //     'tyre_psi', () => pressureController.text);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      widget.serialNumber.toString().trim() == "null"
                          ? Container(
                              padding: EdgeInsets.all(0),
                              child: SingleChildScrollView(
                                physics: NeverScrollableScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ObxValue((RxList list) {
                                      return SearchableDropdown(
                                        withIcon: false,
                                        enabled: true,
                                        hintText: "Select serial number",
                                        listItems: tyreController
                                            .newUnmountTyreList
                                            .map((e) =>
                                                "${e.tyre_serial_number}")
                                            .toList(),
                                        onChanged: (value) {
                                          id = tyreController
                                              .newUnmountTyreList
                                              .firstWhere((element) =>
                                                  value ==
                                                  element.tyre_serial_number
                                                      .toString())
                                              .id
                                              .toString();

                                          storeCodeSerialNumber = tyreController
                                              .newUnmountTyreList
                                              .firstWhere((element) =>
                                                  value ==
                                                  element.tyre_serial_number
                                                      .toString())
                                              .tyre_serial_number
                                              .toString();

                                          tyre_psi = tyreController
                                              .newUnmountTyreList
                                              .firstWhere((element) =>
                                                  value ==
                                                  element.tyre_serial_number)
                                              .tyre_psi
                                              .toString();

                                          tread_depth = tyreController
                                              .newUnmountTyreList
                                              .firstWhere((element) =>
                                                  value ==
                                                  element.tyre_serial_number)
                                              .tread_depth
                                              .toString();

                                          max_psi = tyreController
                                              .newUnmountTyreList
                                              .firstWhere((element) =>
                                                  value ==
                                                  element.tyre_serial_number)
                                              .max_psi
                                              .toString();

                                          recom_psi = tyreController
                                              .newUnmountTyreList
                                              .firstWhere((element) =>
                                                  value ==
                                                  element.tyre_serial_number)
                                              .recom_psi
                                              .toString();

                                          print("tyrePsi: " +
                                              tyre_psi.toString());
                                          print("tread depth: " +
                                              tread_depth.toString());
                                          print("tyre id: " + id.toString());

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
                                      );
                                    }, tyreController.tyreSerialNumberList),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      // : Container() ,

                      // ignore: unrelated_type_equality_checks
                      widget.serialNumber.toString().trim() != "null"
                          ? ShadowTextField(
                              enabled: false,
                              maxLine: 1,
                              keyboardType: TextInputType.number,
                              controller: serialNumberController,
                              hintText: "Tyre Serial Number",
                              onChanged: (value) {
                                // data.remove('tyre_psi');
                                // data.putIfAbsent('tyre_psi', () => pressureController.text);
                              },
                            )
                          : Container(),
                      // : Container(),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Deploy On",
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
                                            print("value: " + value.toString());
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
                        height: 20,
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
        height: 100,
        alignment: Alignment.center,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () async {
            tyreController.getVehicles(value.toString());

            recordedPsi = pressureController.text.toString();
            data.remove('deploy_on');
            data.putIfAbsent('deploy_on', () => deployOn[value]);
            if (pressureController.text.isNotEmpty &&
                serialNumberController.text.isNotEmpty) {
              _toggleFirst();
            } else {
              show("Error", "All Fields are required");
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
                        //Get.back();
                        _toggleFirst();
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
                    )
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
                      ObxValue((RxList list) {
                        return SearchableDropdown(
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
                            data.remove('vehicle_id');
                            data.putIfAbsent('vehicle_id', () => vehicleId);
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
                        );
                      }, tyreController.companyVehicles),
                      SizedBox(
                        height: 10,
                      ),
                      ShadowTextField(
                        maxLine: 1,
                        keyboardType: TextInputType.number,
                        controller: odometerController,
                        hintText: "Odometer Reading",
                        onChanged: (value) {
                          // data.remove('odometer');
                          // data.putIfAbsent(
                          //     'odometer', () => odometerController.text);
                        },
                      ),
                      SizedBox(
                        height: 10,
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



      bottomNavigationBar: 


  

         Container(
        height: 100,
        alignment: Alignment.center,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () async {
            print("press here!" + odometerController.text.toString());
            print("!" + vehicleId.toString());
            //  _toggleSecond();

            if (odometerController.text.isNotEmpty && vehicleId != 0) {
              print("press here1!");
              await tyreController
                  .getVehicleStructure(vehicleId: vehicleId, tyre_vehicle_id : regNumber.toString())
                  .then((value) {
                    print("value1: "+ value.toString());
                print("press here2");
                if (value) {
                  print("value: "+ value.toString());
                  _toggleSecond();
                }
              });
            } else {
              show("Error", "All Fields are required");
            }
          },
          child: Container(
            alignment: Alignment.center,
            width: ScreenSize.width * 0.82,
            height: ScreenSize.height * 0.065,
            child: 

            Obx((() => 

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
      )
      
      
      
      
     
     
      
      

      
      
      
      
      
   
   
    );
  }

  thirdStep() {
    return Scaffold(
      backgroundColor: primaryColors,
      key: _scaffoldKey,
      body: 
      
      Obx((() => 

        tyreController.isVehicleStructureLoading.value
                        ? Align(
                            alignment: Alignment.center,
                            child: Platform.isAndroid
                                ? CircularProgressIndicator(color: Colors.white, strokeWidth: 1,)
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


                Obx((() =>

                    tyreController.isVehicleStructureLoading.value
                        ? Align(
                            alignment: Alignment.center,
                            child: Platform.isAndroid
                                ? CircularProgressIndicator(color: Colors.white, strokeWidth: 1,)
                                : CupertinoActivityIndicator())
                        :

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
                        
                         _toggleSecond();
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
                    )
                   
                   
                
                 )),
                   
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      "Tyre Position",
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
                    )
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
                middleLeftIn .value||
                middleRightIn.value ||
                middleRightOut.value ||
                backLeftOut.value ||
                backLeftIn.value ||
                backRightIn.value ||
                backRightOut.value) {
              _toggleThird();
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
              color: (frontLeftOut.value ||
                      frontLeftIn.value ||
                      frontRightIn.value ||
                      frontRightOut.value ||
                      middleLeftOut.value ||
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
                              text: "you want to deploy Tyre #",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: widget.serialNumber.toString().trim() ==
                                      "null"
                                  ? storeCodeSerialNumber.toString()
                                  : widget.serialNumber.toString(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            TextSpan(
                              text: " to Vehicle " +
                                  regNumber.toString() +
                                  " to postion ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                            TextSpan(
                              text: totalUnit.toString() == "1LO"
                                  ? "1 Left Outer"
                                  : totalUnit.toString() == "1LI"
                                      ? "1 Left Inner"
                                      : totalUnit.toString() == "1RI"
                                          ? "1 Right Inner"
                                          : totalUnit.toString() == "1RO"
                                              ? "1 Right Outer"
                                              : totalUnit.toString() == "2LO"
                                                  ? "2 Left Outer"
                                                  : totalUnit.toString() ==
                                                          "2LI"
                                                      ? "2 Left Inner"
                                                      : totalUnit.toString() ==
                                                              "2RO"
                                                          ? "2 Right Outer"
                                                          : totalUnit.toString() ==
                                                                  "2RI"
                                                              ? "2 Right Inner"
                                                              : totalUnit.toString() ==
                                                                      "3LO"
                                                                  ? "3 Left Outer"
                                                                  : totalUnit.toString() ==
                                                                          "3LI"
                                                                      ? "3 Left Inner"
                                                                      : totalUnit.toString() ==
                                                                              "3RO"
                                                                          ? "3 Right Outer"
                                                                          : totalUnit.toString() == "3RI"
                                                                              ? "3 Right Inner"
                                                                              : "",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            )
                          ]),
                        ),
                      ),
                      // Container(
                      //   width: ScreenSize.width * 1,
                      //   child: Column(
                      //     children: [
                      //       Container(

                      //         child: Row(
                      //           children: [
                      //             Text(
                      //               "you want to deploy Tyre #"
                      //               ,
                      //               style: TextStyle(color: Colors.black, fontSize: 18),
                      //               textAlign: TextAlign.center,
                      //             ),

                      //               Text(

                      //               widget.serialNumber.toString().trim() == "null" ?  storeCodeSerialNumber.toString() : widget.serialNumber.toString() +" to Vehicle "+
                      //                regNumber.toString() + " to postion "

                      //               ,
                      //               style: TextStyle(color: Colors.black, fontSize: 18),
                      //               textAlign: TextAlign.center,
                      //             ),
                      //           ],
                      //         ),
                      //       ),

                      //               Text(

                      //         totalUnit.toString() == "1LO" ? "1 Left Outer" :
                      //         totalUnit.toString() == "1RO" ? "1 Right Outer" :
                      //         totalUnit.toString() == "2LO" ? "2 Left Outer" :
                      //         totalUnit.toString() == "2LI" ? "2 Left Inner" :
                      //         totalUnit.toString() == "2RO" ? "2 Right Outer" :
                      //         totalUnit.toString() == "2RI" ? "2 Right Inner" :
                      //         totalUnit.toString() == "3LO" ? "3 Left Outer" :
                      //         totalUnit.toString() == "3LI" ? "3 Left Inner" :
                      //         totalUnit.toString() == "3RO" ? "3 Right Outer" :
                      //         totalUnit.toString() == "3RI" ? "3 Right Inner" : ""

                      //         ,
                      //         style: TextStyle(color: Colors.black, fontSize: 18),
                      //         textAlign: TextAlign.center,
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
                        // _toggleFourth();
                        tyreController.tyreMount(
                            id: widget.serialNumber.toString().trim() == "null"
                                ? id.toString()
                                : tyreController.tyreId.toString(),
                                tyre_psi: pressureController.text.toString(),
                            deploy_on: value.toString(),
                            vehicle_id: regNumber.toString(),
                            odometer: odometerController.text.toString().trim(),
                            vehicle_axcel: axle.toString(),
                            tyre_position: positionaxle.toString(),
                            tyre_status: "2");

                        // if (_isFirstCompleted &&
                        //     _isSecondCompleted &&
                        //     _isThirdCompleted) {
                        //   Get.offAll(TyreHomeScreen(),
                        //       transition: Transition.leftToRight);
                        // }
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




                          "Yes",
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
                        widget.serialNumber.toString().trim() == "null"
                            ? storeCodeSerialNumber.toString()
                            : widget.serialNumber.toString(),
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
                              widget.serialNumber.toString().trim() == "null"
                                  ? tread_depth.toString()
                                  : tyreController.thread_depth.toString(),
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
                                "Recorded PSI",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              // "123",
                              recordedPsi.toString(),
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
                              // tyre_psi.toString(),
                              widget.serialNumber.toString().trim() == "null"
                                  ? max_psi.toString()
                                  : tyreController.maximum_psi.toString(),
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

                                widget.serialNumber.toString().trim() == "null"
                                  ? recom_psi.toString()
                                  : tyreController.recomPsi.toString(),
                              
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

  Widget getTrailerTyreViews() {
    return 


    Obx((() =>

       
    Stack(
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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                             
                             
                             

                               
                              } else {
                                frontLeftOut = true.obs;

                                axle = "1";

                                positionaxle = "LO";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
                              }
                           

                            
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
                            // showBottomSheet(context);
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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                             
                             
                             

                               
                              } else {
                                frontLeftIn = true.obs;

                                axle = "1";

                                positionaxle = "LI";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
                              }




















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
                                color: frontLeftIn .value? green : Colors.black,
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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                             
                             
                             

                               
                              } else {
                               frontRightIn = true.obs;

                                axle = "1";

                                positionaxle = "RI";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
                              }


















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
                            height: frontRightIn.value? 60 : 40,
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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                             
                             
                             

                               
                              } else {
                                 frontRightOut = true.obs;

                                axle = "1";

                                positionaxle = "RO";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
                              }














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
                            width: frontRightOut.value  ? 20 : 10,
                            decoration: BoxDecoration(
                                color: frontRightOut.value  ? green : Colors.black,
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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                             
                             
                             

                               
                              } else {
                                middleLeftOut = true.obs;

                                axle = "2";

                                positionaxle = "LO";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
                              }







                            setState(() {
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
                            height: middleLeftOut.value? 60 : 40,
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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                             
                             
                             

                               
                              } else {
                                middleLeftIn = true.obs;

                                axle = "2";

                                positionaxle = "LI";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
                              }







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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                             
                             
                             

                               
                              } else {
                                 middleRightIn = true.obs;

                                axle = "2";

                                positionaxle = "RI";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
                              }









                            setState(() {
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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                             
                             
                             

                               
                              } else {
                                 middleRightOut = true.obs;

                                axle = "2";

                                positionaxle = "RO";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
                              }






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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                             
                             
                             

                               
                              } else {
                                backLeftOut = true.obs;

                                axle = "3";

                                positionaxle = "LO";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
                              }





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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                             
                             
                             

                               
                              } else {
                                 backLeftIn = true.obs;

                                axle = "3";

                                positionaxle = "LI";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
                              }











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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                             
                             
                             

                               
                              } else {
                                 backRightIn = true.obs;

                                axle = "3";

                                positionaxle = "RI";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
                              }







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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                             
                             
                             

                               
                              } else {
                                backRightOut = true.obs;

                                axle = "3";

                                positionaxle = "RO";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
                              }








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
    )


    
     ));
    
    
 

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

                                // Get.snackbar("Tyre already exist!", "");

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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                             
                             
                             
                             
                              } else {
                                frontLeftOut = true.obs;

                                axle = "1";

                                positionaxle = "LO";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
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

                                // Get.snackbar("Tyre already exist!", "");

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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                              } else {
                                frontRightOut = true.obs;

                                axle = "1";

                                positionaxle = "RO";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
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

                                // Get.snackbar("Tyre already exist!", "");

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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                              } else {
                                middleLeftOut = true.obs;

                                axle = "2";

                                positionaxle = "LO";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
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

                                // Get.snackbar("Tyre already exist!", "");

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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                              } else {
                                 middleLeftIn = true.obs;

                                axle = "2";

                                positionaxle = "LI";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
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

                                // Get.snackbar("Tyre already exist!", "");

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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                              } else {
                                middleRightIn = true.obs;

                                axle = "2";

                                positionaxle = "RI";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
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

                                // Get.snackbar("Tyre already exist!", "");

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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                              } else {
                                middleRightOut = true.obs;

                                axle = "2";

                                positionaxle = "RO";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
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

                                

                                Get.defaultDialog(
                                    contentPadding: EdgeInsets.all(10),
                                    title: "",


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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                              } else {
                                 backLeftOut = true.obs;

                                axle = "3";

                                positionaxle = "LO";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                              } else {
                                backLeftIn = true.obs;

                                axle = "3";

                                positionaxle = "LI";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
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

                                Get.defaultDialog(
                                    contentPadding: EdgeInsets.all(10),
                                    title: "",
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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                              } else {
                               backRightIn = true.obs;

                                axle = "3";

                                positionaxle = "RI";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
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

                              

                                Get.defaultDialog(
                                    contentPadding: EdgeInsets.all(10),
                                    title: "",

                               

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
                                            "Tyre already exist on this position!",
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
                                          child: FlatButton(
                                            color: Colors.amber,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
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
                              } else {
                                backRightOut = true.obs;

                                axle = "3";

                                positionaxle = "RO";

                                totalUnit =
                                    axle.toString() + positionaxle.toString();

                                showBottomSheet(context);
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
}
