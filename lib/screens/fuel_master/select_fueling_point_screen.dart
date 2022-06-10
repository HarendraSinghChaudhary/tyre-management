import 'package:PrimeMetrics/controllers/fuel/fuel_controller.dart';
import 'package:PrimeMetrics/models/fueling_point_model.dart';
import 'package:PrimeMetrics/models/route_code_model.dart';
import 'package:PrimeMetrics/screens/fuel_master/last_trip_detail_screen.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:PrimeMetrics/utils/toast.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../models/dropdown_item_model.dart';
import '../../models/recent_trip_model.dart';
import '../../utils/colors.dart';
import '../../utils/screen_size.dart';
import 'fuel_master_widgets/searchable_dropdown.dart';

class SelectFuelingPointScreen extends StatefulWidget {
  final RecentTripModel recentTripModel;
  const SelectFuelingPointScreen({Key? key, required this.recentTripModel}) : super(key: key);

  @override
  _SelectFuelingPointScreenState createState() =>
      _SelectFuelingPointScreenState();
}

class _SelectFuelingPointScreenState extends State<SelectFuelingPointScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  List<FuelingPointModel> fuelingPointList=[];
  List<RouteCodeModel> routeList=[];
  FuelController fuelController=Get.find();

  late int routeCodeId,fuelingPointId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    routeCodeId=0;
    fuelingPointId=0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                          Expanded(
                            child: Text(
                              "${widget.recentTripModel.route}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 22),
                            ),
                          )
                          ],
                        ),
                        Text(
                          "${DateFormat("MMMM dd, yyyy").format(widget.recentTripModel.startedAt??DateTime.now())} - ${DateFormat("MMMM dd, yyyy").format(widget.recentTripModel.endedAt??DateTime.now())}",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              /*padding: EdgeInsets.all(20),*/
              margin: EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 20),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Driver"),
                        Text("${widget.recentTripModel.driverName ?? "--"}"),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Duration"),
                        Text("${widget.recentTripModel.duration ?? "--"}"),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Distance to be Covered"),
                        Text("${widget.recentTripModel.distance ?? "--"}"),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Estimated Fuel Cost"),
                        Text("${widget.recentTripModel.endOdometer ?? "--"}"),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Number of Refuels"),
                        Text("${widget.recentTripModel.refuels ?? "--"}"),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ObxValue((RxList list){
                      routeList =fuelController.routeCodeListing.map((element) => element).toList();
                      return SearchableDropdown(
                        enabled: true,
                        hintText: "Select Route Code",
                        listItems: routeList.map((e) => e.routeCode??"").toList(),
                        onChanged: (value) {
                          routeCodeId = routeList.firstWhere((element) => element.routeCode==value).id??0;
                          print("value $value routeCodeId $routeCodeId");
                        },
                        prefixIcon: Image.asset(
                          select_route_code,
                          width: ScreenSize.width * 0.04,
                        ),
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            prefixIcon: Image.asset(
                              select_route_code,
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
                    }, fuelController.routeCodeListing),
                    SizedBox(
                      height: 10,
                    ),
                    ObxValue((RxList list){
                      fuelingPointList =fuelController.fuelingPointList.map((element) => element).toList();
                      /*if(fuelingPointList.length==0){
                        return Center(
                          child: Text("No record found"),
                        );
                      }*/
                      return SearchableDropdown(
                        enabled: true,
                        hintText: "Select Fueling Point",
                        listItems: fuelingPointList.map((e) => e.name??"").toList(),
                        onChanged: (value) {
                          fuelingPointId = fuelingPointList.firstWhere((element) => element.name==value).id??0;
                          print("value $value fuelingPointId $fuelingPointId");
                        },
                        prefixIcon: Image.asset(
                          select_fueling_point,
                          width: ScreenSize.width * 0.04,
                        ),
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            prefixIcon: Image.asset(
                              select_fueling_point,
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
                    }, fuelController.fuelingPointList),
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
            if(routeCodeId==0)show("Error", "Please select route");
            else if(fuelingPointId==0)show("Error", "Please select fueling point");
            else Get.to(LastTripDetailScreen(tripId: widget.recentTripModel.id??0,recentTripModel: widget.recentTripModel), transition: Transition.rightToLeft);
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
                borderRadius: BorderRadius.circular(ScreenSize.width * 0.1)),
          ),
        ),
      ),
    );
  }
}
