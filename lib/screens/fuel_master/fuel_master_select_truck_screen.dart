import 'package:PrimeMetrics/controllers/fuel/fuel_controller.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/dropdown_item_model.dart';
import '../../utils/colors.dart';
import '../../utils/screen_size.dart';
import '../../utils/toast.dart';
import 'recent_trip_screen.dart';
import 'fuel_master_widgets/searchable_dropdown.dart';

class FuelMasterSelectTruckScreen extends StatefulWidget {
  const FuelMasterSelectTruckScreen({Key? key}) : super(key: key);

  @override
  _FuelMasterSelectTruckScreenState createState() =>
      _FuelMasterSelectTruckScreenState();
}

class _FuelMasterSelectTruckScreenState
    extends State<FuelMasterSelectTruckScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  FuelController fuelController = Get.find();

  late int truckId,companyId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    truckId = 0;
    companyId = 0;
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
                    "Select Truck",
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
                        "Please choose a truck",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // FutureBuilder(
                      //   future: Future.delayed(Duration(seconds: 2)),
                      //   builder: (context, snapshot) {
                      //     switch (snapshot.connectionState) {
                      //       case ConnectionState.none:
                      //         // TODO: Handle this case.
                      //         break;
                      //       case ConnectionState.waiting:
                      //         // TODO: Handle this case.
                      //         return ClipRRect(
                      //           borderRadius: BorderRadius.circular(10),
                      //           child: Shimmer.fromColors(
                      //             baseColor: Colors.grey.withOpacity(0.2),
                      //             highlightColor: Colors.grey.withOpacity(0.5),
                      //             child: truckPicker(list: []),
                      //           ),
                      //         );
                      //         break;
                      //       case ConnectionState.active:
                      //         // TODO: Handle this case.
                      //         break;
                      //       case ConnectionState.done:
                      //         // TODO: Handle this case.
                      //         if (snapshot.hasData) {
                      //           return truckPicker(list: [
                      //             DropdownItemModel(id: 1, value: "LTC 1"),
                      //             DropdownItemModel(id: 2, value: "ZAC67 2"),
                      //             DropdownItemModel(id: 3, value: "MNP 3"),
                      //             DropdownItemModel(id: 4, value: "IND 4"),
                      //           ]);
                      //         }
                      //         break;
                      //     }
                      //     return truckPicker(list: []);
                      //   },
                      // ),
                      Obx((){
                        return truckPicker(list: fuelController.companyVehicles.map((element) => element.regNumber ?? "").toList());
                      }),
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
                  print("select truck next");
                  if (truckId == 0 && companyId==0) {
                    show("Error", "Please select truck");
                  } else {
                    fuelController.getRecentTrips(truckId: truckId);
                    fuelController.getFuelingPoints(companyId: companyId);
                    /*Get.to(RecentTripScreen(),
                        transition: Transition.rightToLeft);*/
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

  Widget truckPicker({required List<String>? list}) {
    return SearchableDropdown(
      enabled: true,
      hintText: "Select Truck",
      listItems: list,
      onChanged: (value) {
        truckId = fuelController.companyVehicles.firstWhere((element) => element.regNumber == value).id ?? 0;
        companyId = fuelController.companyVehicles.firstWhere((element) => element.regNumber == value).companyId ?? 0;
        print("truckId $truckId :: companyId $companyId ::: truckValue $value");
      },
      prefixIcon: Image.asset(
        select_truck,
        width: ScreenSize.width * 0.04,
      ),
      searchFieldProps: TextFieldProps(
        decoration: InputDecoration(
          prefixIcon: Image.asset(
            select_truck,
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
  }
}
