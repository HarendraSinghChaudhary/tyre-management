import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';
import '../../fuel_master/fuel_master_widgets/searchable_dropdown.dart';
import 'inspection_select_tyre.dart';

class ShopInspectionScreen extends StatefulWidget {
  const ShopInspectionScreen({Key? key}) : super(key: key);

  @override
  _ShopInspectionSAcreenState createState() => _ShopInspectionSAcreenState();
}

class _ShopInspectionSAcreenState extends State<ShopInspectionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
                    "Select Store Code",
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
                    SearchableDropdown(
                      enabled: true,
                      hintText: "Store Number",
                      listItems: ['Store Code 1', 'Store Code 2']
                          .map((e) => "${e}")
                          .toList(),
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
            Get.to(InspectionSelectTyre(), transition: Transition.rightToLeft);
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
