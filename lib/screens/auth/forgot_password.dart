
import 'dart:io';

import 'package:PrimeMetrics/controllers/auth/auth_controller.dart';
import 'package:PrimeMetrics/screens/auth/otp_verification.dart';
import 'package:PrimeMetrics/utils/colors.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:PrimeMetrics/utils/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';




class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  AuthController authController = Get.put(AuthController());



  TextEditingController emailController = TextEditingController();



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

                      const  SizedBox(height: 60,),


                        GestureDetector(
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
                        Container(
                          height: ScreenSize.height * 0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight:
                                      Radius.circular(ScreenSize.height * 0.05),
                                  topLeft: Radius.circular(
                                      ScreenSize.height * 0.05)),
                              image: const DecorationImage(
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
                            "Forgot Password",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: greenText,
                                fontSize: 25),
                          ),
                        ),


                       const Text("Please enter your registered email id",
                        textAlign: TextAlign.center,
                         style: TextStyle(
                          color: Colors.black, 
                          fontSize: 16
                        ),),

                       const SizedBox(height: 40,),
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
                   


               
                        
                        Obx((() => 



                                 InkWell(
                          onTap: () async {


                            if(emailController.text.isNotEmpty) {

                              

                              authController.forgotPasswordApi(emailController.text);
                            
                            } else{
                              Get.snackbar("Please enter email id", "");
                            }
                          

                           
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                top: ScreenSize.height * 0.05,
                                bottom: ScreenSize.height * 0.1),
                            width: ScreenSize.width * 0.82,
                            height: ScreenSize.height * 0.065,
                            child: 


                              authController.isForgotLoading.value
                        ? Align(
                            alignment: Alignment.center,
                            child: Platform.isAndroid
                                ? CircularProgressIndicator(color: Colors.white, strokeWidth: 1,)
                                : CupertinoActivityIndicator())
                        :

                            
                    
                              
                              
                              
                              
                              Text(
                                "Next",
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                    fontSize: 18),
                              )
                            ,
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
                        )
                        
                        
                        
                        
                        
                        ))
                        
                  
               
                      
                
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  
  
  
  }
}