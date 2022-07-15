// ignore_for_file: prefer_const_constructors

import 'package:PrimeMetrics/controllers/tyre/tyre_controller.dart';
import 'package:PrimeMetrics/screens/fuel_master/fuel_master_widgets/shadow_textfield.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_inspection/inspection_select_tyre.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_inspection/selected_tyre_inspection.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';
import '../../fuel_master/fuel_master_widgets/searchable_dropdown.dart';

class RegistrationNumberByShop extends StatefulWidget {
  String id;
  String odometer;

  RegistrationNumberByShop ({required this.id, required this.odometer});

  @override
  _InspectionStoreCodeState createState() => _InspectionStoreCodeState();
}

class _InspectionStoreCodeState extends State<RegistrationNumberByShop> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController odometerController = TextEditingController();

  String? tyre_psi;
   String? tread_depth;
   String? regNumber;
   String? axle;
   String? positionaxle;
   String? totalUnit;
  int vehicleId = 0;
  String storeCodeSerialNumber = "";
  String recordedPsi = "";
  String? max_psi;
  String? recom_psi;


   int? id;


  TyreController tyreController = Get.find();

  String? reason;

  @override
  void initState() {
    super.initState();

   tyreController.getVehiclesbyShopApi(widget.id);
    
  }

 
  String _1LO = "1LO";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: primaryColors,
      body:  Obx((() => 

         
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
                     "Select Serial Number",
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
                                  listItems: tyreController.tyreSerialNumberList
                                      .map((e) => "${e.tyre_serial_number}")
                                      .toList(),
                                  onChanged: (value) {

                                    id = tyreController
                                            .tyreSerialNumberList
                                            .firstWhere((element) =>
                                                value ==
                                                element.tyre_serial_number.toString()).id;


                                    storeCodeSerialNumber = tyreController
                                            .tyreSerialNumberList
                                            .firstWhere((element) =>
                                                value ==
                                                element.tyre_serial_number.toString()).tyre_serial_number.toString();

                                     tyre_psi =  tyreController
                                            .tyreSerialNumberList
                                            .firstWhere((element) =>
                                                value ==
                                                element.tyre_serial_number).tyre_psi.toString();  


                                     tread_depth =  tyreController
                                            .tyreSerialNumberList
                                            .firstWhere((element) =>
                                                value ==
                                                element.tyre_serial_number).tread_depth.toString(); 

                                     max_psi =  tyreController
                                            .tyreSerialNumberList
                                            .firstWhere((element) =>
                                                value ==
                                                element.tyre_serial_number).max_psi.toString();
                                     recom_psi =  tyreController
                                            .tyreSerialNumberList
                                            .firstWhere((element) =>
                                                value ==
                                                element.tyre_serial_number).recom_psi.toString();                                    


                                     print("tyrePsi: "+tyre_psi.toString());  
                                     print("tread depth: "+tread_depth.toString());  
                                     print("tyre id: "+id.toString());                 
                                          
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
           Get.to(SelectedTyreInspection(
             tyre_serial_number: storeCodeSerialNumber, 
             thread_depth: tread_depth, 
             recorded_psi: tyre_psi,
             max_psi: max_psi.toString(), 
             tyre_id: id.toString(),
             recom_psi: recom_psi.toString(),
             odometer: widget.odometer,
             ));
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
