import 'package:PrimeMetrics/utils/colors.dart';
import 'package:PrimeMetrics/utils/screen_size.dart';
import 'package:PrimeMetrics/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/images.dart';

typedef OnCancelCaptureTime = void Function();
typedef OnCaptureTime = void Function(DateTime dateTime);

class ConfirmTrip extends StatefulWidget {
  OnCancelCaptureTime? onCancelCaptureTime;
  OnCaptureTime? onCaptureTime;
  String? bodyText;
  String? buttonText;
  ConfirmTrip(
      {Key? key,
      this.onCancelCaptureTime,
      this.onCaptureTime,
      required this.bodyText,
      required this.buttonText})
      : super(key: key);
  @override
  _ConfirmTripState createState() => _ConfirmTripState();
}

class _ConfirmTripState extends State<ConfirmTrip> {
  RxInt stage = RxInt(0);
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
                    ObxValue<RxInt>((rxint) {
                      switch (rxint.value) {
                        case 0:
                          return Image.asset(
                            trip_icon,
                            width: ScreenSize.width * 0.6,
                          );
                        case 1:
                          return Image.asset(
                            time_icon,
                            width: ScreenSize.width * 0.6,
                          );
                      }
                      return SizedBox();
                    }, stage),
                    SizedBox(
                      height: ScreenSize.height * 0.02,
                    ),
                    ObxValue((RxInt value) {
                      if (value.value == 0) {
                        return Text(

                          "${this.widget.bodyText}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: green,
                              fontSize: 22),
                        );
                      }
                      if (value.value == 1) {
                        return Text(
                          "Capture Time?",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: green,
                              fontSize: 23),
                        );
                      }
                      return SizedBox();
                    }, stage),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenSize.width * 0.2),
                      child: Text(
                        DateFormat.yMMMMEEEEd().add_jm().format(DateTime.now()),
                        textAlign: TextAlign.center,
                        style: getStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: white),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(
                      top: ScreenSize.height * 0.05,
                      bottom: ScreenSize.height * 0.02),
                child: InkWell(
                   onTap: (){
                      if (stage.value == 0) {
                          stage(1);
                          return;
                        }
                        if (stage.value == 1) {
                          if (widget.onCaptureTime != null) {
                            widget.onCaptureTime!(DateTime.now());
                          }
                        }
              },
                  child: Container(
                    alignment: Alignment.center,
                    
                    width: ScreenSize.width * 0.82,
                    height: ScreenSize.height * 0.065,
                    child: ObxValue((RxInt value) {
                      if (value.value == 0) {
                        return Text(
                          "${this.widget.buttonText}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: 18),
                        );
                      }
                      if (value.value == 1) {
                        return const Text(
                          "Confirm",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: 18),
                        );
                      }
                      return SizedBox();
                    }, stage),
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
                  if (widget.onCancelCaptureTime != null) {
                    this.widget.onCancelCaptureTime!();
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
