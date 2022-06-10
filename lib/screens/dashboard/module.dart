import 'package:PrimeMetrics/screens/dashboard/dashboard.dart';
import 'package:PrimeMetrics/screens/dashboard/dashboarrd.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_home_screen.dart';
import 'package:PrimeMetrics/utils/colors.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:PrimeMetrics/utils/screen_size.dart';
import 'package:PrimeMetrics/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChooseModule extends StatelessWidget {
  const ChooseModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ScreenSize.width,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Please choose your \n Trip Module:",
            textAlign: TextAlign.center,
            style: getStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: ScreenSize.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.to(MainDashboard());
                },
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          stealing_wheel,
                          width: ScreenSize.width * 0.1,
                        ),
                        SizedBox(
                          height: ScreenSize.height * 0.02,
                        ),
                        Text(
                          "Trip",
                          style: getStyle(color: Colors.white),
                        )
                      ]),
                  decoration: BoxDecoration(
                      color: greenText,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(ScreenSize.width * 0.03),
                          topLeft: Radius.circular(ScreenSize.width * 0.03))),
                  height: ScreenSize.width * 0.35,
                  width: ScreenSize.width * 0.4,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(TyreHomeScreen());
                },
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.circle_outlined,
                              size: ScreenSize.width * 0.1,
                              color: grey.withOpacity(0.3),
                            ),
                            Icon(Icons.check, color: grey.withOpacity(0.3)),
                          ],
                        ),
                        SizedBox(
                          height: ScreenSize.height * 0.02,
                        ),
                        Text(
                          "Inspection",
                          style: getStyle(
                            color: grey,
                          ),
                        )
                      ]),
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(ScreenSize.width * 0.03),
                          topRight: Radius.circular(ScreenSize.width * 0.03))),
                  height: ScreenSize.width * 0.35,
                  width: ScreenSize.width * 0.4,
                ),
              ),
            ],
          )
        ]),
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.srcOver),
                image: AssetImage(module_bg))),
      ),
    );
  }
}
