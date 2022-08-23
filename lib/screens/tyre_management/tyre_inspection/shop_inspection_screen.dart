import 'dart:io';

import 'package:PrimeMetrics/controllers/tyre/tyre_controller.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_inspection/registration_number_by_shop.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';
import '../../fuel_master/fuel_master_widgets/searchable_dropdown.dart';
import 'inspection_select_tyre.dart';

class ShopInspectionScreen extends StatefulWidget {
  String? deploy_on;
 ShopInspectionScreen({Key? key, required this.deploy_on}) : super(key: key);

  @override
  _ShopInspectionSAcreenState createState() => _ShopInspectionSAcreenState();
}

class _ShopInspectionSAcreenState extends State<ShopInspectionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TyreController tyreController = Get.find();
  TextEditingController odometerController = TextEditingController();


    @override
  void initState() {
    tyreController.getStoreList();
    tyreController.storeList;
    // TODO: implement initState
    super.initState();
  }

  int storeCode = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: primaryColors,
      body:
      
      
      
      
      
       SingleChildScrollView(
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


                    Obx((() =>

                     tyreController.isSubmitting.value
                        ? Align(
                            alignment: Alignment.center,
                            child: Platform.isAndroid
                                ? CircularProgressIndicator()
                                : CupertinoActivityIndicator())
                        :





                    SearchableDropdown(
                        withIcon: false,
                        enabled: true,
                        hintText: "Store Code",
                        listItems: tyreController.storeList.map((e) => "${e.storeCode}").toList(),
                        onChanged: (value) {
                          storeCode = tyreController.storeList.firstWhere((element) => value == element.storeCode).id??0;
                          // widget.data.remove('store');
                          // widget.data.putIfAbsent('store', () => storeCode);

                          print("id: "+storeCode.toString());
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
                      )
                 
                     ))




                  
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

            if (storeCode.toString() != "0") {


           Get.to(RegistrationNumberByShop(

             id: storeCode.toString(),
             odometer: "",
             deploy_on: widget.deploy_on,
           ), transition: Transition.rightToLeft);

            } else {
              Get.snackbar("Please select store code", "");
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
                borderRadius: BorderRadius.circular(ScreenSize.width * 0.1)),
          ),
        ),
      ),
    );
  }
}
