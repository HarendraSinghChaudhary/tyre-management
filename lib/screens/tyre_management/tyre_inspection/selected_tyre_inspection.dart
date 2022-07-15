// ignore_for_file: prefer_const_constructors

import 'package:PrimeMetrics/screens/tyre_management/tyre_inspection/detailed_inspection/detailed_inspection_screen.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_inspection/pressure_check/pressure_check_home_screen.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';

class SelectedTyreInspection extends StatefulWidget {
 String? tyre_serial_number;
 String? tyre_id;
 String? thread_depth;
 String? recorded_psi;
 String? max_psi;
 String? recom_psi;
 String? odometer;
  SelectedTyreInspection ({required this.tyre_serial_number,
   required this.thread_depth,
   required this.recorded_psi,
   required this.max_psi,
   required this.tyre_id, 
   required this.recom_psi,
   required this.odometer,
   });

  @override
  _SelectedTyreInspectionState createState() => _SelectedTyreInspectionState();
}

class _SelectedTyreInspectionState extends State<SelectedTyreInspection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int value = 0;
  String? isSelect;
  List deployOn = ["Pressure Check", "Detailed Inspection"];
  List checkList = ["pressure_check", "details_inspection"];
  List images = [pressure_check, detailed_inspection];

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
                    "Select Inspection",
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
                        "Tyre Selected",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 18),
                      ),
                    ),
                    tyreDetailView(),
                    
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
                                          print(value);
                                          
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
            //Get.to(SelectedTyreInspection(), transition: Transition.rightToLeft);
            if(value==0){
              Get.to(PressureCheckHomeScreen(
                type: value.toString(),
                tyre_id: widget.tyre_id,
                odometer: widget.odometer,
              ), transition: Transition.rightToLeft);
            }else if(value==1){
              Get.to(DetailedInspectionScreen(
                tyre_id: widget.tyre_id.toString(),
                tyre_serial_number: widget.tyre_serial_number.toString(),
                tread_depth: widget.thread_depth.toString(),
                odometer:widget.odometer.toString()
              ), transition: Transition.rightToLeft);
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
  Widget tyreDetailView() {
    return Container(
      width: ScreenSize.width * 0.9,
      height: ScreenSize.height * 0.3,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              offset: const Offset(0, 3),
              color: Colors.black.withOpacity(0.3))
        ],
        color: green,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
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
                SizedBox(height: 5,),
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
                      widget.tyre_serial_number.toString(),
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
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                color: primaryColors,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
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
                          // "123",
                          widget.thread_depth.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
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
                          widget.recorded_psi.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
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
                          
                          widget.max_psi.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                           SizedBox(height: 10,),
                    Row(
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
                          
                          widget.recom_psi.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
