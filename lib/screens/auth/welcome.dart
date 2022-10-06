// ignore_for_file: prefer_const_constructors

import 'package:PrimeMetrics/screens/auth/login_screen.dart';
import 'package:PrimeMetrics/screens/dashboard/classic_dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../utils/screen_size.dart';
import '../../utils/store.dart';
import 'sign_up.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColors,
      height: ScreenSize.height,
      width: ScreenSize.width,
      child: Column(children: [
       
        Container(
          height: ScreenSize.height * 0.2,
             decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(ScreenSize.height * 0.05),
                    topLeft: Radius.circular(ScreenSize.height * 0.05)),
                image: DecorationImage(
                    fit: BoxFit.contain, image: AssetImage(logo))),
          
        ),
       
       
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: ScreenSize.height * 0.8,
            width: ScreenSize.width * 1.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(ScreenSize.height * 0.05),
                    topLeft: Radius.circular(ScreenSize.height * 0.05)),
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(mask_group))),
                    child: Container(
                       margin: EdgeInsets.only(bottom: ScreenSize.height*0.07),
                      child: Stack(children: [
                         Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(bottom: ScreenSize.height*0.2),
                            width: ScreenSize.width*0.82,
                            height: ScreenSize.height*0.08,
                            child: Text("Welcome",style: TextStyle(
                              
                              fontWeight: FontWeight.bold,
                              color: Colors.white,fontSize: 30),),
                        
                            ),
                        ),
                         Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {
                                
                            
                                Get.to(
                                  ClassicDashboard()

                                  // SignUpScreen()
                                  );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(bottom: ScreenSize.height*0.1),
                              width: ScreenSize.width*0.82,
                              height: ScreenSize.height*0.08,
                              child: Text("New User",style: TextStyle(
                                
                                fontWeight: FontWeight.normal,
                                color: Colors.white,fontSize: 18),),
                                                    
                              
                              decoration: BoxDecoration(color: green,
                                borderRadius: BorderRadius.circular(ScreenSize.width*0.1)
                              ),),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () {
                               Get.to(LoginScreen());
                            },
                            child: Container(
                               alignment: Alignment.center,
                              width: ScreenSize.width*0.82,
                              height: ScreenSize.height*0.08,
                                                  child:Text("Already a Member",style: TextStyle(
                                  
                                  fontWeight: FontWeight.normal,
                                  color: green,fontSize: 18),),
                              decoration: BoxDecoration(color: Colors.white,
                                borderRadius: BorderRadius.circular(ScreenSize.width*0.1)
                              ),),
                          ),
                        )
                      ]),
                    ),
          ),
        )
      
      
      ]),
    );
  }
}
