// ignore_for_file: prefer_const_constructors

import 'package:PrimeMetrics/controllers/tyre/tyre_controller.dart';
import 'package:PrimeMetrics/models/tyre_module/vehicle_structure.dart';
import 'package:PrimeMetrics/screens/fuel_master/fuel_master_widgets/shadow_textfield.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_home_screen.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_onboarding/onboarding_home_screen.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:PrimeMetrics/utils/toast.dart';
import 'package:animations/animations.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController pressureController = TextEditingController();
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController odometerController = TextEditingController();
  int value = 0;
  List deployOn = ["Truck", "Trailer"];
  List images = [truck, trailer];

  final SharedAxisTransitionType _transitionType =
      SharedAxisTransitionType.horizontal;

  late bool _isFirstCompleted;
  late bool _isSecondCompleted;
  late bool _isThirdCompleted;
  late bool _isFourthCompleted;

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
  int storeCodeSerialNumber = 0;

  //FuelController fuelController=Get.find();
  TyreController tyreController = Get.find();

  List<MountedTyre> mountedTyre = [];

  @override
  void initState() {
    tyreController.getTyreSerialNumberApi();
    tyreController.tyreSerialNumberList;
    // TODO: implement initState
    super.initState();
    // TODO: implement initState

    serialNumberController.text =
        widget.serialNumber.toString();

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
    print("list length:" +tyreController.tyreSerialNumberList.length.toString());
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
                      //      ObxValue((RxList list) {
                      //   return SearchableDropdown(
                      //     withIcon: false,
                      //     enabled: true,
                      //     hintText: "Select Size",
                      //     listItems: tyreController.tyreSizeList
                      //         .map((e) => "${e.sizeName}")
                      //         .toList(),
                      //     onChanged: (value) {
                      //       tyreSize = tyreController.tyreSizeList.firstWhere((element) => value == element.sizeName).id??0;
                      //       print("tyreSize onChanged $tyreSize");
                      //       data.remove("size");
                      //       data.putIfAbsent('size', () => tyreSize);
                      //     },
                      //     searchFieldProps: TextFieldProps(
                      //       decoration: InputDecoration(
                      //         suffixIcon: Icon(
                      //           Icons.keyboard_arrow_down,
                      //           color: Colors.black,
                      //         ),
                      //         hintText: "Search",
                      //         border: InputBorder.none,
                      //       ),
                      //     ),
                      //   );
                      // }, tyreController.tyreSizeList),
                      // SizedBox(
                      //   height: 10,
                      // ),

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
                        hintText: "Pressure of inflation (PSI)",
                        onChanged: (value) {
                          data.remove('tyre_psi');
                          data.putIfAbsent(
                              'tyre_psi', () => pressureController.text);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),

                       tyreController.tyreSerialNumberList.length > 0 ? 
                      Container(
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
                                  listItems: tyreController.tyreSerialNumberList
                                      .map((e) => "${e.tyre_serial_number}")
                                      .toList(),
                                  onChanged: (value) {
                                    storeCodeSerialNumber = tyreController
                                            .tyreSerialNumberList
                                            .firstWhere((element) =>
                                                value ==
                                                element.tyre_serial_number)
                                            .id ??
                                        0;
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
                      ): Container() ,

                      // ignore: unrelated_type_equality_checks
                      widget.serialNumber.toString != "null" || widget.serialNumber.toString != ""?

                      ShadowTextField(
                        enabled: false,
                        controller: serialNumberController,
                        hintText: "Tyre Serial Number",
                        onChanged: (value) {
                          // data.remove('tyre_psi');
                          // data.putIfAbsent('tyre_psi', () => pressureController.text);
                        },
                      ): Container(),
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
                            print("regNumber onChanged $vehicleId");
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
                        controller: odometerController,
                        hintText: "Odometer Reading",
                        onChanged: (value) {
                          data.remove('odometer');
                          data.putIfAbsent(
                              'odometer', () => odometerController.text);
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
      ),
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
                  .getVehicleStructure(vehicleId: vehicleId)
                  .then((value) {
                print("press here2");
                if (value) {
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

  thirdStep() {
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
                      getTyreViews(),
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
      ),
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
                      Text(
                        "you want to deploy Tyre # 1234567 to Vehicle ABC DE 1234",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        textAlign: TextAlign.center,
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
            Container(
              alignment: Alignment.center,
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () async {
                  // _toggleFourth();
                  if (_isFirstCompleted &&
                      _isSecondCompleted &&
                      _isThirdCompleted) {
                    Get.offAll(TyreHomeScreen(),
                        transition: Transition.leftToRight);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: ScreenSize.width * 0.82,
                  height: ScreenSize.height * 0.065,
                  child: Text(
                    "Yes",
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
                  Text(
                    "Tyre # 1234567",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 18),
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
                              "123",
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
                              "123",
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
                              "123",
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
                              frontLeft = true;

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
                            showBottomSheet(context);
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
                              frontLeft = false;
                              frontRight = true;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;
                            });

                            showBottomSheet(context);
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
                              frontLeft = false;
                              frontRight = false;
                              middleLeftOut = true;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;
                            });
                            showBottomSheet(context);
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
                              frontLeft = false;
                              frontRight = false;
                              middleLeftOut = false;
                              middleLeftIn = true;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;
                            });
                            showBottomSheet(context);
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
                              frontLeft = false;
                              frontRight = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = true;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;
                            });
                            showBottomSheet(context);
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
                              frontLeft = false;
                              frontRight = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = true;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;
                            });
                            showBottomSheet(context);
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
                              frontLeft = false;
                              frontRight = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = true;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = false;
                            });
                            showBottomSheet(context);
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
                              frontLeft = false;
                              frontRight = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = true;
                              backRightIn = false;
                              backRightOut = false;
                            });
                            showBottomSheet(context);
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
                              frontLeft = false;
                              frontRight = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = true;
                              backRightOut = false;
                            });
                            showBottomSheet(context);
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
                              frontLeft = false;
                              frontRight = false;
                              middleLeftOut = false;
                              middleLeftIn = false;
                              middleRightIn = false;
                              middleRightOut = false;
                              backLeftOut = false;
                              backLeftIn = false;
                              backRightIn = false;
                              backRightOut = true;
                            });
                            showBottomSheet(context);
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
}
