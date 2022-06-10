import 'package:PrimeMetrics/screens/fuel_master/fuel_master_widgets/searchable_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/screen_size.dart';
import '../../../fuel_master/fuel_master_widgets/shadow_textfield.dart';
import '../../tyre_home_screen.dart';

class DetailedInspectionScreen extends StatefulWidget {
  const DetailedInspectionScreen({Key? key}) : super(key: key);

  @override
  _DetailedInspectionScreenState createState() =>
      _DetailedInspectionScreenState();
}

class _DetailedInspectionScreenState extends State<DetailedInspectionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController serialNumberController = TextEditingController();
  TextEditingController depthController = TextEditingController();
  TextEditingController pressureController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  int value = 0;
  List list = ["Yes", "No"];
  bool isCheckboxSelected = false;

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
                    "Detailed Inspection",
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
                    ShadowTextField(
                      controller: serialNumberController,
                      hintText: "Tyre Serial Number",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      controller: depthController,
                      hintText: "Thread Depth",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShadowTextField(
                      controller: pressureController,
                      hintText: "Tyre Pressure",
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Retread Needed?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(10),
                            child: RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              activeColor: green,
                              value: index,
                              groupValue: value,
                              onChanged: (index) {
                                setState(
                                  () {
                                    value = int.parse(index.toString());
                                  },
                                );
                              },
                              title: Text(list[index] ?? ""),
                            ),
                          ),
                        );
                      },
                      itemCount: list.length,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SearchableDropdown(
                      enabled: true,
                      hintText: "Defect",
                      listItems:
                          ['Defect 1', 'Defect 2'].map((e) => "${e}").toList(),
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
                      height: 10,
                    ),
                    ShadowTextField(
                      controller: noteController,
                      hintText: "Notes",
                      maxLine: 8,
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      height: 100,
                      alignment: Alignment.center,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () async {
                          // if (pressureController.text.isNotEmpty) {
                          //   if (int.parse(pressureController.text) <= 20) {
                          //     Get.to(PressureBelowScreen(),
                          //         transition: Transition.rightToLeft);
                          //   } else {}
                          // }
                          //Get.to(PressureVerified(), transition: Transition.rightToLeft);
                          showGeneralDialog(
                            context: context,
                            barrierColor: Colors.black.withOpacity(0.9),
                            // Background color
                            barrierDismissible: false,
                            transitionDuration: Duration(milliseconds: 400),
                            pageBuilder: (_, __, ___) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return Scaffold(
                                  backgroundColor:
                                      Colors.black.withOpacity(0.9),
                                  body: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      const Text(
                                        "Would you like to perform another inspection?",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 24,
                                          decoration: TextDecoration.none,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: CheckboxListTile(
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          value: isCheckboxSelected,
                                          side: BorderSide(color: Colors.white),
                                          onChanged: (value) {
                                            setState(() {
                                              isCheckboxSelected =
                                                  value ?? false;
                                            });
                                          },
                                          title: Text(
                                            "Do not ask again",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          //Get.off(SelectStoreCodeScreen(), transition: Transition.rightToLeft);
                                          Get.back();
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: ScreenSize.width * 0.82,
                                          height: ScreenSize.height * 0.065,
                                          child: const Text(
                                            "Yes",
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white,
                                              fontSize: 18,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color: green,
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 3,
                                                    spreadRadius: 1.2,
                                                    offset: Offset(0, 3),
                                                    color: Colors.black
                                                        .withOpacity(0.3))
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ScreenSize.width * 0.1)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.offAll(TyreHomeScreen(),
                                              transition:
                                                  Transition.leftToRight);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: ScreenSize.width * 0.82,
                                          height: ScreenSize.height * 0.065,
                                          child: Text(
                                            "No",
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: green,
                                              fontSize: 18,
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 3,
                                                    spreadRadius: 1.2,
                                                    offset: Offset(0, 3),
                                                    color: Colors.black
                                                        .withOpacity(0.3))
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ScreenSize.width * 0.1)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                );
                              });
                            },
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: ScreenSize.width * 0.82,
                          height: ScreenSize.height * 0.065,
                          child: Text(
                            "Submit",
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
                              borderRadius: BorderRadius.circular(
                                  ScreenSize.width * 0.1)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
