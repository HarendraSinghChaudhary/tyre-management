// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks

import 'package:PrimeMetrics/controllers/tyre/tyre_controller.dart';
import 'package:PrimeMetrics/screens/fuel_master/fuel_master_widgets/searchable_dropdown.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_inspection/pressure_check/pressure_below_screen.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_inspection/pressure_check/pressure_verified.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/screen_size.dart';
import '../../../fuel_master/fuel_master_widgets/shadow_textfield.dart';

class PressureCheckHomeScreen extends StatefulWidget {
  String? tyre_id;
  String? type;
  String? odometer;
  PressureCheckHomeScreen({required this.tyre_id, required this.type, required this.odometer});

  @override
  _PressureCheckHomeScreenState createState() =>
      _PressureCheckHomeScreenState();
}

class _PressureCheckHomeScreenState extends State<PressureCheckHomeScreen> {
  bool agree = false;
  TyreController tyreController = Get.find();
  bool isPuncture = false;

  int? id;
  String? repair_option;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController pressureController = TextEditingController();

  TextEditingController newPressureController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tyreController.punctureRepairReasonApi();
  }

  @override
  Widget build(BuildContext context) {
    print("tyre id: "+widget.tyre_id.toString());
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: primaryColors,
      body: Obx((() => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      const Text(
                        "Pressure Check",
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
                        ShadowTextField(
                            maxLine: 1,
                            keyboardType: TextInputType.number,
                            controller: pressureController,
                            hintText: "Tyre Pressure"),
                      ],
                    ),
                  ),
                ),


                // Obx((() =>
                // tyreController.message.toString.toString() != "null"  ?


                // Text(
                  
                //   tyreController.message.toString()
                  
                  
                //   ) : Text("") )),

                

                

                  SizedBox(height: Get.height * 0.02,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: green,
                        fixedSize: Size(
                          ScreenSize.width * 0.40,
                          ScreenSize.height * 0.065,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        elevation: 5),
                    onPressed: () {
                      if (pressureController.text != "") {
                        tyreController.pressureCheckApi(
                            tyre_id: widget.tyre_id.toString(),
                            Pressure:
                                pressureController.text.toString().trim());
                      } else {
                        Get.snackbar("Please fill tyre pressure", "");
                      }
                     
                    },
                    child: const Text(
                      "Check Pressure",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontSize: 14),
                    )),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: ScreenSize.width * 0.85,
                  height: ScreenSize.height * 0.060,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 1.2,
                          offset: const Offset(0, 3),
                          color: Colors.black.withOpacity(0.3))
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Is tyre puncture?",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      Checkbox(
                          activeColor: Color(0xFFE9BC1D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5)),
                          ),
                          fillColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return green;
                            }
                            return green;
                          }),
                          value: isPuncture,
                          onChanged: (val) {
                            setState(() {
                              isPuncture = val!;
                            });

                            print(val);
                          }),
                    ],
                  ),
                ),
                Visibility(
                  visible: isPuncture == true ? true : false,
                  child: Container(
                    padding: EdgeInsets.all(30),
                    child: SearchableDropdown(
                      withIcon: false,
                      enabled: true,
                      hintText: "Select puncture reason",
                      listItems: tyreController.punctureRepairReasonList
                          .map((e) => "${e.repair_option}")
                          .toList(),
                      onChanged: (value) {
                        id = tyreController.punctureRepairReasonList
                                .firstWhere((element) => value == element.repair_option)
                                .id;

                        repair_option = tyreController.punctureRepairReasonList
                            .firstWhere(
                                (element) => value == element.repair_option)
                            .repair_option
                            .toString();

                        print("regNumber onChanged $id");
                        print("regNumber  $repair_option");
                      
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
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                        activeColor: Color(0xFFE9BC1D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5)),
                        ),
                        fillColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.selected)) {
                            return green;
                          }
                          return green;
                        }),
                        value: agree,
                        onChanged: (val) {
                          setState(() {
                            agree = val!;
                            print(agree);
                          });
                        }),
                    Text("i am agree to proceed with this check tyre pressure")
                  ],
                ),
              ],
            ),
          ))),
      bottomNavigationBar: Container(
        height: 100,
        alignment: Alignment.center,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () async {

            if(pressureController.text.isNotEmpty) {

              if (agree == true) {

              tyreController.tyreInspectionApi(
                tyre_id: widget.tyre_id.toString(),
                type: widget.type.toString() == "0" ? "pressure_check" : "details_inspection", 
                tyre_psi: pressureController.text.toString().trim(), 
                is_puncture: isPuncture == true ? "1" : "0", 
                tyre_puncture_repair_id: id.toString(),
                odometer: widget.odometer.toString()
                
                );

              } else {

                 Get.snackbar("Please check on agree checkbox", "");

              }

            }
            else {

              Get.snackbar("Please fill tyre pressure", "");

            }
         
          },
          child: Container(
            alignment: Alignment.center,
            width: ScreenSize.width * 0.82,
            height: ScreenSize.height * 0.065,
            child: Text(
              "Submit",
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
