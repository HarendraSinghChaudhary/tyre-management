// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:PrimeMetrics/controllers/tyre/tyre_controller.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_onboarding/select_store_code_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/src/multipart_file.dart' as multiFile;
import '../../../utils/colors.dart';
import '../../../utils/images.dart';
import '../../../utils/screen_size.dart';
import '../../fuel_master/fuel_master_widgets/searchable_dropdown.dart';
import '../../fuel_master/fuel_master_widgets/shadow_textfield.dart';
import '../../widgets/date_picker.dart';

class OnboardingHomeScreen extends StatefulWidget {
  const OnboardingHomeScreen({Key? key}) : super(key: key);

  @override
  _OnboardingHomeScreenState createState() => _OnboardingHomeScreenState();
}

class _OnboardingHomeScreenState extends State<OnboardingHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController tyreWeightController = TextEditingController();
  TextEditingController serialNumnerController = TextEditingController();
  TextEditingController tyreWidthController = TextEditingController();
  TextEditingController threadDepthController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController warrantyController = TextEditingController();
  TextEditingController maxPsiController = TextEditingController();
  TextEditingController recommendedPsiController = TextEditingController();

  DateTime date = DateTime.now();

  Rx<XFile?>? file;
  TyreController tyreController = Get.find();

  int tyreSize = 0,
      tyreModel = 0,
      tyreBrand = 0,
      threadPattern = 0,
      tyreSpecification = 0,
      tyreVendor = 0,
      warrantyPeriod = 0;
  late Map<String, dynamic> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = {};
  }

  bool allFieldFilled() {
    if (tyreWeightController.value.text.isNotEmpty &&
        tyreWidthController.text.isNotEmpty &&
        threadDepthController.value.text.isNotEmpty &&
        dayController.text.isNotEmpty &&
        monthController.value.text.isNotEmpty &&
        yearController.text.isNotEmpty &&
        warrantyController.text.isNotEmpty &&
        tyreSize != 0 &&
        tyreModel != 0 &&
        tyreBrand != 0 &&
        threadPattern != 0 &&
        tyreSpecification != 0 &&
        tyreVendor != 0 &&
        warrantyPeriod != 0 && file?.value!=null) {
      return true;
    }
    Get.showSnackbar(GetSnackBar(
      backgroundColor: greenText,
      isDismissible: true,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
      title: "Field required",
      message: "All Fields are required ",
    ));
    return false;
  }

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
                    "Tyre Details",
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
                    // selected size
                    ObxValue((RxList list) {
                      return SearchableDropdown(
                        withIcon: false,
                        enabled: true,
                        hintText: "Select Size",
                        listItems: tyreController.tyreSizeList
                            .map((e) => "${e.sizeName}")
                            .toList(),
                        onChanged: (value) {
                          tyreSize = tyreController.tyreSizeList.firstWhere((element) => value == element.sizeName).id??0;
                          print("tyreSize onChanged $tyreSize");
                          data.remove("size");
                          data.putIfAbsent('size', () => tyreSize);
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
                    }, tyreController.tyreSizeList),
                    SizedBox(
                      height: 10,
                    ),

                    // Tyre Model
                    ObxValue((RxList list) {
                      return SearchableDropdown(
                        withIcon: false,
                        enabled: true,
                        hintText: "Tyre Model",
                        listItems: tyreController.tyreModelList
                            .map((e) => "${e.modelName}")
                            .toList(),
                        onChanged: (value) {
                          tyreModel = tyreController.tyreModelList.firstWhere((element) => value == element.modelName).id??0;
                          print("tyreModel onChanged $tyreModel");
                          data.remove("model");
                          data.putIfAbsent('model', () => tyreModel);
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
                    }, tyreController.tyreModelList),
                    SizedBox(
                      height: 10,
                    ),

                      ShadowTextField(
                      maxLine: 1,
                     
                      
                      hintText: "Enter Serial Number",
                      controller: serialNumnerController,
                      onChanged: (value) {
                        data.remove("serial_number");
                        data.putIfAbsent('serial_number', () => serialNumnerController.text);
                      },
                    ),

                    SizedBox(
                      height: 10,
                    ),


                    ShadowTextField(
                      maxLine: 1,
                      keyboardType: TextInputType.number,
                      
                      hintText: "Enter Weight (Kgs)",
                      controller: tyreWeightController,
                      onChanged: (value) {
                        data.remove("weight");
                        data.putIfAbsent('weight', () => tyreWeightController.text);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      maxLine: 1,
                      keyboardType: TextInputType.number,
                      hintText: "Enter Width (mms)",
                      controller: tyreWidthController,
                      onChanged: (value) {
                        data.remove("width");
                        data.putIfAbsent('width', () => tyreWidthController.text);
                      },
                    ),

                     SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      maxLine: 1,
                      keyboardType: TextInputType.number,
                      hintText: "Enter Maximum PSI",
                      controller: maxPsiController,
                      onChanged: (value) {
                        data.remove("max_psi");
                        data.putIfAbsent('max_psi', () => maxPsiController.text);
                      },
                    ),

                     SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      maxLine: 1,
                      keyboardType: TextInputType.number,
                      hintText: "Enter Recommended PSI",
                      controller: recommendedPsiController,
                      onChanged: (value) {
                        data.remove("recom_psi");
                        data.putIfAbsent('recom_psi', () => recommendedPsiController.text);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ObxValue((RxList list) {
                      return SearchableDropdown(
                        withIcon: false,
                        enabled: true,
                        hintText: "Select Brand",
                        listItems: tyreController.tyreBrandList
                            .map((e) => "${e.brandName}")
                            .toList(),
                        onChanged: (value) {
                          tyreBrand = tyreController.tyreBrandList.firstWhere((element) => value == element.brandName).id??0;
                          print("tyreBrand onChanged $tyreBrand");
                          data.remove("brand");
                          data.putIfAbsent('brand', () => tyreBrand);
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
                    }, tyreController.tyreBrandList),
                    SizedBox(
                      height: 10,
                    ),
                    ObxValue((RxList list) {
                      return SearchableDropdown(
                        withIcon: false,
                        enabled: true,
                        hintText: "Select Thread Pattern",
                        listItems: tyreController.threadPatternList
                            .map((e) => "${e.treadPatternName}")
                            .toList(),
                        onChanged: (value) {
                          threadPattern = tyreController.threadPatternList.firstWhere((element) => value == element.treadPatternName).id??0;
                          print("threadPattern onChanged $threadPattern");
                          data.remove("tread_pattern");
                          data.putIfAbsent('tread_pattern', () => threadPattern);
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
                    }, tyreController.threadPatternList),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      maxLine: 1,
                      keyboardType: TextInputType.number,
                      hintText: "Enter Thread Depth (mm)",
                      controller: threadDepthController,
                      onChanged: (value) {
                        data.remove("depth");
                        data.putIfAbsent('depth', () => threadDepthController.text);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ObxValue((RxList list) {
                      return SearchableDropdown(
                        withIcon: false,
                        enabled: true,
                        hintText: "Select Tyre Specification",
                        listItems: tyreController.tyreSpecificationList
                            .map((e) => "${e.specifictionName}")
                            .toList(),
                        onChanged: (value) {
                          tyreSpecification = tyreController.tyreSpecificationList.firstWhere((element) => value == element.specifictionName).id??0;
                          print("tyreSpecification onChanged $tyreSpecification");
                          data.remove("specification");
                          data.putIfAbsent('specification', () => tyreSpecification);
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
                    }, tyreController.tyreSpecificationList),
                    SizedBox(
                      height: 10,
                    ),
                    ObxValue((RxList list) {
                      return SearchableDropdown(
                        withIcon: false,
                        enabled: true,
                        hintText: "Select Tyre Vendor",
                        listItems: tyreController.vendorList
                            .map((e) => "${e.vendorName}")
                            .toList(),
                        onChanged: (value) {
                          tyreVendor = tyreController.vendorList.firstWhere((element) => value == element.vendorName).id??0;
                          print("tyreVendor onChanged $tyreVendor");
                          data.remove("vendor");
                          data.putIfAbsent('vendor', () => tyreVendor);
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
                    }, tyreController.vendorList),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Purchase Date",
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

                                    data.remove("purchase_date");
                                    data.putIfAbsent('purchase_date', () => "${date.year}-${date.month}-${date.day}");

                                    data.remove("warranty_expire_date");
                                    data.putIfAbsent('warranty_expire_date', () => "${date.year+warrantyPeriod}-${date.month}-${date.day}");

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
                    Text(
                      "Warranty Period",
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
                      hintText: "Select Warranty Period",
                      listItems: [
                        '1 Years',
                        '2 Years',
                        '3 Years',
                        '4 Years',
                        '5 Years'
                      ].map((e) => "${e}").toList(),
                      onChanged: (value) {
                        warrantyPeriod = int.parse(value!.split(" ")[0]);
                        print("warrantyPeriod onChanged $warrantyPeriod");
                        data.remove("warranty_period");
                        data.putIfAbsent('warranty_period', () => warrantyPeriod);

                        data.remove("warranty_expire_date");
                        data.putIfAbsent('warranty_expire_date', () => "${date.year+warrantyPeriod}-${date.month}-${date.day}");
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
                      height: 10,
                    ),
                    ShadowTextField(
                      maxLine: 1,
                      keyboardType: TextInputType.number,
                      hintText: "Warranty Kilometers",
                      controller: warrantyController,
                      onChanged: (value) {
                        data.remove("warranty_kms");
                        data.putIfAbsent('warranty_kms', () => warrantyController.text);
                      },
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

                        var tyreImage =await multiFile.MultipartFile.fromFile(file?.value?.path??"", filename: filename);
                        data.remove("tyre_image");
                        data.putIfAbsent('tyre_image', () => tyreImage);
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
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        print("press here..!");
                        if(allFieldFilled()){
                          showGeneralDialog(
                            context: context,
                            barrierColor: Colors.black.withOpacity(0.9),
                            // Background color
                            barrierDismissible: false,
                            transitionDuration: Duration(milliseconds: 400),
                            pageBuilder: (_, __, ___) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(tyre_saved),
                                  const Text(
                                    "Tyre attributes have been saved.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 24,
                                      decoration: TextDecoration.none,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      data.remove("is_deploy");
                                      data.putIfAbsent('is_deploy', () => 0);
                                      Get.off(SelectStoreCodeScreen(data:data,file: file?.value ?? XFile(""),),
                                          transition: Transition.rightToLeft);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: ScreenSize.width * 0.82,
                                      height: ScreenSize.height * 0.065,
                                      child: const Text(
                                        "Add To Store",
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
                                                color:
                                                Colors.black.withOpacity(0.3))
                                          ],
                                          borderRadius: BorderRadius.circular(
                                              ScreenSize.width * 0.1)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      data.remove("is_deploy");
                                      data.putIfAbsent('is_deploy', () => 1);

                                      tyreController.onBoardingTyre(data: data,file: file?.value??XFile(""), isNavigate: true, serialNumber: serialNumnerController.text.trim().toString() );
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: ScreenSize.width * 0.82,
                                      height: ScreenSize.height * 0.065,
                                      child: ObxValue((RxBool value){
                                        if (value.isTrue) {
                                          return SizedBox(
                                              height: ScreenSize.height * 0.02,
                                              width: ScreenSize.height * 0.02,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ));
                                        }
                                        return const Text(
                                          "Deploy Tyre",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                            fontSize: 18,
                                            decoration: TextDecoration.none,
                                          ),
                                        );
                                      },tyreController.isSubmitting),
                                      decoration: BoxDecoration(
                                          color: green,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 3,
                                                spreadRadius: 1.2,
                                                offset: Offset(0, 3),
                                                color:
                                                Colors.black.withOpacity(0.3))
                                          ],
                                          borderRadius: BorderRadius.circular(
                                              ScreenSize.width * 0.1)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: ScreenSize.width * 0.82,
                                      height: ScreenSize.height * 0.065,
                                      child: Text(
                                        "Cancel",
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
                                                color:
                                                Colors.black.withOpacity(0.3))
                                          ],
                                          borderRadius: BorderRadius.circular(
                                              ScreenSize.width * 0.1)),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: ScreenSize.height * 0.065,
                        child: const Text(
                          "Continue",
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
                                  color: Colors.black.withOpacity(0.3))
                            ],
                            borderRadius:
                                BorderRadius.circular(ScreenSize.width * 0.1)),
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
      ),
    );
  }
}
