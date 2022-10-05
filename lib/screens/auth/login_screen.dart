// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:PrimeMetrics/models/SocialLogin.dart';
import 'package:PrimeMetrics/models/user_info.dart';
import 'package:PrimeMetrics/screens/auth/forgot_password.dart';
import 'package:PrimeMetrics/screens/auth/sign_up.dart';
import 'package:PrimeMetrics/screens/fuel_master/fuel_master_landing_screen.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_home_screen.dart';
import 'package:PrimeMetrics/screens/widgets/facebook.dart';
import 'package:PrimeMetrics/screens/widgets/google.dart';
import 'package:PrimeMetrics/utils/app_extensions.dart';
import 'package:PrimeMetrics/utils/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../utils/screen_size.dart';
import '../../utils/style.dart';
import '../../utils/toast.dart';
import 'otp.dart';
import 'package:http/http.dart' as http;


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isloading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AuthController controller = Get.find();
  RxBool showPassword = false.obs;
  linkAccountDialog() {
    var userinfo = AuthController.userInfo;
    print(userinfo.toJson());
    if (((userinfo.data?.socialAccounts?.length ?? 0) > 0)) {
      loadDialog(userinfo.data?.socialAccounts);

      // Get.offAll(Dashboard());
    }
  }


AuthController authController = Get.find();
  loadDialog(List<SocialLogin>? social) {
    Get.dialog(
      Container(
        height: ScreenSize.height * 0.2,
        alignment: Alignment.center,
        child: Material(
          color: green.withOpacity(0.5),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                vertical: ScreenSize.height * 0.3,
                horizontal: ScreenSize.height * 0.1),
            child: Column(
              children: [
                Text(
                  "To Login \n Continue with",
                  textAlign: TextAlign.center,
                  style: getStyle(fontSize: 20),
                ),
                SizedBox(height: ScreenSize.height * 0.05),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (ctx, count) {
                        var e = social![count];
                        if (e.social == "Facebook") {
                          return Facebook(
                            title: "LogIn",
                          );
                        } else if (e.social == "Google") {
                          return Google(title: "LogIn");
                        }
                        return SizedBox();
                      },
                      separatorBuilder: (ctx, count) {
                        return Text("Or");
                      },
                      itemCount: social?.length ?? 0),
                ),
              ],
            ),
          ),
        ),
      ),
      // barrierColor: green
      // actions: [
      //   TextButton(
      //       onPressed: () async {
      //         print("link now");

      //         await controller.linkAccountWithGoogle();
      //         controller.isLoadingSocialService(false);
      //         Get.back();
      //       },
      //       child: Container(
      //           alignment: Alignment.center,
      //           width: ScreenSize.width * 0.2,
      //           color: Colors.white,
      //           child: Text("Yes", style: getStyle(color: Colors.black)))),
      //   TextButton(
      //       onPressed: () {
      //         Get.back();
      //       },
      //       child: Container(
      //           alignment: Alignment.center,
      //           width: ScreenSize.width * 0.2,
      //           color: Colors.white,
      //           child: Text("No", style: getStyle(color: Colors.black)))),
      // ]);
    );
  }

  @override
  void initState() {
    // TODO: implement initState


    emailController.text = "specky9coder@gmail.com";
    passwordController.text = "111111";


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body: ScreenSize(
        child: Container(
          color: primaryColors,
          height: ScreenSize.height,
          width: ScreenSize.width,
          child: Stack(
            children: [
              Positioned(
                left: -ScreenSize.height * 0.07,
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
              Positioned(
                right: -ScreenSize.height * 0.07,
                bottom: ScreenSize.height * 0.02,
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
                          height: ScreenSize.height * 0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight:
                                      Radius.circular(ScreenSize.height * 0.05),
                                  topLeft: Radius.circular(
                                      ScreenSize.height * 0.05)),
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(logo))),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: ScreenSize.height * 0.01),
                          height: ScreenSize.height * 0.07,
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenSize.width * 0.04),
                          child: 


                          
                          
                          
                          Text(
                            "Log In",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: greenText,
                                fontSize: 25),
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
                                    Icons.email,
                                    color: Colors.grey.withOpacity(0.5),
                                  )),
                              Expanded(
                                  child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                    hintText: "Email Address",
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(0.5)),
                                    border: InputBorder.none),
                              )),
                            ],
                          ),
                        ),
                        Container(
                          width: ScreenSize.width,
                          margin: EdgeInsets.symmetric(
                              vertical: ScreenSize.height * 0.015),
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
                                  child: Obx(
                                    ()=> TextFormField(
                                                                  obscureText: showPassword.isFalse,
                                                                  controller: passwordController,
                                                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.withOpacity(0.5)),
                                      border: InputBorder.none),
                                                                ),
                                  )),
                              InkWell(
                                  onTap: () {
                                    showPassword(!showPassword.value);
                                  },
                                  child: Obx(() => showPassword.isTrue
                                      ? Icon(Icons.remove_red_eye)
                                      : Icon(Icons.password)))
                            ],
                          ),
                        ),


                        TextButton(onPressed: () {
                          Get.to(() => ForgotPassword());
                        }, child: Text("Forgot your password?",

                        style: TextStyle(
                          color: Colors.black
                        ),
                        
                        
                        
                        )),
                        InkWell(
                          onTap: () async {
                            //Get.offAll(FuelMasterLandingScreen());

                            // loginApi(emailController.text.trim(), passwordController.text.trim());


                            if (controller.sendingEmail.isTrue) {
                              return;
                            }

                            if (allFieldFilled() &&
                                passwordMatching() &&
                                vaildEmail()) {
                              await controller.loginApi(emailController.text,
                                  passwordController.text);
                              // UserInfo? userInfo = await controller.sendEmail(
                              //     emailController.text,
                              //     passwordController.text);

                              // if (userInfo == null) {
                              //   //store.remove(social_account);
                              //   // Get.to(OtpScreen());
                              // } else {
                              //   linkAccountDialog();
                              // }
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                top: ScreenSize.height * 0.05,
                                bottom: ScreenSize.height * 0.1),
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
                              return 

                                authController.sendingEmail.value
                        ? Align(
                            alignment: Alignment.center,
                            child: Platform.isAndroid
                                ? CircularProgressIndicator(color: Colors.white, strokeWidth: 1,)
                                : CupertinoActivityIndicator())
                        :
                              
                              
                              
                              
                              Text(
                                "Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                    fontSize: 18),
                              );
                            }, controller.loggingIn),
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
                        Facebook(
                          title: "Log In",
                        ),
                        Google(
                          title: "Log In",
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              top: ScreenSize.height * 0.02,
                              bottom: ScreenSize.height * 0.1),
                          child: Text.rich(TextSpan(
                              text: "Don't have an account? ",
                              children: [
                                TextSpan(
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                    text: "Sign Up",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(SignUpScreen());
                                      })
                              ])),
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  
  
  
  }


 


    
  bool allFieldFilled() {
    if (emailController.value.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      return true;
    }
    Get.showSnackbar(GetSnackBar(
      backgroundColor: greenText,
      isDismissible: true,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
      title: "Field required",
      message: "Email and password are required ",
    ));
    return false;
  }

  bool passwordMatching() {
    if (passwordController.text.isNotEmpty &&
        passwordController.text.length >= 6) {
      return true;
    }

    Get.showSnackbar(GetSnackBar(
      backgroundColor: greenText,
      isDismissible: true,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
      title: "Password Mismatch",
      message: "Password Should be atleast 6 characters",
    ));
    return false;
  }

  bool vaildEmail() {
    if (emailController.value.text.isValidEmail()) {
      return true;
    }
    Get.showSnackbar(GetSnackBar(
      backgroundColor: greenText,
      isDismissible: true,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
      title: "Invalid Email",
      message: "Email provided is not valid",
    ));
    return false;
  }




}
