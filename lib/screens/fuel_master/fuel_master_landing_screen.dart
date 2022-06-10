import 'package:PrimeMetrics/controllers/fuel/fuel_controller.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../models/user_info.dart';
import '../../utils/colors.dart';
import '../../utils/screen_size.dart';
import '../../utils/store.dart';
import 'fuel_master_select_truck_screen.dart';

class FuelMasterLandingScreen extends StatefulWidget {
  const FuelMasterLandingScreen({Key? key}) : super(key: key);

  @override
  State<FuelMasterLandingScreen> createState() =>
      _FuelMasterLandingScreenState();
}

class _FuelMasterLandingScreenState extends State<FuelMasterLandingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController authController = Get.find();
  FuelController fuelController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (getUserInfo() is UserInfo) {
      AuthController.userInfo = getUserInfo()??UserInfo();
    } else {
      var user =getUserInfo();
      AuthController.userInfo = user??UserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SafeArea(
          child: Container(
            height: 80,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: green,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 5.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    child: Icon(
                      Icons.menu,
                      color: white,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: ScreenSize.width * 0.035),
                    child: Image.asset(
                      fuel_logo,
                      width: ScreenSize.width * 0.10,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.settings,
                      color: white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: grey,
                  radius: 60,
                  backgroundImage: NetworkImage(
                      'https://media.istockphoto.com/photos/friendly-male-student-using-smart-phone-picture-id1327787245?b=1&k=20&m=1327787245&s=170667a&w=0&h=f7aYj-LO_n1KLyfhUMj-M7yqfij6ZJYtjyvRmhc_R8s='),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Jon Doe",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: green, fontSize: 22),
                ),
                Text(
                  "Fuel Master",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: Colors.black,
                      fontSize: 16),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(2),
                  color: green.withOpacity(0.2),
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.star,
                    color: green,
                  ),
                ),
                Container(
                  height: 40,
                  width: 200,
                  color: green.withOpacity(0.1),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Loren Ipsum",
                      softWrap: true,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(2),
                  color: green.withOpacity(0.2),
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.star,
                    color: green,
                  ),
                ),
                Container(
                  height: 40,
                  width: 200,
                  color: green.withOpacity(0.1),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Loren Ipsum",
                      softWrap: true,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(2),
                  color: green.withOpacity(0.2),
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.star,
                    color: green,
                  ),
                ),
                Container(
                  height: 40,
                  width: 200,
                  color: green.withOpacity(0.1),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Loren Ipsum",
                      softWrap: true,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(2),
                  color: green.withOpacity(0.2),
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.star,
                    color: green,
                  ),
                ),
                Container(
                  height: 40,
                  width: 200,
                  color: green.withOpacity(0.1),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Loren Ipsum",
                      softWrap: true,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(2),
                  color: green.withOpacity(0.2),
                  height: 40,
                  width: 40,
                  child: Icon(
                    Icons.logout,
                    color: green,
                  ),
                ),
                Container(
                  height: 40,
                  width: 200,
                  color: green.withOpacity(0.1),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Logout",
                      softWrap: true,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: Colors.black,
                          fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: ScreenSize(
        child: Container(
          color: white,
          height: ScreenSize.height,
          width: ScreenSize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: ScreenSize.width * 0.035),
                child: Image.asset(
                  fuel_landing_logo,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Hi, Fuel Master!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 22),
              ),
              Text(
                "Let's get to work...",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  fuelController.getTrucks();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: ScreenSize.width * 0.82,
                  height: ScreenSize.height * 0.065,
                  child: ObxValue((RxBool value){
                    if (value.isTrue) {
                      return SizedBox(
                          height: ScreenSize.height * 0.02,
                          width: ScreenSize.height * 0.02,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ));
                    }
                    return Text(
                      "Start Fuel Uplift",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                          fontSize: 18),
                    );
                  }, fuelController.isSubmitting),
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
            ],
          ),
        ),
      ),
    );
  }
}
