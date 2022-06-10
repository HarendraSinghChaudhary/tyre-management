import 'package:PrimeMetrics/models/user_info.dart';
import 'package:PrimeMetrics/utils/colors.dart';
import 'package:PrimeMetrics/utils/screen_size.dart';
import 'package:PrimeMetrics/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../../utils/images.dart';
import '../../utils/store.dart';

class UserCompanyNotice extends StatefulWidget {
  const UserCompanyNotice({Key? key}) : super(key: key);

  @override
  _UserCompanyNoticeState createState() => _UserCompanyNoticeState();
}

class _UserCompanyNoticeState extends State<UserCompanyNotice> {
  UserInfo? data;
  @override
  void initState() {
   
    data = getUserInfo();
    // TODO: implement initState
    super.initState();
  }

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
                    Image.asset(
                      trip_icon,
                      width: ScreenSize.width * 0.6,
                    ),
                    SizedBox(
                      height: ScreenSize.height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Your account company is not active or You are currently not registered with any company",
                        textAlign: TextAlign.center,
                        style: getStyle(fontSize: 16, color: greenText),
                      ),
                    ),
                    Text(
                      "You can provide the email : ${data?.data?.email} \n to add you for a role",
                      textAlign: TextAlign.center,
                      style: getStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: white),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                 
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
                      "Exit",
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
