import 'package:PrimeMetrics/screens/tyre_management/tyre_retread/post_retread_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';
import '../../fuel_master/fuel_master_widgets/searchable_dropdown.dart';
import '../../fuel_master/fuel_master_widgets/shadow_textfield.dart';

class PreRetreadScreen extends StatefulWidget {
  const PreRetreadScreen({Key? key}) : super(key: key);

  @override
  _PreRetreadScreenState createState() => _PreRetreadScreenState();
}

class _PreRetreadScreenState extends State<PreRetreadScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController tyreWeightController = TextEditingController();
  TextEditingController tyreWidthController = TextEditingController();
  TextEditingController threadDepthController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      hintText: "Weight (Kgs)",
                      controller: tyreWeightController,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      hintText: "Width (mms)",
                      controller: tyreWidthController,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      hintText: "Thread Depth (mm)",
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
                    Row(children: [
                      ShadowTextField(
                        width: ScreenSize.width * 0.2,
                        hintText: "Day",
                        controller: dayController,
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ShadowTextField(
                        hintText: "Month",
                        controller: monthController,
                        onChanged: (value) {},
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      ShadowTextField(
                        width: ScreenSize.width * 0.2,
                        hintText: "Year",
                        controller: yearController,
                        onChanged: (value) {},
                      ),
                    ]),
                    SizedBox(
                      height: 30,
                    ),
                    SearchableDropdown(
                      enabled: true,
                      hintText: "Select Vendor",
                      listItems:
                          ['Vendor 1', 'Vendor 2'].map((e) => "${e}").toList(),
                      onChanged: (value) {},
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
                      withIcon: false,
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
      ),
      bottomNavigationBar: Container(
        height: 100,
        alignment: Alignment.center,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () async {
            Get.to(PostRetreadScreen(), transition: Transition.rightToLeft);
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
