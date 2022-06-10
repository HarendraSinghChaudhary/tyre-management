import 'dart:io';

import 'package:PrimeMetrics/utils/colors.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:PrimeMetrics/utils/style.dart';
import 'package:dropdown_selection/dropdown_selection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/trip/trip_controller.dart';
import '../../models/CompanyTown.dart';
import '../../utils/screen_size.dart';
import '../../utils/toast.dart';
import '../widgets/CustomeProgressIndicator.dart';
import '../widgets/trip_progress_indicator.dart';

class MidTripRefuel extends StatefulWidget {

  MidTripRefuel({Key? key}) : super(key: key);

  @override
  State<MidTripRefuel> createState() => _MidTripRefuelState();
}

class _MidTripRefuelState extends State<MidTripRefuel> {
  var firstNameController;

  TripController tripController = Get.find();

  TextEditingController city_id = TextEditingController();

  //TextEditingController vehicle_controller = TextEditingController();
   TextEditingController fuelStation = TextEditingController();

  TextEditingController newFuel = TextEditingController();

  TextEditingController fuelObc = TextEditingController();

  RxString companyTown = "".obs;

  Rx<XFile?>? file;

  validateData() {
    if (city_id.text.isEmpty) {
      show("City Required", "Please select the city to start trip");
      return false;
    }
    if (fuelStation.text.isEmpty) {
      show("Gasoline Station required", "Please select refuel station");
      return false;
    }

    if (newFuel.text.isEmpty) {
      show("Amount of Gasoline", "Please enter the amount of you refuel");
      return false;
    }
    if (fuelObc.text.isEmpty) {
      show("Fuel Obc required", "Please select the fuel reading to start trip");
      return false;
    }

    if (file == null || file?.value == null) {
      show("Delivery note", "Please take a photo of the delivery note");
      return false;
    }
    return true;
  }

  @override
  void initState() {
    tripController.creatingTrip(false);
    tripController.getCompanyTowns();

    // TODO: implement initState
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
              margin: EdgeInsets.only(top: ScreenSize.height * 0.12),
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenSize.width * 0.07),
                    child: Column(
                      children: [
                        Container(
                            height: 100,
                            child: TripProgressIndicator()),
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
                          child: Obx(
                            () => DropdownSelection<CompanyTown>(
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
                                iconColor: green,
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
                                companyTown.value = item?.name ?? "";

                                if (item == null) {
                                  city_id.clear();
                                  return;
                                }
                                city_id.text = item.id.toString();
                              },
                              onBeforeChange: (a, b) {
                                return Future.value(true);
                              },
                            ),
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
                                  Icons.speed_outlined,
                                   color: green,
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: false),
                                  controller: newFuel,
                                  decoration: InputDecoration(
                                      hintText: "Fuel Quantity (Litres)",
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
                                     color: green,
                                    width: ScreenSize.width * 0.04,
                                  )),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: false),
                                  controller: fuelObc,
                                  decoration: InputDecoration(
                                      hintText: "New Fuel OBC(Ltrs)",
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
                                  Icons.local_gas_station_outlined,
                                  color: green,
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                 
                                  controller: fuelStation,
                                  decoration: InputDecoration(
                                      hintText: "Refuel Station",
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
                        setState(() {
                          
                        });
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
                          image:file!=null? DecorationImage(
                            fit: BoxFit.cover,
                            image:FileImage(File(file?.value?.path??""))):null
                          ,
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
                              file?.value==null
                                  ? "Refuel"
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
                    margin: EdgeInsets.only(
                      top: ScreenSize.height * 0.05,
                    ),
                    child: InkWell(
                      onTap: () async {
                        if (validateData()) {
                          tripController.midTripRefuel(
                              fuel_quantity: newFuel.text,
                              city_id: city_id.text,
                              station_name: fuelStation.text,
                              obc: fuelObc.text,
                              
                              file: file?.value ?? XFile(""));
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: ScreenSize.width * 0.82,
                        height: ScreenSize.height * 0.065,
                        child: ObxValue((RxBool value) {
                          if (tripController.creatingTrip.isTrue) {
                            return SizedBox(
                                height: ScreenSize.height * 0.02,
                                width: ScreenSize.height * 0.02,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ));
                          }
                          return Text(
                            "Done",
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
                    "Mid Trip Refuel Details",
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
