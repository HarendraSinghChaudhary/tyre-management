import 'package:PrimeMetrics/controllers/fuel/fuel_controller.dart';
import 'package:PrimeMetrics/models/recent_trip_model.dart';
import 'package:PrimeMetrics/screens/fuel_master/current_trip_origin_screen.dart';
import 'package:PrimeMetrics/screens/fuel_master/fuel_master_widgets/shadow_textfield.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/screen_size.dart';

class LastTripDetailScreen extends StatefulWidget {
  final int tripId;
  final RecentTripModel recentTripModel;
  const LastTripDetailScreen({Key? key, required this.tripId, required this.recentTripModel}) : super(key: key);

  @override
  _LastTripDetailScreenState createState() => _LastTripDetailScreenState();
}

class _LastTripDetailScreenState extends State<LastTripDetailScreen> {
  TextEditingController tripDistanceController = TextEditingController();
  TextEditingController averageSpeedController = TextEditingController();
  TextEditingController totalFuelConsumedController = TextEditingController();
  TextEditingController actualFuelConsumedController = TextEditingController();
  TextEditingController idlingFuelConsumedController = TextEditingController();
  TextEditingController driverScoreController = TextEditingController();
  
  FuelController fuelController=Get.find();
  Map<String,dynamic> data={};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Trip Id: ${widget.tripId}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                    "Details - Last Trip",
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
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenSize.width * 0.04,
                      ),
                      child: Text(
                        'Please enter the details of last trip from the OBC',
                      ),
                    ),
                    ShadowTextField(
                      hintText: "Trip Distance (Kms)",
                      controller: tripDistanceController,
                      icon: Image.asset(trip_distance,
                          width: ScreenSize.width * 0.04),
                      onChanged: (value){
                        print("Trip Distance $value");
                        data.remove("distance_covered");
                        data.putIfAbsent('distance_covered', () => tripDistanceController.text);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      hintText: "Average Speed (Kmh)",
                      controller: averageSpeedController,
                      icon: Image.asset(average_speed,
                          width: ScreenSize.width * 0.04),
                      onChanged: (value){
                        print("Average Speed $value");
                        data.remove("average_speed");
                        data.putIfAbsent('average_speed', () => averageSpeedController.text);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      hintText: "Total Fuel Consumed (Litres)",
                      controller: totalFuelConsumedController,
                      icon: Image.asset(fuel_consumed,
                          width: ScreenSize.width * 0.04),
                      onChanged: (value){
                        print("Total Fuel Consumed $value");
                        data.remove("total_fuel_consumed");
                        data.putIfAbsent('total_fuel_consumed', () => totalFuelConsumedController.text);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      hintText: "Idling Fuel Consumed",
                      controller: idlingFuelConsumedController,
                      icon: Image.asset(fuel_consumed,
                          width: ScreenSize.width * 0.04),
                      onChanged: (value){
                        print("Idling Fuel Consumed $value");
                        data.remove("idling_fuel_consumed");
                        data.putIfAbsent('idling_fuel_consumed', () => idlingFuelConsumedController.text);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      hintText: "Actual Fuel Consumed",
                      controller: actualFuelConsumedController,
                      icon: Image.asset(fuel_consumed,
                          width: ScreenSize.width * 0.04),
                      onChanged: (value){
                        print("Actual Fuel Consumed $value");
                        data.remove("actual_fuel_consumed");
                        data.putIfAbsent('actual_fuel_consumed', () => actualFuelConsumedController.text);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      hintText: "Overall Scenario Driver Score %",
                      controller: driverScoreController,
                      icon: Image.asset(percentage,
                          width: ScreenSize.width * 0.04),
                      onChanged: (value){
                        print("Driver Score $value");
                        data.remove("scania_driver_score");
                        data.putIfAbsent('scania_driver_score', () => driverScoreController.text);
                      },
                    ),
                  ],
                ),
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
            if(allFieldFilled()){
              data.remove("trip_id");
              data.putIfAbsent('trip_id', () => widget.tripId);
              fuelController.addLastTripDetails(data: data);
            }
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
                "Next",
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
                borderRadius: BorderRadius.circular(ScreenSize.width * 0.1)),
          ),
        ),
      ),
    );
  }

  bool allFieldFilled() {
    if (tripDistanceController.value.text.isNotEmpty && averageSpeedController.text.isNotEmpty &&
        totalFuelConsumedController.value.text.isNotEmpty && idlingFuelConsumedController.text.isNotEmpty &&
        actualFuelConsumedController.value.text.isNotEmpty && driverScoreController.text.isNotEmpty) {
      return true;
    }
    Get.showSnackbar(GetSnackBar(
      backgroundColor: greenText,
      isDismissible: true,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
      title: "Field required",
      message: "All Fields are required ",
    ));
    return false;
  }
}
