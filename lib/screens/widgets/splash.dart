

import 'package:PrimeMetrics/screens/auth/welcome.dart';
import 'package:PrimeMetrics/screens/dashboard/classic_dashboard.dart';
import 'package:PrimeMetrics/utils/colors.dart';
import 'package:PrimeMetrics/utils/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    getLoginStatus();
  }
  @override
  Widget build(BuildContext context) {
    return Container(height: double.infinity,
    width: double.infinity,
    color: green,
    child: const Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.white, strokeWidth: 1,),),
    );
  }

      getLoginStatus() async {
  var token = getUserInfo()?.data?.token?.toString();
  
    // var firstTime = true;
    // firstTime = prefs.getBool("isFirstTimeLaunch")?? true;
    // print("id :" + id.toString() + "^");

    Future.delayed(const Duration(seconds: 2), () {
     

      token.toString() == "" || token.toString() == "null" || token.toString() == ''
         ? Get.offAll(WelcomeScreen())
         :
           Get.offAll(()=> ClassicDashboard());
    });
  }
  
}