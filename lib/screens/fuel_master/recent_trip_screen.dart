import 'package:PrimeMetrics/controllers/fuel/fuel_controller.dart';
import 'package:PrimeMetrics/models/recent_trip_model.dart';
import 'package:PrimeMetrics/screens/fuel_master/select_fueling_point_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/screen_size.dart';
import '../../utils/toast.dart';

class RecentTripScreen extends StatefulWidget {
  const RecentTripScreen({Key? key}) : super(key: key);

  @override
  _RecentTripScreenState createState() => _RecentTripScreenState();
}

class _RecentTripScreenState extends State<RecentTripScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int value = 0;
  List<RecentTripModel> recentList=[];
  FuelController fuelController=Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fuelController.getManufacturer();
    fuelController.getProducts();
    fuelController.getTowns();
    fuelController.getDrivers();
    fuelController.getRouteCodes();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: ScreenSize(
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
                    "Recent Trips",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 22),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Please select the trip",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      ObxValue((RxList list){
                        recentList =fuelController.recentTips.map((element) => element).toList();
                        if(recentList.length==0){
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Center(
                              child: Text("No record found"),
                            ),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            print("Index RecentTrip $index");
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(10),
                                child: RadioListTile(
                                  controlAffinity:
                                  ListTileControlAffinity.trailing,
                                  activeColor: green,
                                  value: index,
                                  groupValue: value,
                                  onChanged: (index) {
                                    print("selected index $index");
                                    print("route : ${recentList[int.parse(index.toString())].route}");
                                    setState(
                                          () {
                                        value = int.parse(index.toString());
                                      },
                                    );
                                  },
                                  title: Text(recentList[index].route??""),
                                ),
                              ),
                            );
                          },
                          itemCount: recentList.length,
                        );
                      },fuelController.recentTips),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 100,
              alignment: Alignment.center,
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () async {
                  if(recentList.length>0){
                    Get.to(SelectFuelingPointScreen(recentTripModel: recentList[value]),
                        transition: Transition.rightToLeft);
                  }else{
                    show("Error", "Recent trip not found");
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: ScreenSize.width * 0.82,
                  height: ScreenSize.height * 0.065,
                  child: Text(
                    "Next",
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
                      borderRadius:
                          BorderRadius.circular(ScreenSize.width * 0.1)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
