import 'package:PrimeMetrics/screens/fuel_master/fuel_master_landing_screen.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/screen_size.dart';
import 'fuel_master_widgets/searchable_dropdown.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({Key? key}) : super(key: key);

  @override
  _ThankYouScreenState createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: ScreenSize.width * 0.035),
              child: Image.asset(
                trip_end_logo,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Thank You!",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 22),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "A notification has been sent to the selected driver.",
                style: TextStyle(color: Colors.black, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
              splashColor: Colors.transparent,
              onTap: () async {},
              child: Container(
                alignment: Alignment.center,
                width: ScreenSize.width * 0.4,
                height: ScreenSize.height * 0.065,
                child: Text(
                  "Undo",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: green,
                      fontSize: 18),
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
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        alignment: Alignment.center,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () async {
            Get.offAll(FuelMasterLandingScreen(),
                transition: Transition.leftToRight);
          },
          child: Container(
            alignment: Alignment.center,
            width: ScreenSize.width * 0.82,
            height: ScreenSize.height * 0.065,
            child: Text(
              "Close",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: 18),
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
                borderRadius: BorderRadius.circular(ScreenSize.width * 0.1)),
          ),
        ),
      ),
    );
  }
}
