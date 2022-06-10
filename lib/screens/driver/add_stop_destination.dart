import 'dart:ffi';
import 'dart:io';

import 'package:PrimeMetrics/models/CompanyTown.dart';
import 'package:PrimeMetrics/screens/widgets/date_picker.dart';
import 'package:PrimeMetrics/utils/colors.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:PrimeMetrics/utils/style.dart';
import 'package:PrimeMetrics/utils/toast.dart';
import 'package:dropdown_selection/dropdown_selection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../controllers/trip/trip_controller.dart';
import '../../utils/screen_size.dart';
import '../widgets/CustomeProgressIndicator.dart';
import '../widgets/trip_progress_indicator.dart';

class StopDestination extends StatefulWidget {
  StopDestination({Key? key}) : super(key: key);

  @override
  State<StopDestination> createState() => _StopDestinationState();
}

class _StopDestinationState extends State<StopDestination> {
  var firstNameController;
  RxString cityName = "".obs;
  TripController tripController = Get.find();

  AuthController authController = Get.find();
  TextEditingController city_id = TextEditingController();

  TextEditingController odometer = TextEditingController();
  TextEditingController fuelObc = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController stringArrivalTime = TextEditingController();
  TextEditingController departureTime = TextEditingController();
  Rx<XFile?>? file;

  @override
  void initState() {
    tripController.getCompanyTowns();

    // TODO: implement initState
    super.initState();
  }

