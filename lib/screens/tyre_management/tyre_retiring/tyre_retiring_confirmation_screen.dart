import 'package:PrimeMetrics/screens/tyre_management/tyre_retiring/tyre_retiring_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';
import '../tyre_home_screen.dart';

class TyreRetiringConfirmationScreen extends StatefulWidget {
   List<TyreRetiringForm> data;

  TyreRetiringConfirmationScreen({required this.data});

  @override
  _TyreRetiringConfirmationScreenState createState() =>
      _TyreRetiringConfirmationScreenState();
}

class _TyreRetiringConfirmationScreenState
    extends State<TyreRetiringConfirmationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print("data: "+widget.data.toString());
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: primaryColors,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: CircleAvatar(
                      backgroundColor: green,
                      radius: 18,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    "Confirmation",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 22),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(30),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tyre(s) Selected",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    ListView.builder(
                      addAutomaticKeepAlives: true,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.data.length,
                      itemBuilder: (context, index) {
                        return tyreDetailView();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Are you sure you want to retire this tyre?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAll(TyreHomeScreen(),
                            transition: Transition.leftToRight);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: ScreenSize.width * 0.82,
                        height: ScreenSize.height * 0.065,
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 18,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: green,
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
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: ScreenSize.width * 0.82,
                        height: ScreenSize.height * 0.065,
                        child: Text(
                          "No",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: green,
                            fontSize: 18,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tyreDetailView() {
    return Container(
      width: ScreenSize.width * 0.9,
      height: ScreenSize.height * 0.3,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              offset: const Offset(0, 3),
              color: Colors.black.withOpacity(0.3))
        ],
        color: green,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bridgestone",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 14),
                ),
                SizedBox(height: 5,),
                Text(
                  "Tyre # 1234567",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 3,
                      spreadRadius: 1.2,
                      offset: const Offset(0, 3),
                      color: Colors.black.withOpacity(0.3))
                ],
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                color: primaryColors,
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Thread Depth",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          "123",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Recorded PSI",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          "123",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Maximum PSI",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          "123",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
