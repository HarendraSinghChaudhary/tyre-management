// ignore_for_file: prefer_const_constructors

import 'package:PrimeMetrics/controllers/tyre/tyre_controller.dart';
import 'package:PrimeMetrics/screens/fuel_master/fuel_master_widgets/searchable_dropdown.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_rotation/select_tyre_rotation_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';

class SelectTruckRegistrationScreen extends StatefulWidget {
  const SelectTruckRegistrationScreen({Key? key}) : super(key: key);

  @override
  _SelectTruckRegistrationScreenState createState() => _SelectTruckRegistrationScreenState();
}

class _SelectTruckRegistrationScreenState extends State<SelectTruckRegistrationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   int vehicleId = 0;
  String? tyre_psi;
  String? tread_depth;
  String regNumber = "";
  String? axle;
  String? positionaxle;
  String? totalUnit;

  TyreController tyreController = Get.find();

  String? reason;

  // @override
  // void initState() {
  //   // TODO: implement initState

  //   tyreController.
  //   super.initState();
  // }

  // ignore: prefer_final_fields
  String _1LO = "1LO";

  String? id;
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
                    "Select Truck Registration",
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
                      ),
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
          onTap: ()  {

            if (regNumber.toString() != "") {

               Get.to(SelectTyreRotationScreen(regNumber: regNumber.toString(), vehicle_id: vehicleId,), transition: Transition.rightToLeft);

            }else {

              Get.snackbar("Please select registration", "");

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
