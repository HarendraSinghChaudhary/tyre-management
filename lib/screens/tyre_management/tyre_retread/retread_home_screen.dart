import 'dart:io';

import 'package:PrimeMetrics/controllers/tyre/tyre_controller.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_retread/post_retread_screen.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_retread/pre_retread_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';
import '../../fuel_master/fuel_master_widgets/searchable_dropdown.dart';

class RetreadScreen extends StatefulWidget {


  @override
  _RetreadScreenState createState() => _RetreadScreenState();
}

class _RetreadScreenState extends State<RetreadScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


     String? tyre_psi;
   String? tread_depth;
   String? regNumber;
   String? axle;
   String? positionaxle;
   String? totalUnit;
    int vehicleId = 0;
  String storeCodeSerialNumber = "";
  String recordedPsi = "";


   String? id;
   String? retreads_status;


  TyreController tyreController = Get.find();

  String? reason;

  @override
  void initState() {
    super.initState();

   tyreController.getRetreadTyreApi();
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: primaryColors,
      body:  Obx((() => 

           tyreController.isRetreadLoading.value
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
                    "Retread",
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
                                  hintText: "Select serial number",
                                  listItems: tyreController.retreaTyreSerialNumberList
                                      .map((e) => "${e.tyre_serial_number}")
                                      .toList(),
                                  onChanged: (value) {

                                    id = tyreController
                                            .retreaTyreSerialNumberList
                                            .firstWhere((element) =>
                                                value ==
                                                element.tyre_serial_number.toString()).id.toString();


                                    storeCodeSerialNumber = tyreController
                                            .retreaTyreSerialNumberList
                                            .firstWhere((element) =>
                                                value ==
                                                element.tyre_serial_number.toString()).tyre_serial_number.toString();

                                     tyre_psi =  tyreController
                                            .retreaTyreSerialNumberList
                                            .firstWhere((element) =>
                                                value ==
                                                element.tyre_serial_number).tyre_psi.toString();  


                                     tread_depth =  tyreController
                                            .retreaTyreSerialNumberList
                                            .firstWhere((element) =>
                                                value ==
                                                element.tyre_serial_number).tread_depth.toString();

                                     retreads_status =  tyreController
                                            .retreaTyreSerialNumberList
                                            .firstWhere((element) =>
                                                value ==
                                                element.tyre_serial_number).retreads_status.toString();                          


                                     print("tyrePsi: "+storeCodeSerialNumber.toString());  
                                     print("tread depth: "+tread_depth.toString());  
                                     print("tyre id: "+id.toString());
                                     print("retread status:___ "+ retreads_status.toString());                 
                                          
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
                                )
                 
                  ],
                ),
              ),
            )
          ],
        ),
      )
      
      
      
      
      )),
      
      
      
       
      
      
      
      
      bottomNavigationBar: Container(
        height: 100,
        alignment: Alignment.center,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () async {

            print("status: "+retreads_status.toString());
            print("id: "+id.toString());


            if (retreads_status.toString().trim() != "null") {

           

            if(retreads_status.toString().trim() == "1") {

               Get.to(PostRetreadScreen(tyre_id: id.toString()), transition: Transition.leftToRight);

            } else {

                Get.to(PreRetreadScreen(tyre_id: id.toString()), transition: Transition.leftToRight);

            }


            }else {
              Get.snackbar("Please select serial number", "");
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
}
