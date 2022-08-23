// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:PrimeMetrics/controllers/tyre/tyre_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';
import '../../fuel_master/fuel_master_widgets/searchable_dropdown.dart';
import '../../fuel_master/fuel_master_widgets/shadow_textfield.dart';
import '../tyre_home_screen.dart';

class PostRetreadScreen extends StatefulWidget {
    String? tyre_id;

  PostRetreadScreen({required this.tyre_id});
  

  @override
  _PostRetreadScreenState createState() => _PostRetreadScreenState();
}

class _PostRetreadScreenState extends State<PostRetreadScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime date = DateTime.now();

  TextEditingController tyreWeightController = TextEditingController();
  TextEditingController tyreWidthController = TextEditingController();
  TextEditingController threadDepthController = TextEditingController();
  TextEditingController costRetreadController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController warrantyKilometerController = TextEditingController();

  TyreController tyreController = Get.find();

  String? warrantyDuration;
  String? menufactureId;
  String? rubberId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tyreController.menufactureApi();

    tyreController.rubberTyreApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: primaryColors,
      body: Obx((() => 

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
                    "Post-Retread Details",
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
                    Text(
                      "Please fill in the post-retread details",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      hintText: "Weight (Kgs)",
                      maxLine: 1,
                      keyboardType: TextInputType.number,
                      controller: tyreWeightController,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      hintText: "Width (mms)",
                      maxLine: 1,
                      keyboardType: TextInputType.number,
                      controller: tyreWidthController,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      hintText: "Thread Depth (mm)",
                      maxLine: 1,
                      keyboardType: TextInputType.number,
                      controller: threadDepthController,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      hintText: "Cost of Retread",
                      maxLine: 1,
                      keyboardType: TextInputType.number,
                      controller: costRetreadController,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Retread Completion Date",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (ctx) {
                              return CalendarDatePicker(
                                  onDateChanged: (value) {
                                    //date(value);
                                    print(
                                        "date.millisecondsSinceEpoch --- ${date.millisecondsSinceEpoch}");
                                    print("date --- ${date}");
                                    date = value;
                                    dayController.text = date.day.toString();
                                    monthController.text =
                                        date.month.toString();
                                    yearController.text = date.year.toString();

                             

                                    Get.back();
                                  },
                                  initialDate: date,
                                  firstDate:  DateTime.now().subtract(const Duration(days: 5000)),
                                  lastDate:
                                      DateTime.now());
                            });
                      },
                      child: Row(
                        children: [
                          ShadowTextField(
                            width: ScreenSize.width * 0.2,
                            hintText: "Day",
                            controller: dayController,
                            onChanged: (value) {},
                            enabled: false,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ShadowTextField(
                              hintText: "Month",
                              controller: monthController,
                              onChanged: (value) {},
                              enabled: false,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ShadowTextField(
                            width: ScreenSize.width * 0.2,
                            hintText: "Year",
                            controller: yearController,
                            onChanged: (value) {},
                            enabled: false,
                          ),
                        ],
                      ),
                    ),
                   
                   
                    SizedBox(
                      height: 30,
                    ),


                      SearchableDropdown(
                                  withIcon: false,
                                  enabled: true,
                                  hintText: "Select Manufacturer",
                                  listItems: tyreController.menufactureList
                                      .map((e) => "${e.name}")
                                      .toList(),
                                  onChanged: (value) {

                                    menufactureId = tyreController
                                            .menufactureList
                                            .firstWhere((element) =>
                                                value ==
                                                element.name.toString()).id.toString();


                                                            


                                    
                                     print("menu id: "+menufactureId.toString());
                                                    
                                          
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



                                SizedBox(height: 10,),



                                         SearchableDropdown(
                                  withIcon: false,
                                  enabled: true,
                                  hintText: "Select Retread Rubber Tyre",
                                  listItems: tyreController.rubberTyreList
                                      .map((e) => "${e.name}")
                                      .toList(),
                                  onChanged: (value) {

                                    rubberId = tyreController
                                            .rubberTyreList
                                            .firstWhere((element) =>
                                                value ==
                                                element.name.toString()).id.toString();


                                                            


                                    
                                     print("rubber id: "+rubberId.toString());
                                                    
                                          
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
                    //   enabled: true,
                    //   hintText: "Select Manufacturer",
                    //   listItems: ['Manufacturer 1', 'Manufacturer 2']
                    //       .map((e) => "${e}")
                    //       .toList(),
                    //   onChanged: (value) {},
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
                    //   withIcon: false,
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // SearchableDropdown(
                    //   enabled: true,
                    //   hintText: "Select Retread Rubber Tyre",
                    //   listItems: ['Rubber Tyre 1', 'Rubber Tyre 2']
                    //       .map((e) => "${e}")
                    //       .toList(),
                    //   onChanged: (value) {},
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
                    //   withIcon: false,
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      hintText: "Retread Warranty Kilometers",
                         maxLine: 1,
                      keyboardType: TextInputType.number,
                 
                      controller: warrantyKilometerController,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Retread Warranty Duration",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SearchableDropdown(
                      enabled: true,
                      hintText: "Select warranty duration",
                      listItems:
                          ['5 Years', '4 Years', '3 Years', '2 Years', '1 Years'].map((e) => "${e}").toList(),
                      onChanged: (value) {
                        warrantyDuration = value;
                        print(warrantyDuration);

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
                      withIcon: false,
                    ),
                    SizedBox(
                      height: 200,
                    ),
                    InkWell(
                      onTap: () {

                        if (
                          tyreWeightController.text.isNotEmpty && threadDepthController.text.isNotEmpty &&
                          tyreWidthController.text.isNotEmpty && warrantyKilometerController.text.isNotEmpty &&
                          costRetreadController.text.isNotEmpty && warrantyDuration.toString() != ""
                          && dayController.text.isNotEmpty && monthController.text.isNotEmpty && 
                          yearController.text.isNotEmpty && menufactureId.toString() != ""
                          && rubberId.toString() != "" && widget.tyre_id.toString() != ""
                        ) {

                        tyreController.postRetreadApi(
                          tyre_id: widget.tyre_id.toString(), 
                          tyre_weight: tyreWeightController.text.trim(), 
                          tread_depth: threadDepthController.text.trim(), 
                          tyre_width: tyreWidthController.text.trim(), 
                          tyre_warranty_kms: warrantyKilometerController.text.trim(), 
                          cost_of_retread: costRetreadController.text.trim(), 
                          retread_warranty_duration: warrantyDuration.toString(), 
                          completion_date: dayController.text.trim(), 
                          completion_month: monthController.text.trim(), 
                          completion_year: yearController.text.trim(), 
                          manufacturer: menufactureId.toString(), 
                          retread_rubber_tyre: rubberId.toString()
                          );
                        } else 
                        {
                          Get.snackbar("Please fill all fields", "");
                        }

                        
                     
                      },
                      child: Container(
                        alignment: Alignment.center,
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
                          "Done",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 18,
                            decoration: TextDecoration.none,
                          ),
                        ))),
                        decoration: BoxDecoration(
                            color: green,
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
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    
    
    
      
      
      
      ))
      
      
      
      
    
    
    
    
    );
  }
}
