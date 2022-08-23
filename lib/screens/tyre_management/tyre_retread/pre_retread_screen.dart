import 'package:PrimeMetrics/controllers/tyre/tyre_controller.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_retread/post_retread_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';
import '../../fuel_master/fuel_master_widgets/searchable_dropdown.dart';
import '../../fuel_master/fuel_master_widgets/shadow_textfield.dart';

class PreRetreadScreen extends StatefulWidget {
  String? tyre_id;

  PreRetreadScreen({required this.tyre_id});

  @override
  _PreRetreadScreenState createState() => _PreRetreadScreenState();
}

class _PreRetreadScreenState extends State<PreRetreadScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    DateTime date = DateTime.now();

  TextEditingController tyreWeightController = TextEditingController();
  TextEditingController tyreWidthController = TextEditingController();
  TextEditingController threadDepthController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  int? tyreVendor;

  TyreController tyreController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    tyreController.getTyreVendorList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: primaryColors,
      body: Obx((() => SingleChildScrollView(
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
                        "Pre-Retread Details",
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
                          "Please fill in the pre-retread details",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Get.width * 0.045,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ShadowTextField(
                          hintText: "Weight (Kgs)",
                          maxLine: 1,
                          keyboardType: TextInputType.number,
                          controller: tyreWeightController,
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ShadowTextField(
                          hintText: "Width (mms)",
                          maxLine: 1,
                          keyboardType: TextInputType.number,
                          controller: tyreWidthController,
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ShadowTextField(
                          hintText: "Thread Depth (mm)",
                          maxLine: 1,
                          keyboardType: TextInputType.number,
                          controller: threadDepthController,
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Retread Submission Date",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                         GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (ctx) {
                              return CalendarDatePicker(
                                  onDateChanged: (value) {
                                    //date(value);
                                    print(
                                        "date.millisecondsSinceEpoch --- ${date.millisecondsSinceEpoch}");
                                    print("date --- ${date}");
                                    date = value;
                                    dayController.text = date.day.toString();
                                    monthController.text =
                                        date.month.toString();
                                    yearController.text = date.year.toString();

                             

                                    Get.back();
                                  },
                                  initialDate: date,
                                  firstDate:  DateTime.now().subtract(const Duration(days: 5000)),
                                  lastDate:
                                      DateTime.now());
                            });
                      },
                      child: Row(
                        children: [
                          ShadowTextField(
                            width: ScreenSize.width * 0.2,
                            hintText: "Day",
                            controller: dayController,
                            onChanged: (value) {},
                            enabled: false,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ShadowTextField(
                              hintText: "Month",
                              controller: monthController,
                              onChanged: (value) {},
                              enabled: false,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          ShadowTextField(
                            width: ScreenSize.width * 0.2,
                            hintText: "Year",
                            controller: yearController,
                            onChanged: (value) {},
                            enabled: false,
                          ),
                        ],
                      ),
                    ),
                   
                   
                       
                        SizedBox(
                          height: 30,
                        ),
                        SearchableDropdown(
                          withIcon: false,
                          enabled: true,
                          hintText: "Select Tyre Vendor",
                          listItems: tyreController.vendorList
                              .map((e) => "${e.vendorName}")
                              .toList(),
                          onChanged: (value) {
                            tyreVendor = tyreController.vendorList
                                    .firstWhere((element) =>
                                        value == element.vendorName)
                                    .id ??
                                0;
                            print("tyreVendor onChanged $tyreVendor");
                            // data.remove("vendor");
                            // data.putIfAbsent('vendor', () => tyreVendor);

                            print("vendor id: " + tyreVendor.toString());
                          },
                          searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black,
                              ),
                              hintText: "Search",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ))),
      bottomNavigationBar: Container(
        height: 100,
        alignment: Alignment.center,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () async {

            print("press here 1");


            if (
              tyreWeightController.text.isNotEmpty && tyreWidthController.text.isNotEmpty
              && threadDepthController.text.isNotEmpty  &&
              dayController.text.isNotEmpty && monthController.text.isNotEmpty && yearController.text.isNotEmpty
            ) {

              print("press here 2");




           tyreController.preRetreadApi(
             tyre_id: widget.tyre_id.toString(), 
             weight: tyreWeightController.text.trim(), 
             width: tyreWidthController.text.trim(), 
             thread_depth: threadDepthController.text.trim(), 
             day: dayController.text.trim(), 
             month: monthController.text.trim(), 
             year: yearController.text.trim(), 
             vendor: tyreVendor.toString());

            } else {
              print("snack");
              Get.snackbar("Please fill all fields", "");
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
                  color: Colors.black.withOpacity(0.3),
                )
              ],
              borderRadius: BorderRadius.circular(
                ScreenSize.width * 0.1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
