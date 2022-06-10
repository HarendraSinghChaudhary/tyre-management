import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';

import 'package:PrimeMetrics/screens/driver/confirm_trip.dart';
import 'package:PrimeMetrics/utils/colors.dart';
import 'package:PrimeMetrics/utils/screen_size.dart';
import 'package:PrimeMetrics/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:ui' as ui;
import '../../controllers/trip/trip_controller.dart';
import '../../utils/images.dart';
import '../widgets/signature.dart';

typedef OnCancelCaptureTime = void Function();
typedef OnCaptureTime = void Function(DateTime dateTime);

class ConfirmEndTrip extends StatefulWidget {
  OnCancelCaptureTime? onCancelCaptureTime;
  OnCaptureTime? onCaptureTime;
  ConfirmEndTrip({Key? key, this.onCancelCaptureTime, this.onCaptureTime})
      : super(key: key);

  @override
  _ConfirmEndTripState createState() => _ConfirmEndTripState();
}

class _ConfirmEndTripState extends State<ConfirmEndTrip> {
  TripController tripController = Get.find();
  File? file;
  ScreenshotController screenshotController = ScreenshotController();
  Rx<Sammary> sammary = Sammary().obs;
  @override
  void initState() {
    tripController.loadActiveTrip();
    sammary.value = tripController.performSammary();
    // TODO: implement initState
    super.initState();
  }

  void image() {
    screenshotController.capture().then((value) {
  
      if (value == null) {
        print("no image");
        return;
      }
    print("on capture signature");
     
        print("new file capture");
        tripController.confirmTrip(value.toList());
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: ScreenSize.width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      end_trip_confirm,
                      height: ScreenSize.height * 0.12,
                      width: ScreenSize.width * 0.6,
                    ),
                    SizedBox(
                      height: ScreenSize.height * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.all(ScreenSize.width * 0.04),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Trip Summary",
                              style: getStyle(color: Colors.black),
                            ),
                            const Divider(),
                            Text(
                              sammary.value.route ?? "Constructing route..",
                              maxLines: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Duration"), Text("${sammary.value.duration}")],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Distance Covered"),
                                Text("${sammary.value.distance} Km")
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Fuel Amount"),
                                Text("${sammary.value.fuel_cost} litres")
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Number of Refuels"),
                                Text("${sammary.value.numberofRefuels}")
                              ],
                            ),
                            Divider(),
                            SignatureWidget(
                              capture: screenshotController,
                            ),
                          ]),
                      width: ScreenSize.width * .9,
                      decoration: BoxDecoration(color: Colors.white),
                      height: ScreenSize.height * 0.59,
                    )
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.symmetric(vertical: ScreenSize.height * 0.02),
                child: InkWell(
                  onTap: () async {
                    if (this.widget.onCaptureTime != null) {
                      // widget.onCaptureTime!(DateTime.now());
                    }
                    ;
                    this.image();
                    // Get.to(CaptureTime());
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
              InkWell(
                onTap: () async {
                  Get.back();
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
                      "Cancel",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: greenText,
                          fontSize: 18),
                    );
                  }, false.obs),
                  decoration: BoxDecoration(
                      color: white,
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
            ]),
      ),
    );
  }
}
