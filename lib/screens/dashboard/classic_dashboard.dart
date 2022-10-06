// ignore_for_file: prefer_const_constructors

import 'package:PrimeMetrics/screens/dashboard/dashboard.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_home_screen.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';




class ClassicDashboard extends StatefulWidget {
  const ClassicDashboard({Key? key}) : super(key: key);

  @override
  State<ClassicDashboard> createState() => _ClassicDashboardState();
}

class _ClassicDashboardState extends State<ClassicDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.srcOver),
                image: AssetImage(module_bg))),
            ),



            Positioned(
              bottom: 20 ,
              left: 0,
              right: 0,

              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
            
                      InkWell(
                        onTap: () {
                          Get.to(() => TyreHomeScreen());

                        },
                        child: Container(
                          height: Get.height * 0.21,
                          width: Get. height * 0.22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF56AB2F)
                          ),
                                  
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                  
                              SvgPicture.asset("assets/images/tyre.svg", color: Colors.white, width: 30,),

                              SizedBox(height: 10,),
                                  
                              Text("Tyre Master", style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                                  
                              ),)
                                  
                              
                            ],
                          ),
                        ),
                      ),
            
            
                         InkWell(
                          onTap: () {

                          },
                           child: Container(
                                                 height: Get.height * 0.21,
                                                 width: Get. height * 0.22,
                                                 decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFE69D32)
                                                 ),
                                     
                                                 child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                     
                              SvgPicture.asset("assets/images/right.svg", color: Colors.white, width: 30,),
                              SizedBox(height: 10,),
                                     
                              Text("Inspection \n"
                              
                              " Master",
                              textAlign: TextAlign.center,
                               style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                                     
                              ),)
                                     
                              
                            ],
                                                 ),
                                               ),
                         ),
            
            
            
                      
                    ],),
            
            
                    SizedBox(height: 12,),
            
            
                 
                 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
            
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: Get.height * 0.21,
                          width: Get. height * 0.22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)
                                  
                            ),
                                  
                            border: Border.all(
                              color: Color(0xFF55AAE6)
                           
                            ),
                            color: Color(0xFF55AAE6)
                          ),
                                  
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                  
                              SvgPicture.asset("assets/images/tyre.svg", color: Colors.white, width: 30,),

                              SizedBox(height: 10,),
                                  
                              Text("Fuel Master", style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                                  
                              ),)
                                  
                              
                            ],
                          ),
                        ),
                      ),
            
            
                         InkWell(
                          onTap:  () {

                                Get.to(

                  


                    
                    
                    MainDashboard()
                    
                    );

                          },
                           child: Container(
                                                 height: Get.height * 0.21,
                                                 width: Get. height * 0.22,
                                                 decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(40),
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)
                                     
                            ),
                                     
                            border: Border.all(
                             color: Color(0xFFE627DD)
                           
                            ),
                            
                            color: Color(0xFFE627DD)
                                                 ),
                                     
                                                 child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                     
                              SvgPicture.asset("assets/images/styring.svg", color: Colors.white, width: 30,),
                              SizedBox(height: 10,),
                                     
                              Text("Trip Master",
                              textAlign: TextAlign.center,
                               style: TextStyle(
                                color: Colors.white,
                                fontSize: 20
                                     
                              ),)
                                     
                              
                            ],
                                                 ),
                                               ),
                         ),
            
            
            
                      
                    ],)
                 
                  ],
                ),
              ),
            )
          ],
        )
      ),

    );
    
  }
}