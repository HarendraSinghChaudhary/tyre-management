// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:PrimeMetrics/controllers/tyre/tyre_controller.dart';
import 'package:PrimeMetrics/screens/fuel_master/fuel_master_widgets/searchable_dropdown.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/src/multipart_file.dart' as multiFile;
import '../../../../utils/colors.dart';
import '../../../../utils/screen_size.dart';
import '../../../fuel_master/fuel_master_widgets/shadow_textfield.dart';
import '../../tyre_home_screen.dart';

class DetailedInspectionScreen extends StatefulWidget {
 String tyre_id, tyre_serial_number, tread_depth, odometer;

 DetailedInspectionScreen({required this.tyre_id, required this.tyre_serial_number, required this.tread_depth, required this.odometer});

  @override
  _DetailedInspectionScreenState createState() =>
      _DetailedInspectionScreenState();
}

class _DetailedInspectionScreenState extends State<DetailedInspectionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController serialNumberController = TextEditingController();
  TextEditingController depthController = TextEditingController();
  TextEditingController pressureController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  var tyreImage;

  int value = 0;
  List list = ["No", "Yes"];
  bool isCheckboxSelected = false;
  Rx<XFile?>? file;

  int? id;
  String? defect_type;

  TyreController tyreController = Get.find();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
    serialNumberController.text = widget.tyre_serial_number;
    depthController.text = widget.tread_depth;

    tyreController.defectApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: primaryColors,
      body: 

      Obx((() =>


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
                    "Detailed Inspection",
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
                      enabled: false,
                      controller: serialNumberController,
                      hintText: "Tyre Serial Number",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      maxLine: 1,
                      keyboardType: TextInputType.number,
                      controller: depthController,
                      hintText: "Thread Depth",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      maxLine: 1,
                      keyboardType: TextInputType.number,
                      controller: pressureController,
                      hintText: "Tyre Pressure",
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Retread Needed?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 18,
                      ),
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
                            child: RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              activeColor: green,
                              value: index,
                              groupValue: value,
                              onChanged: (index) {
                                setState(
                                  () {
                                    value = int.parse(index.toString());
                                     print(value.toString());
                                  },

                                 
                                );
                              },
                              title: Text(list[index] ?? ""),
                            ),
                          ),
                        );
                      },
                      itemCount: list.length,
                    ),
                    SizedBox(
                      height: 10,
                    ),

                         SearchableDropdown(
                        withIcon: false,
                        enabled: true,
                        hintText: "Defect",
                        listItems: tyreController.defectList
                            .map((e) => "${e.defect_type}")
                            .toList(),
                        onChanged: (value) {
                          id = tyreController.defectList
                                  .firstWhere(
                                      (element) => value == element.defect_type)
                                  .id ??
                              0;

                          defect_type = tyreController.defectList
                              .firstWhere(
                                  (element) => value == element.defect_type)
                              .defect_type
                              .toString();

                          print("regNumber onChanged $id");
                          print("regNumber  $defect_type");
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
                    // SearchableDropdown(
                    //   enabled: true,
                    //   hintText: "Defect",
                    //   listItems:
                    //       ['Defect 1', 'Defect 2'].map((e) => "${e}").toList(),
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
                      controller: noteController,
                      hintText: "Notes",
                      maxLine: 8,
                    ),
                      SizedBox(
                      height: 20,
                    ),

                         InkWell(
                      onTap: () async{
                        file = (await ImagePicker().pickImage(
                            source: ImageSource.camera,
                            imageQuality: 50, // <- Reduce Image quality
                            maxHeight: 500, // <- reduce the image size
                            maxWidth: 500))
                            .obs;
                        setState(() {});

                        //var selectedFile = file?.value ?? XFile("");
                        String filename = file?.value?.path.split('/').last??"";

                        tyreImage =await multiFile.MultipartFile.fromFile(file?.value?.path??"", filename: filename);
                        // data.remove("image");
                        // data.putIfAbsent('image', () => tyreImage);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: file?.value==null ? ScreenSize.height * 0.065 : ScreenSize.height * 0.2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            file?.value==null
                                ? Image.asset(upload_photo)
                                : const Text(""),
                          ],
                        ),
                        decoration: BoxDecoration(
                            image:file!=null? DecorationImage(
                                fit: BoxFit.cover,
                                image:FileImage(File(file?.value?.path??""))):null,
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
                    SizedBox(
                      height: 5,
                    ),
                    file?.value==null ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Please upload a photo of tyre",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ) : Container(height: 0),
                   
                  
                    Container(
                      height: 100,
                      alignment: Alignment.center,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () async {



                          if (pressureController.text.isNotEmpty && 
                          noteController.text.isNotEmpty && 
                          defect_type.toString() != "" &&
                          depthController.text.toString() != "" && 
                          tyreImage != null
                          
                          ) {
            
                          showGeneralDialog(
                            context: context,
                            barrierColor: Colors.black.withOpacity(0.9),
                            // Background color
                            barrierDismissible: false,
                            transitionDuration: Duration(milliseconds: 400),
                            pageBuilder: (_, __, ___) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return Scaffold(
                                  backgroundColor:
                                      Colors.black.withOpacity(0.9),
                                  body: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      const Text(
                                        "Would you like to perform another inspection?",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 24,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: CheckboxListTile(
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          value: isCheckboxSelected,
                                          side: BorderSide(color: Colors.white),
                                          onChanged: (value) {
                                            setState(() {
                                              isCheckboxSelected =
                                                  value ?? false;
                                            });
                                          },
                                          // ignore: prefer_const_constructors
                                          title: Text(
                                            "Do not ask again",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      GestureDetector(
                                        onTap: () {

                                          tyreController.detailedInspectionApi(
                                            type: "details_inspection", 
                                            //  file: tyreImage, 
                                            tyre_id: widget.tyre_id, 
                                            tyre_serial_number: widget.tyre_serial_number, 
                                            tread_depth: depthController.text.toString(), 
                                            tyre_psi: pressureController.text.toString(), 
                                            tyre_defect: defect_type.toString(), 
                                            inspection_note: noteController.text.toString(), 
                                            is_retread: value.toString(), 
                                            defect_id: id.toString(),
                                            odometer: widget.odometer.toString()
                                          );
                                    
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: ScreenSize.width * 0.82,
                                          height: ScreenSize.height * 0.065,
                                          child: const Text(
                                            "Yes",
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white,
                                              fontSize: 18,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color: green,
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 3,
                                                    spreadRadius: 1.2,
                                                    offset: Offset(0, 3),
                                                    color: Colors.black
                                                        .withOpacity(0.3))
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ScreenSize.width * 0.1)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.offAll(TyreHomeScreen(),
                                              transition:
                                                  Transition.leftToRight);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: ScreenSize.width * 0.82,
                                          height: ScreenSize.height * 0.065,
                                          child: Text(
                                            "No",
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
                                                    color: Colors.black
                                                        .withOpacity(0.3))
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ScreenSize.width * 0.1)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                );
                              });
                            },
                          );
                        
                        
                          }

                          else {
                            Get.snackbar("Please fill all sections", "");
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
                              borderRadius: BorderRadius.circular(
                                  ScreenSize.width * 0.1)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
  
  
      
      )
       )
      
      
     
  
  
    );
  }
}
