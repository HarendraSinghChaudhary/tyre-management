import 'package:PrimeMetrics/screens/fuel_master/thank_you_screen.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:PrimeMetrics/utils/toast.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/fuel/fuel_controller.dart';
import '../../models/driver_model.dart';
import '../../models/dropdown_item_model.dart';
import '../../utils/colors.dart';
import '../../utils/screen_size.dart';
import 'fuel_master_widgets/searchable_dropdown.dart';

class SelectDriverScreen extends StatefulWidget {
  const SelectDriverScreen({Key? key}) : super(key: key);

  @override
  _SelectDriverScreenState createState() => _SelectDriverScreenState();
}

class _SelectDriverScreenState extends State<SelectDriverScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<DriverModel> driverList=[];
  FuelController fuelController=Get.find();
  late int driverId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    driverId=0;
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
                    "Select Driver",
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
                        "Finally, Please choose a driver",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ObxValue((RxList list){
                        driverList = fuelController.driversListing.map((element) => element).toList();
                        return  SearchableDropdown(
                          enabled: true,
                          hintText: "Select Driver",
                          listItems: driverList.map((e) => "${e.firstName} ${e.lastName}").toList(),
                          onChanged: (value) {
                            driverId = driverList.firstWhere((element) => value == "${element.firstName} ${element.lastName}").id??0;
                            print("driver: $value, id: $driverId");
                          },
                          prefixIcon: Image.asset(
                            trip_driver,
                            width: ScreenSize.width * 0.04,
                          ),
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              prefixIcon: Image.asset(
                                trip_driver,
                                width: ScreenSize.width * 0.04,
                              ),
                              suffixIcon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              hintText: "Search",
                              border: InputBorder.none,
                            ),
                          ),
                        );
                      }, fuelController.driversListing),
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
                  if(driverId!=0){
                    Get.to(ThankYouScreen(), transition: Transition.rightToLeft);
                  }else{
                    show("Error", "Please select driver");
                  }

                },
                child: Container(
                  alignment: Alignment.center,
                  width: ScreenSize.width * 0.82,
                  height: ScreenSize.height * 0.065,
                  child: Text(
                    "Done",
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
