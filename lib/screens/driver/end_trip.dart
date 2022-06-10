import 'package:PrimeMetrics/utils/colors.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:PrimeMetrics/utils/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/screen_size.dart';
import '../widgets/trip_progress_indicator.dart';
import 'confirm_end_trip.dart';
import '../widgets/CustomeProgressIndicator.dart';
import '../widgets/date_picker.dart';
import 'package:dropdown_selection/dropdown_selection.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/trip/trip_controller.dart';
import '../../models/CompanyTown.dart';
import '../../utils/toast.dart';

class EndTrip extends StatefulWidget {
  EndTrip({Key? key}) : super(key: key);

  @override
  State<EndTrip> createState() => _EndTripState();
}

class _EndTripState extends State<EndTrip> {
  var firstNameController;

  TripController tripController = Get.find();

  TextEditingController city_id = TextEditingController();

  //TextEditingController vehicle_controller = TextEditingController();
  TextEditingController newFuel = TextEditingController();

  TextEditingController fuelObc = TextEditingController();

  TextEditingController odometer = TextEditingController();

  RxString companyTown = "".obs;

  Rx<XFile?>? file;

    RxString cityName = "".obs;

  validateData() {
    if (city_id.text.isEmpty) {
      show("Town Required", "Please select city to end trip");
      return false;
    }

    if (odometer.text.isEmpty) {
      show("Odometer", "Please set the odometer reading");
      return false;
    }
    if (fuelObc.text.isEmpty) {
      show("Fuel Obc required", "Please select the fuel reading to start trip");
      return false;
    }

    return true;
  }

  @override
  void initState() {
    tripController.creatingTrip(false);
    tripController.getCompanyTowns();
    tripController.loadActiveTrip();

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
                        Container(height: 100, child: TripProgressIndicator()),
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
                               cityName(companyTown.value);

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
                                    color: green,
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
                   Obx(
                      () =>   Container(
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenSize.width * 0.01,
                            horizontal: ScreenSize.width * 0.08),
                        child:AbsorbPointer(
                            
                               absorbing:cityName.isEmpty,
                        
                        child:DatePicker(
                            disabled: false,
                            bodyText:
                                "You are about to end trip at  ${cityName}",
                            buttonText: "Confirm",
                            title: "Date Of Arrival",
                          ),
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: ScreenSize.height * 0.05,
                    ),
                    child: InkWell(
                      onTap: () async {
                        if (validateData()) {
                          tripController.endTrip(
                            odometer: odometer.text,
                            city_id: city_id.text,
                            obc: fuelObc.text,
                          );
                        }
                        // Get.to(ConfirmEndTrip());
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
                            "End Trip",
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
                    "End This Trip",
                    style: getStyle(
                        fontWeight: FontWeight.w100, color: Colors.black),
                  )
                ],
              ),
            )

            // Container(
            //   padding: EdgeInsets.all(ScreenSize.width * 0.01),
            //   margin: EdgeInsets.only(
            //     top: ScreenSize.height * 0.07,
            //     left: ScreenSize.height * 0.02,
            //     bottom: ScreenSize.height * 0.05,
            //   ),
            //   child: Row(
            //     children: [
            //       GestureDetector(
            //         onTap: () {
            //           Get.back();
            //         },
            //         child: Container(
            //           alignment: Alignment.center,
            //           width: ScreenSize.height * 0.032,
            //           height: ScreenSize.height * 0.032,
            //           child: Icon(
            //             CupertinoIcons.back,
            //             size: 20,
            //             color: Colors.white,
            //           ),
            //           decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: green,
            //           ),
            //         ),
            //       ),
            //       SizedBox(
            //         width: ScreenSize.width * 0.04,
            //       ),
            //       Text(
            //         "Mid Trip Refuel Details",
            //         style: getStyle(
            //             fontWeight: FontWeight.w100, color: Colors.black),
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