  bool validateFields() {
    if (city_id.text.isEmpty) {
      show("Error", "Please select a city ");
      return false;
    }
    if (odometer.text.isEmpty) {
      show("Error", "Please input the Odometer reading of the Vehicle  ");
      return false;
    }
    if (fuelObc.text.isEmpty) {
      show("Error", "Please enter fuel on the OBC ");
      return false;
    }
    if (customerName.text.isEmpty) {
      show("Error", "Please input the customer name");
      return false;
    }
    if (file == null) {
      show("Error", "Please upload deliver note");
      return false;
    }
    // if (stringArrivalTime.text.isEmpty) {
    //   show("Error", "Please set the time you arrived");
    //   return false;
    // }
    // if (departureTime.text.isEmpty) {
    //   show("Error", "Please enter depart time");
    //   return false;
    // }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColors,
      body: Container(
        height: ScreenSize.height,
        width: ScreenSize.width,
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: ScreenSize.height * 0.13),
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenSize.width * 0.05),
                      height: 100,
                      child: TripProgressIndicator()),
                  Obx(
                    () => Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenSize.width * 0.07),
                      child: Column(
                        children: [
                          Container(
                            width: ScreenSize.width,
                            height: ScreenSize.height * 0.07,
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenSize.width * 0.03),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 3,
                                      spreadRadius: 1.2,
                                      offset: const Offset(0, 3),
                                      color: Colors.black.withOpacity(0.3))
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenSize.height * 0.01),
                                ),
                                color: Colors.white),
                            child: DropdownSelection<CompanyTown>(
                              mode: Mode.MENU,
                              showSearchBox: true,
                              showSelectedItem: true,
                             
                              compareFn: (a, b) {
                                if (b == null) {
                                  return false;
                                }
                                return a.id == b.id;
                              },
                              dropdownBuilder: (ctx, company, value) {
                                return Container(
                                    padding:
                                        EdgeInsets.all(ScreenSize.width * 0.01),
                                    child: Text(
                                      company?.name ?? "Select Town",
                                      style: getStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontSize: 13),
                                    ));
                              },
                              popupItemBuilder: (ctx, company, value) {
                                return Container(
                                    padding:
                                        EdgeInsets.all(ScreenSize.width * 0.01),
                                    child: Text(
                                      company.name ?? "",
                                      style: getStyle(
                                          color: Colors.black, fontSize: 17),
                                    ));
                              },
                              dropdownSearchDecoration: InputDecoration(
                                border: InputBorder.none,
                                iconColor: Colors.grey,
                                prefix: Container(
                                    margin: EdgeInsets.only(
                                        right: ScreenSize.width * 0.035),
                                    child: Image.asset(
                                      town,
                                      width: ScreenSize.width * 0.04,
                                    )),
                              ),
                              maxHeight: ScreenSize.height * 0.3,
                              items: tripController.companyTowns
                                  .map((element) => element)
                                  .toList(),
                              showClearButton: false,
                              onChanged: (item) {
                                if (item == null) {
                                  city_id.clear();
                                  return;
                                }
                                print("city changed to ${item.name}");
                                cityName(item.name);
                                city_id.text = item.id.toString();
                              },
                              onBeforeChange: (a, b) {
                                return Future.value(true);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenSize.height * 0.02,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenSize.width * 0.07),
                    child: Column(
                      children: [
                        Container(
                          width: ScreenSize.width,
                          height: ScreenSize.height * 0.07,
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenSize.width * 0.04),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3,
                                    spreadRadius: 1.2,
                                    offset: const Offset(0, 3),
                                    color: Colors.black.withOpacity(0.3))
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(ScreenSize.height * 0.01),
                              ),
                              color: Colors.white),
                          child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenSize.width * 0.035),
                                  child: Image.asset(
                                    ordometer,
                                    width: ScreenSize.width * 0.04,
                                  )),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: false),
                                  controller: odometer,
                                  decoration: InputDecoration(
                                      hintText: "Odometer(kms)",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.withOpacity(0.5)),
                                      border: InputBorder.none),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenSize.height * 0.02,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenSize.width * 0.07),
                    child: Column(
                      children: [
                        Container(
                          width: ScreenSize.width,
                          height: ScreenSize.height * 0.07,
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenSize.width * 0.04),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3,
                                    spreadRadius: 1.2,
                                    offset: const Offset(0, 3),
                                    color: Colors.black.withOpacity(0.3))
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(ScreenSize.height * 0.01),
                              ),
                              color: Colors.white),
                          child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenSize.width * 0.035),
                                  child: Image.asset(
                                    fuel,
                                    width: ScreenSize.width * 0.04,
                                  )),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: false),
                                  controller: fuelObc,
                                  decoration: InputDecoration(
                                      hintText: "Fuel OBC(Ltrs)",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.withOpacity(0.5)),
                                      border: InputBorder.none),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenSize.height * 0.02,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenSize.width * 0.07),
                    child: Column(
                      children: [
                        Container(
                          width: ScreenSize.width,
                          height: ScreenSize.height * 0.07,
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenSize.width * 0.04),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3,
                                    spreadRadius: 1.2,
                                    offset: const Offset(0, 3),
                                    color: Colors.black.withOpacity(0.3))
                              ],
                              borderRadius: BorderRadius.all(
                                Radius.circular(ScreenSize.height * 0.01),
                              ),
                              color: Colors.white),
                          child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenSize.width * 0.035),
                                  child: Icon(
                                    Icons.person,
                                    color: grey,
                                  )),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: customerName,
                                  decoration: InputDecoration(
                                      hintText: "Customer Name",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.withOpacity(0.5)),
                                      border: InputBorder.none),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenSize.height * 0.02,
                  ),
                  GestureDetector(
                    onTap: () async {
                      file = (await ImagePicker().pickImage(
                              source: ImageSource.camera,
                              imageQuality: 50, // <- Reduce Image quality
                              maxHeight: 500, // <- reduce the image size
                              maxWidth: 500))
                          .obs;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: ScreenSize.width * 0.07),
                      child: Container(
                        width: ScreenSize.width,
                        height: ScreenSize.height * 0.07,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenSize.width * 0.04),
                        decoration: BoxDecoration(
                            image: file != null
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                        File(file?.value?.path ?? "")))
                                : null,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  spreadRadius: 1.2,
                                  offset: const Offset(0, 3),
                                  color: Colors.black.withOpacity(0.3))
                            ],
                            borderRadius: BorderRadius.all(
                              Radius.circular(ScreenSize.height * 0.09),
                            ),
                            color: Colors.white),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Image.file(File(file?.value?.path??"")),
                            Container(
                                margin: EdgeInsets.only(
                                    right: ScreenSize.width * 0.035),
                                child: Icon(
                                  Icons.camera_alt_sharp,
                                  color: green,
                                )),
                            Flexible(
                                child: Text(
                              file?.value == null
                                  ? "Delivery Note"
                                  : "Image Attached",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: getStyle(
                                  color: green,
                                  fontSize: ScreenSize.height * 0.02),
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenSize.width * 0.02,
                          horizontal: ScreenSize.width * 0.08),
                      child: Obx(
                        () => AbsorbPointer(
                          
                             absorbing:cityName.isEmpty,
                          child: DatePicker(
                            title: "Date of arrival",
                            bodyText: "You arrived at ${cityName.value}",
                            buttonText: "Continue",
                            timeCaptured: (dateTime) {
                              print("time");
                            },
                            disabled: false,
                          ),
                        ),
                      )),
                  Container(
                      padding: EdgeInsets.symmetric(
                          vertical: ScreenSize.width * 0.01,
                          horizontal: ScreenSize.width * 0.08),
                      child: Obx(
                        () => AbsorbPointer(
                          
                             absorbing:cityName.isEmpty,
                          child: DatePicker(
                            disabled: false,
                            bodyText:
                                "You are about to confirm arrival at ${cityName}",
                            buttonText: "Continue",
                            title: "Date Of Departure",
                          ),
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(
                      top: ScreenSize.height * 0.01,
                    ),
                    child: InkWell(
                      onTap: () async {
                        if (validateFields()) {
                          tripController.addStopDestination(
                              city_id.text,
                              odometer.text,
                              fuelObc.text,
                              customerName.text,
                              file?.value ?? XFile(""));
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: ScreenSize.width * 0.82,
                        height: ScreenSize.height * 0.065,
                        child: ObxValue((RxBool value) {
                          if (value.isTrue) {
                            return SizedBox(
                                height: ScreenSize.height * 0.02,
                                width: ScreenSize.height * 0.02,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ));
                          }
                          return Text(
                            "Save",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 18),
                          );
                        }, false.obs),
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
                  ),
                ]),
              ),
            ),
            Container(
              padding: EdgeInsets.all(ScreenSize.width * 0.01),
              margin: EdgeInsets.only(
                top: ScreenSize.height * 0.07,
                left: ScreenSize.height * 0.02,
                bottom: ScreenSize.height * 0.05,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: ScreenSize.height * 0.032,
                      height: ScreenSize.height * 0.032,
                      child: Icon(
                        CupertinoIcons.back,
                        size: 20,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: green,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ScreenSize.width * 0.04,
                  ),
                  Text(
                    "Add Stop Off Destination",
                    style: getStyle(
                        fontWeight: FontWeight.w100, color: Colors.black),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
