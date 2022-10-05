import 'package:PrimeMetrics/screens/auth/welcome.dart';
import 'package:PrimeMetrics/utils/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../utils/colors.dart';
import '../../utils/screen_size.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  AuthController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScreenSize(
            child: Container(
                color: primaryColors,
                height: ScreenSize.height,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Welcome to dashboard ${AuthController.userInfo.data?.firstName} "),
                    ElevatedButton(
                        child: Text("logout"),
                        onPressed: () async {
                          await getGoogleService().signOut();
                          Get.offAll(WelcomeScreen());
                        })
                  ],
                )),
                width: ScreenSize.width)));
  }
}
