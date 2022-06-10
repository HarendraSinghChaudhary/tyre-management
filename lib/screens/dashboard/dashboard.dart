import 'package:PrimeMetrics/controllers/auth/auth_controller.dart';
import 'package:PrimeMetrics/controllers/trip/trip_controller.dart';
import 'package:PrimeMetrics/models/user_info.dart';
import 'package:PrimeMetrics/screens/driver/add_stop_destination.dart';
import 'package:PrimeMetrics/screens/driver/end_trip.dart';
import 'package:PrimeMetrics/screens/auth/finalize_signup.dart';
import 'package:PrimeMetrics/screens/driver/loading_point.dart';
import 'package:PrimeMetrics/screens/driver/mid_trip_refuel.dart';
import 'package:PrimeMetrics/screens/driver/start_trip_details.dart';
import 'package:PrimeMetrics/screens/widgets/CustomeProgressIndicator.dart';
import 'package:PrimeMetrics/utils/colors.dart';
import 'package:PrimeMetrics/utils/constants.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:PrimeMetrics/utils/screen_size.dart';
import 'package:PrimeMetrics/utils/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/style.dart';
import '../widgets/trip_progress_indicator.dart';

class MainDashboard extends StatefulWidget {
  MainDashboard({Key? key}) : super(key: key);

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  TripController tripController = Get.find();
  AuthController authController = Get.find();
  @override
  void initState() {
    if (getUserInfo() is UserInfo) {
      AuthController.userInfo = getUserInfo()??UserInfo();
    } else {
      var user =getUserInfo();
      AuthController.userInfo = user??UserInfo();
    }

    print("init");
     WidgetsBinding.instance!.addPostFrameCallback((_) {
       tripController.loadActiveTrip();
  // executes after build
  });
    
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColors,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(
                top: ScreenSize.width * 0.1,
                right: ScreenSize.width * 0.03,
                left: ScreenSize.width * 0.03),
            margin: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.015),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back_ios)),
                  Image.asset(
                    stealing_wheel,
                    color: green,
                    width: ScreenSize.width * 0.1,
                  ),
                  Icon(Icons.settings)
                ]),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(ScreenSize.height * 0.01),
                    bottomRight: Radius.circular(ScreenSize.height * 0.01)),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF000000),
                      offset: Offset.zero,
                      blurRadius: 2,
                      spreadRadius: 0.0)
                ]),
            height: ScreenSize.height * 0.2,
          ),
          Stack(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (tripController.loadingTrip.isFalse) {
                        if (this.tripController.hasActiveTrip.value) {
                        } else {
                          Get.to(StartTripDetail());
                        }
                      }
                    },
                    child: Container(
                      child: Column(children: [
                        Container(
                          margin: EdgeInsets.all(ScreenSize.width * 0.04),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(
                                      Icons.play_circle,
                                      size: ScreenSize.width * 0.1,
                                      color: white,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: ScreenSize.height * 0.02,
                                ),
                                Obx(
                                  () => Text(
                                    this.tripController.hasActiveTrip.value
                                        ? "On Going trip"
                                        : "Start Trip",
                                    style: getStyle(color: white, fontSize: 12),
                                  ),
                                ),
                              ]),
                          decoration: BoxDecoration(
                              color: green,
                              borderRadius: BorderRadius.circular(
                                ScreenSize.width * 0.01,
                              )),
                          height: ScreenSize.height * 0.3,
                          width: ScreenSize.width,
                        ),
                      ]),
                    ),
                  ),
                  ObxValue<RxBool>((hasTrip) {
                    return Stack(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(StopDestination());
                                },
                                child: Container(
                                  margin: EdgeInsets.all(ScreenSize.width * 0.01),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.asset(
                                              destination,
                                              width: ScreenSize.width * 0.07,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: ScreenSize.height * 0.02,
                                        ),
                                        Text(
                                          "Intermediary \n Destination",
                                          textAlign: TextAlign.center,
                                          style: getStyle(
                                            fontSize: ScreenSize.height * 0.02,
                                            color: white,
                                          ),
                                        )
                                      ]),
                                  decoration: BoxDecoration(
                                      color: lightBlue,
                                      borderRadius: BorderRadius.circular(
                                        ScreenSize.width * 0.01,
                                      )),
                                  height: ScreenSize.height * 0.18,
                                  width: ScreenSize.width * 0.45,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(LoadingPoint());
                                },
                                child: Container(
                                  margin: EdgeInsets.all(ScreenSize.width * 0.01),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.asset(
                                                  load_cargo,
                                                  width: ScreenSize.width * 0.09,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: ScreenSize.height * 0.02,
                                        ),
                                        Text(
                                          "Loading Point",
                                          textAlign: TextAlign.center,
                                          style: getStyle(
                                            fontSize: ScreenSize.height * 0.02,
                                            color: white,
                                          ),
                                        )
                                      ]),
                                  decoration: BoxDecoration(
                                      color: pink,
                                      borderRadius: BorderRadius.circular(
                                        ScreenSize.width * 0.01,
                                      )),
                                  height: ScreenSize.height * 0.18,
                                  width: ScreenSize.width * 0.45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        hasTrip.isTrue
                            ? SizedBox()
                            : Positioned.fill(
                                child: Container(
                                color: Colors.black.withOpacity(0.2),
                              ))
                      ],
                    );
                  }, tripController.hasActiveTrip),
                  ObxValue((RxBool hasTrip) {
                    return Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(MidTripRefuel());
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(ScreenSize.width * 0.01),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.asset(
                                              refuel,
                                              width: ScreenSize.width * 0.07,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: ScreenSize.height * 0.02,
                                        ),
                                        Text(
                                          "Mid Trip Refuel",
                                          textAlign: TextAlign.center,
                                          style: getStyle(
                                            fontSize: ScreenSize.height * 0.02,
                                            color: white,
                                          ),
                                        )
                                      ]),
                                  decoration: BoxDecoration(
                                      color: orangeBrown,
                                      borderRadius: BorderRadius.circular(
                                        ScreenSize.width * 0.01,
                                      )),
                                  height: ScreenSize.height * 0.18,
                                  width: ScreenSize.width * 0.45,
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(EndTrip());
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.all(ScreenSize.width * 0.01),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Image.asset(
                                                end_tripe,
                                                width: ScreenSize.width * 0.09,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: ScreenSize.height * 0.02,
                                          ),
                                          Text(
                                            "End Trip",
                                            textAlign: TextAlign.center,
                                            style: getStyle(
                                              fontSize: ScreenSize.height * 0.02,
                                              color: white,
                                            ),
                                          )
                                        ]),
                                    decoration: BoxDecoration(
                                        color: rightGreenOne,
                                        borderRadius: BorderRadius.circular(
                                          ScreenSize.width * 0.01,
                                        )),
                                    height: ScreenSize.height * 0.18,
                                    width: ScreenSize.width * 0.45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      hasTrip.isTrue
                            ? SizedBox()
                            : Positioned.fill(
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  child: Text("Please Create a trip",style: getStyle(color: Colors.white),),
                                color: Colors.black.withOpacity(0.2),
                              ))
                      ],
                    );
                  }, tripController.hasActiveTrip),
                ],
              ),
              ObxValue((RxBool value) {
                if (value.isFalse) {
                  return Container();
                }
                return Positioned.fill(
                    child: Container(
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 2,
                          color: white,
                        ),
                        SizedBox(
                          height: ScreenSize.height * 0.03,
                        ),
                        tripController.loadingTrip.isTrue
                            ? Text(
                                "Loading ...",
                                style: getStyle(color: Colors.white),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ));
              }, tripController.loadingTrip)
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: ScreenSize.height * 0.0062,
                horizontal: ScreenSize.width * 0.03),
            child: TripProgressIndicator(),
            width: ScreenSize.width,
            decoration: BoxDecoration(
                color: primaryColors,
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF000000).withOpacity(0.5),
                      offset: Offset.zero,
                      blurRadius: 1,
                      spreadRadius: 0.0)
                ],
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(ScreenSize.width * 0.02),
                    topLeft: Radius.circular(ScreenSize.width * 0.02))),
            height: ScreenSize.height * 0.07,
          )
        ]),
      ),
    );
  }
}
