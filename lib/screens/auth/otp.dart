// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../utils/screen_size.dart';

import '../../utils/store.dart';
import '../../utils/style.dart';
import '../../utils/toast.dart';
import 'finalize_signup.dart';

class OtpScreen extends StatefulWidget {
  String email;
  OtpScreen({required this.email});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  AuthController controller = Get.find();
  TextEditingController otpConntroler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenSize(
        child: Container(
          color: primaryColors,
          height: ScreenSize.height,
          width: ScreenSize.width,
          child: Stack(
            children: [
              Positioned(
                right: -ScreenSize.height * 0.07,
                top: -ScreenSize.height * 0.07,
                child: Container(
                  width: ScreenSize.height * 0.2,
                  height: ScreenSize.height * 0.2,
                  decoration: BoxDecoration(
                      gradient: RadialGradient(stops: const [
                        0.2,
                        0.3,
                        0.5,
                        0.7,
                        0.8,
                        1
                      ], colors: [
                        green.withOpacity(0.7),
                        green.withOpacity(0.6),
                        green.withOpacity(0.5),
                        green.withOpacity(0.4),
                        green.withOpacity(0.3),
                        green.withOpacity(0.1)
                      ]),
                      shape: BoxShape.circle),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.1),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              bottom: ScreenSize.height * 0.03,
                              top: ScreenSize.height * 0.15),
                          height: ScreenSize.height * 0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight:
                                      Radius.circular(ScreenSize.height * 0.05),
                                  topLeft: Radius.circular(
                                      ScreenSize.height * 0.05)),
                              image: DecorationImage(
                                  fit: BoxFit.contain, image: AssetImage(otp))),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              vertical: ScreenSize.height * 0.0),
                          height: ScreenSize.height * 0.15,
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenSize.width * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text.rich(
                                  TextSpan(
                                    text: "An OTP has been sent to ",
                                  ),
                                  softWrap: false,
                                  style: getStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ),
                              Text(
                                widget.email,
                                style: getStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 13),
                              ),
                              SizedBox(
                                height: ScreenSize.height * 0.01,
                              ),
                              Text.rich(
                                TextSpan(
                                  style: getStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontSize: 14),
                                  text: "Please enter below to confirm!",
                                ),
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: greenText,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
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
                                    offset: Offset(0, 3),
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
                                    Icons.lock,
                                    color: Colors.grey.withOpacity(0.5),
                                  )),
                              Expanded(
                                  child: TextFormField(
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (String value) async {
                                  if (otpConntroler.value.text.isEmpty) {
                                    show("Otp Required", "Please enter otp");
                                  } else if (otpConntroler.value.text.length <
                                      4) {
                                    show("Otp too",
                                        "Enter a minimum of 4 digits");
                                  } else {
                                    //                                   if(await controller.verifyOtp(value)){
                                    // Get.to(FinalizeSignup());
                                    //                                   }

                                  }
                                },
                                keyboardType: TextInputType.number,
                                controller: otpConntroler,
                                decoration: InputDecoration(
                                    hintText: "OTP",
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(0.5)),
                                    border: InputBorder.none),
                              )),
                            ],
                          ),
                        ),
                        Obx(
                          () => Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: ScreenSize.width * 0.1),
                            margin: EdgeInsets.only(
                                top: ScreenSize.height * 0.02,
                                bottom: ScreenSize.height * 0.1),
                            child: Text.rich(
                              TextSpan(
                                  style: getStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black,
                                      fontSize: 14),
                                  text:
                                      "If you didn’t receive the OTP, you can press ",
                                  children: [
                                    TextSpan(
                                        style: getStyle(
                                            color:
                                                controller.activateResend.isTrue
                                                    ? green
                                                    : grey,
                                            fontSize: 13),
                                        text: "Resend ",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => {
                                                if (controller
                                                    .activateResend.isTrue)
                                                  {controller.resend()}
                                              }),
                                    TextSpan(
                                      style: getStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontSize: 14),
                                      text:
                                          " ${controller.timeEllapsedForOtp} ",
                                    )
                                  ]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              right: 0,
                              left: 0,
                              bottom: 0,
                              top: 0,
                              child: Container(
                                width: ScreenSize.height * 0.2,
                                height: ScreenSize.height * 0.2,
                                decoration: BoxDecoration(
                                    gradient: RadialGradient(stops: const [
                                      0.2,
                                      0.3,
                                      0.5,
                                      0.7,
                                      0.8,
                                      1
                                    ], colors: [
                                      green.withOpacity(0.4),
                                      green.withOpacity(0.3),
                                      green.withOpacity(0.35),
                                      green.withOpacity(0.3),
                                      green.withOpacity(0.2),
                                      green.withOpacity(0.1)
                                    ]),
                                    shape: BoxShape.circle),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (controller.submittingOtp.isTrue) {
                                  return;
                                }

                                if (otpConntroler.value.text.isEmpty) {
                                  show("Otp Required", "Please enter otp");
                                  return;
                                }

                                if (otpConntroler.value.text.length != 4) {
                                  show("Otp Error",
                                      "Enter a minimum of 4 digits");
                                  return;
                                }

                                controller.verifyOTP(
                                    widget.email, otpConntroler.value.text);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(
                                    top: ScreenSize.height * 0.05,
                                    bottom: ScreenSize.height * 0.1),
                                width: ScreenSize.width * 0.82,
                                height: ScreenSize.height * 0.065,
                                child:
                                    Obx((() => controller.isVerifyLoading.value
                                        ? Align(
                                            alignment: Alignment.center,
                                            child: Platform.isAndroid
                                                ? CircularProgressIndicator(
                                                    color: Colors.white,
                                                    strokeWidth: 1,
                                                  )
                                                : CupertinoActivityIndicator())
                                        : const Text(
                                            "Submit",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white,
                                                fontSize: 18),
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
                                    borderRadius: BorderRadius.circular(
                                        ScreenSize.width * 0.1)),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
              Positioned(
                left: ScreenSize.height * 0.04,
                top: ScreenSize.height * 0.07,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: ScreenSize.height * 0.05,
                    height: ScreenSize.height * 0.05,
                    child: const Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: lightGreen,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
