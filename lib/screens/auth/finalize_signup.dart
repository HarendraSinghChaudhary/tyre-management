
// ignore_for_file: prefer_const_constructors

import 'dart:collection';
import 'dart:io';


import 'package:PrimeMetrics/main.dart';
import 'package:PrimeMetrics/models/Role.dart';
import 'package:PrimeMetrics/models/saved_data.dart';
//import 'package:PrimeMetrics/screens/dashboard/module.dart';
import 'package:dropdown_selection/dropdown_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/user_info.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../utils/screen_size.dart';

import '../../controllers/auth/auth_controller.dart';

import '../../utils/style.dart';

import '../../utils/toast.dart';


  Map <String, String> signUpMap = HashMap();
  String isRole = "";
class FinalizeSignup extends StatefulWidget {
  const FinalizeSignup({Key? key}) : super(key: key);

  @override
  _FinalizeSignupState createState() => _FinalizeSignupState();
}

class _FinalizeSignupState extends State<FinalizeSignup> {
  RxInt currentstep = 0.obs;
  AuthController controller = Get.find();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenSize(
        child: Container(
          color: primaryColors,
          height: ScreenSize.height,
          width: ScreenSize.width,
          child: Stack(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.1),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: ScreenSize.height * 0.1,
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                              vertical: ScreenSize.height * 0.004),
                          height: ScreenSize.height * 0.2,
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenSize.width * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: ScreenSize.height * 0.15,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Obx(() => getTitles(currentstep))),
                              ),
                              SignUpProgressIndicator(
                                currentstep: currentstep,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ScreenSize.height * 0.012,
                        ),
                        Stage(currentstep: currentstep),
                        SizedBox(
                          height: ScreenSize.height * 0.02,
                        ),
                      ]),
                ),
              ),
              Positioned(
                left: ScreenSize.height * 0.04,
                top: ScreenSize.height * 0.07,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (currentstep.value == 3) {
                          // Get.offAll(ChooseModule());
                        }
                        if (currentstep.value > 0) {
                          currentstep(currentstep.value - 1);
                        } else {
                          Get.back();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: ScreenSize.height * 0.032,
                        height: ScreenSize.height * 0.032,
                        child: Icon(
                          CupertinoIcons.back,
                          size: 20,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: green,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ScreenSize.width * 0.02,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Stage extends StatelessWidget {
  RxInt currentstep;
  Stage({
    Key? key,
    required this.currentstep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        switch (currentstep.value) {
          case 0:
            return StageOneSigup(currentstep);
          case 1:
            return StageTwoSignUp(currentstep);
          case 2:
            return StageThreeSignUp(currentstep);
          case 3:
            return StageFourSignUp(currentstep);
          case 4:
            return const StageFiveSignup();
          default:
            return const SizedBox();
        }
      },
    );
  }
}






///Stage one

class StageOneSigup extends StatefulWidget {
  RxInt currentstep;

  StageOneSigup(this.currentstep);

  @override
  State<StageOneSigup> createState() => _StageOneSigupState();
}

class _StageOneSigupState extends State<StageOneSigup> {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController companyNameController = TextEditingController();

  TextEditingController addressOneController = TextEditingController();

  TextEditingController countrycodeController =
      TextEditingController(text: "+254");

  TextEditingController addressTwoController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  AuthController controller = Get.find();

  @override
  void initState() {

    firstNameController.text = firstName;
    lastNameController.text = lastName;
    firstNameController.text = AuthController.userInfo.data?.firstName ?? "";
    lastNameController.text = AuthController.userInfo.data?.lastName ?? "";

    companyNameController.text = AuthController.userInfo.data?.company ?? "";

    addressOneController.text = AuthController.userInfo.data?.addressOne ?? "";
    addressTwoController.text = AuthController.userInfo.data?.addressTwo ?? "";

    phoneController.text = AuthController.userInfo.data?.phoneNumber ?? "";

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: ScreenSize.width,
          height: ScreenSize.height * 0.07,
          padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 1.2,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.3))
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(ScreenSize.height * 0.01),
              ),
              color: Colors.white),
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(right: ScreenSize.width * 0.035),
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.grey.withOpacity(0.5),
                  )),
              Expanded(
                  child: TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                    hintText: "*First Name",
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                    border: InputBorder.none),
              )),
            ],
          ),
        ),
        SizedBox(
          height: ScreenSize.height * 0.012,
        ),
        Container(
          width: ScreenSize.width,
          height: ScreenSize.height * 0.07,
          padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 1.2,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.3))
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(ScreenSize.height * 0.01),
              ),
              color: Colors.white),
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(right: ScreenSize.width * 0.035),
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.grey.withOpacity(0.5),
                  )),
              Expanded(
                  child: TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(
                    hintText: "*Last Name",
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                    border: InputBorder.none),
              )),
            ],
          ),
        ),
        SizedBox(
          height: ScreenSize.height * 0.012,
        ),
        Container(
          width: ScreenSize.width,
          height: ScreenSize.height * 0.07,
          padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 1.2,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.3))
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(ScreenSize.height * 0.01),
              ),
              color: Colors.white),
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(right: ScreenSize.width * 0.035),
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.grey.withOpacity(0.5),
                  )),
              Expanded(
                  child: TextFormField(
                controller: companyNameController,
                decoration: InputDecoration(
                    hintText: "Company Name",
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                    border: InputBorder.none),
              )),
            ],
          ),
        ),
        SizedBox(
          height: ScreenSize.height * 0.012,
        ),
        Container(
          width: ScreenSize.width,
          height: ScreenSize.height * 0.07,
          padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 1.2,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.3))
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(ScreenSize.height * 0.01),
              ),
              color: Colors.white),
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(right: ScreenSize.width * 0.035),
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.grey.withOpacity(0.5),
                  )),
              Expanded(
                  child: TextFormField(
                controller: addressOneController,
                decoration: InputDecoration(
                    hintText: "Address 1",
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                    border: InputBorder.none),
              )),
            ],
          ),
        ),
        SizedBox(
          height: ScreenSize.height * 0.012,
        ),
        Container(
          width: ScreenSize.width,
          height: ScreenSize.height * 0.07,
          padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 1.2,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.3))
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(ScreenSize.height * 0.01),
              ),
              color: Colors.white),
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(right: ScreenSize.width * 0.035),
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.grey.withOpacity(0.5),
                  )),
              Expanded(
                  child: TextFormField(
                controller: addressTwoController,
                decoration: InputDecoration(
                    hintText: "Address 2",
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                    border: InputBorder.none),
              )),
            ],
          ),
        ),
        SizedBox(
          height: ScreenSize.height * 0.012,
        ),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: ScreenSize.width,
                height: ScreenSize.height * 0.07,
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 1.2,
                          offset: const Offset(0, 2),
                          color: Colors.black.withOpacity(0.3))
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(ScreenSize.height * 0.01),
                    ),
                    color: Colors.white),
                child: Container(
                    margin: EdgeInsets.only(right: ScreenSize.width * 0.01),
                    child: Icon(
                      Icons.flag,
                      color: Colors.grey.withOpacity(0.5),
                    )),
              ),
            ),
            SizedBox(
              width: ScreenSize.width * 0.02,
            ),
            Expanded(
              flex: 8,
              child: Container(
                height: ScreenSize.height * 0.07,
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 1.2,
                          offset: const Offset(0, 2),
                          color: Colors.black.withOpacity(0.3))
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(ScreenSize.height * 0.01),
                    ),
                    color: Colors.white),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 16),
                            prefixIcon: Container(
                                width: 15,
                                alignment: Alignment.centerLeft,
                                child: Text("+254")),
                            hintText: "*Phone Number",
                            hintStyle:
                                TextStyle(color: Colors.grey.withOpacity(0.5)),
                            border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: ScreenSize.height * 0.01,
        ),
        Text(
          "Fields with (*) are mandatory",
          style: getStyle(color: Colors.grey, fontSize: 14),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: ScreenSize.height * 0.05,
                  bottom: ScreenSize.height * 0.1),
              child: InkWell(
                onTap: () {

                  signUpMap["first_name"] = firstNameController.value.text;
                  signUpMap["last_name"] = lastNameController.value.text;
                  signUpMap["company"] = companyNameController.value.text;
                  signUpMap["country_code"] = countrycodeController.value.text;
                  signUpMap["address_one"] = addressOneController.value.text;
                  signUpMap["address_two"] = addressTwoController.value.text;
                  signUpMap["phone_number"] = phoneController.value.text;
                  signUpMap["email"] = email.toString();
                  signUpMap["password"] = "12345678";


                  if (widget.currentstep.value == 0) {
                    if (controller.validateStepOne(
                        firstNameController.value.text,
                        lastNameController.value.text,
                        phoneController.value.text,
                        countrycodeController.value.text,
                        companyNameController.value.text,
                        addressone: addressOneController.value.text,
                        addressTwo: addressTwoController.value.text)) {
                      if (widget.currentstep.value < 4) {
                        widget.currentstep(widget.currentstep.value + 1);
                      }
                      return;
                    }
                    return;
                  }
                  if (widget.currentstep.value < 4) {
                    widget.currentstep(widget.currentstep.value + 1);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: ScreenSize.width * 0.82,
                  height: ScreenSize.height * 0.065,
                  child: Obx(() {
                    if (widget.currentstep.value == 4) {
                      return const Text(
                        "Proceed to Web",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 18),
                      );
                    } else if (widget.currentstep.value == 3) {
                      return const Text(
                        "Submit",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 18),
                      );
                    }
                    return const Text(
                      "Next",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 18),
                    );
                  }),
                  decoration: BoxDecoration(
                      color: green,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            spreadRadius: 1.2,
                            offset: const Offset(0, 3),
                            color: Colors.black.withOpacity(0.3))
                      ],
                      borderRadius:
                          BorderRadius.circular(ScreenSize.width * 0.1)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}














/// Stage Two



class StageTwoSignUp extends StatefulWidget {
  RxInt currentstep;

  StageTwoSignUp(this.currentstep);

  @override
  State<StageTwoSignUp> createState() => _StageTwoSignUpState();
}

class _StageTwoSignUpState extends State<StageTwoSignUp> {
  TextEditingController rollController = TextEditingController(text: "CEO");

  TextEditingController signuprollController = TextEditingController();

  AuthController controller = Get.find();

  RxInt currentSelected = 1.obs;

  int indexOf(String roleAs) {
    return ["admin", "fleet_manager", "inspection_manager", "driver"]
        .indexOf(roleAs);
  }

  @override
  void didChangeDependencies() {
    rollController.text = AuthController.userInfo.data?.role?.userRole ?? "";
    currentSelected(
        indexOf(AuthController.userInfo.data?.signupRole ?? "admin"));
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    @override
    void initState() {
      rollController.text = AuthController.userInfo.data?.role?.userRole ?? "";
      signuprollController.text =
          AuthController.userInfo.data?.signupRole ?? "";
      print(AuthController.userInfo.data?.signupRole);
      print("index ${indexOf(signuprollController.text)}");
      currentSelected(indexOf(signuprollController.text));

      // TODO: implement initState
      super.initState();
    }

    // TODO: implement initState
    currentSelected.listen((p0) {
      signuprollController.text = [
        "admin",
        "fleet_manager",
        "inspection_manager",
        "driver"
      ].elementAt(p0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Your role in company"),
          SizedBox(
            height: ScreenSize.height * 0.01,
          ),
          Container(
            width: ScreenSize.width,
            height: ScreenSize.height * 0.07,
            padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.03),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 3,
                      spreadRadius: 1.2,
                      offset: const Offset(0, 3),
                      color: Colors.black.withOpacity(0.3))
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(ScreenSize.height * 0.01),
                ),
                color: Colors.white),
            child: DropdownSelection<String>(
              mode: Mode.MENU,
              showSearchBox: false,
              selectedItem: "CEO",
              showSelectedItem: true,
              compareFn: (a, b) {
                if (b == null) {
                  return false;
                }
                return a == b;
              },
              dropdownBuilder: (ctx, role, value) {
                return Container(
                    padding: EdgeInsets.all(ScreenSize.width * 0.01),
                    child: Text(
                      role ?? "Select Role",
                      style: getStyle(
                          color: Colors.black.withOpacity(0.8), fontSize: 13),
                    ));
              },
              popupItemBuilder: (ctx, role, value) {
                return Container(
                    padding: EdgeInsets.all(ScreenSize.width * 0.01),
                    child: Text(
                      role,
                      style: getStyle(color: Colors.black, fontSize: 17),
                    ));
              },
              dropdownSearchDecoration: InputDecoration(
                border: InputBorder.none,
                iconColor: Colors.grey,
                prefix: Container(
                    margin: EdgeInsets.only(right: ScreenSize.width * 0.035),
                    child: Image.asset(
                      town,
                      width: ScreenSize.width * 0.04,
                    )),
              ),
              maxHeight: ScreenSize.height * 0.1,
              items: ["COO", "CEO"],
              showClearButton: false,
              onChanged: (item) {
                if (item == null) {
                  rollController.text = "CEO";
                  AuthController.userInfo.data?.role = Role(userRole: "CEO");

                  return;
                }
                this.rollController.text = item;
                AuthController.userInfo.data?.role = Role(userRole: item);

                
              },
              onBeforeChange: (a, b) {
                return Future.value(true);
              },
            ),
          ),
          SizedBox(
            height: ScreenSize.height * 0.02,
          ),
          const Text("Sign up as"),
          SizedBox(
            height: ScreenSize.height * 0.02,
          ),
          ObxValue<RxInt>((value) {
            bool isSelected = value.value == 0 ? true : false;
            return GestureDetector(
              onTap: () {

                isRole = "Admin";
                currentSelected(0);
              },
              child: Container(
                width: ScreenSize.width,
                height: ScreenSize.height * 0.07,
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: const Offset(0, 3),
                          color: Colors.black.withOpacity(0.3))
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(isSelected
                          ? ScreenSize.height * 0.03
                          : ScreenSize.height * 0.01),
                    ),
                    color: Colors.white),
                child: Row(
                  children: [
                    Container(
                        margin:
                            EdgeInsets.only(right: ScreenSize.width * 0.035),
                        child: Icon(
                          Icons.supervisor_account_outlined,
                          color: green,
                        )),
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Admin",
                            style: TextStyle(
                                color: isSelected ? Colors.black : grey),
                          ),
                        ),
                        Radio(
                            activeColor: green,
                            value: value.value,
                            groupValue: 0,
                            onChanged: (int? value) {
                              currentSelected(0);
                            })
                      ],
                    )),
                  ],
                ),
              ),
            );
          }, currentSelected),
          SizedBox(
            height: ScreenSize.height * 0.012,
          ),
          ObxValue<RxInt>((value) {
            bool isSelected = value.value == 1 ? true : false;

            return GestureDetector(
              onTap: () {

                isRole = "Fleet Manager";
                currentSelected(1);
              },
              child: Container(
                width: ScreenSize.width,
                height: ScreenSize.height * 0.07,
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: const Offset(0, 3),
                          color: Colors.black.withOpacity(0.3))
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(isSelected
                          ? ScreenSize.height * 0.03
                          : ScreenSize.height * 0.01),
                    ),
                    color: Colors.white),
                child: Row(
                  children: [
                    Container(
                        margin:
                            EdgeInsets.only(right: ScreenSize.width * 0.035),
                        child: Icon(
                          Icons.how_to_reg_outlined,
                          color: green,
                        )),
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Fleet Manager",
                            style: TextStyle(
                                color: isSelected ? Colors.black : grey),
                          ),
                        ),
                        Radio(
                            activeColor: green,
                            value: value.value,
                            groupValue: 1,
                            onChanged: (int? value) {
                              currentSelected(1);
                            })
                      ],
                    )),
                  ],
                ),
              ),
            );
          }, currentSelected),
          SizedBox(
            height: ScreenSize.height * 0.012,
          ),
          ObxValue<RxInt>((value) {
            bool isSelected = value.value == 2 ? true : false;
            return GestureDetector(
              onTap: () {
                isRole = "Inspection Manager";
                currentSelected(2);
              },
              child: Container(
                width: ScreenSize.width,
                height: ScreenSize.height * 0.07,
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: const Offset(0, 3),
                          color: Colors.black.withOpacity(0.3))
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(isSelected
                          ? ScreenSize.height * 0.03
                          : ScreenSize.height * 0.01),
                    ),
                    color: Colors.white),
                child: Row(
                  children: [
                    Container(
                        margin:
                            EdgeInsets.only(right: ScreenSize.width * 0.035),
                        child: Icon(
                          Icons.emoji_people,
                          color: green,
                        )),
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Inspection Manager",
                            style: TextStyle(
                                color: isSelected ? Colors.black : grey),
                          ),
                        ),
                        Radio(
                            activeColor: green,
                            value: value.value,
                            groupValue: 2,
                            onChanged: (int? value) {
                              currentSelected(2);
                            })
                      ],
                    )),
                  ],
                ),
              ),
            );
          }, currentSelected),
          SizedBox(
            height: ScreenSize.height * 0.012,
          ),
          ObxValue<RxInt>((value) {
            bool isSelected = value.value == 3 ? true : false;
            return GestureDetector(
              onTap: () {
                isRole = "Driver";
                currentSelected(3);
              },
              child: Container(
                width: ScreenSize.width,
                height: ScreenSize.height * 0.07,
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: const Offset(0, 3),
                          color: Colors.black.withOpacity(0.3))
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(isSelected
                          ? ScreenSize.height * 0.03
                          : ScreenSize.height * 0.01),
                    ),
                    color: Colors.white),
                child: Row(
                  children: [
                    Container(
                        margin:
                            EdgeInsets.only(right: ScreenSize.width * 0.035),
                        child: Image.asset(security)),
                    Expanded(
                        child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Driver",
                            style: TextStyle(
                                color: isSelected ? Colors.black : grey),
                          ),
                        ),
                        Radio(
                            activeColor: green,
                            value: value.value,
                            groupValue: 3,
                            onChanged: (int? value) {
                              currentSelected(3);
                            })
                      ],
                    )),
                  ],
                ),
              ),
            );
          }, currentSelected),
          SizedBox(
            height: ScreenSize.height * 0.012,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: ScreenSize.height * 0.05,
                    bottom: ScreenSize.height * 0.1),
                child: InkWell(
                  onTap: () {

                    signUpMap["role"] = rollController.text;
                    signUpMap["signup_role"] = signuprollController.text;
                   
                    if (widget.currentstep.value == 1) {
                      if (rollController.text.isEmpty) {
                        show("Invalid", "Please select a role");
                        return;
                      }
                      if (signuprollController.text.isEmpty) {
                        show("Invalid", "Please selected sign up us");

                        return;
                      }

                      controller.validateStepTwo(
                          rollController.text, signuprollController.text);
                    }
                    if (widget.currentstep.value == 2) {}
                    if (widget.currentstep.value < 4) {
                      widget.currentstep(widget.currentstep.value + 1);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: ScreenSize.width * 0.82,
                    height: ScreenSize.height * 0.065,
                    child: Obx(() {
                      if (widget.currentstep.value == 4) {
                        return const Text(
                          "Proceed to Web",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              fontSize: 18),
                        );
                      } else if (widget.currentstep.value == 3) {
                        return const Text(
                          "Submit",
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              fontSize: 18),
                        );
                      }
                      return const Text(
                        "Next",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 18),
                      );
                    }),
                    decoration: BoxDecoration(
                        color: green,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              spreadRadius: 1.2,
                              offset: const Offset(0, 3),
                              color: Colors.black.withOpacity(0.3))
                        ],
                        borderRadius:
                            BorderRadius.circular(ScreenSize.width * 0.1)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}













class StageThreeSignUp extends StatefulWidget {
  RxInt currentstep;
  StageThreeSignUp(this.currentstep, {Key? key}) : super(key: key);

  @override
  _StageThreeSignUpState createState() => _StageThreeSignUpState();
}

class StageFourSignUp extends StatefulWidget {
  RxInt currentstep;
  StageFourSignUp(this.currentstep, {Key? key}) : super(key: key);

  @override
  _StageFourSignUpState createState() => _StageFourSignUpState();
}

class StageFiveSignup extends StatelessWidget {
  const StageFiveSignup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: ScreenSize.height * 0.02,
        ),
        Image.asset(
          done,
          height: ScreenSize.height * 0.2,
        ),
        Text(
          "Thank You",
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: ScreenSize.height * 0.04),
        ),
        SizedBox(
          height: ScreenSize.height * 0.005,
        ),
        Text(
          "for signing up",
          style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: ScreenSize.height * 0.03),
        ),
        SizedBox(
          height: ScreenSize.height * 0.04,
        ),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                    children: [
                      const TextSpan(
                          text: "To proceed with the system set-up, please "),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              print("clicked");
                              Get.offAll(userHasCompany());
                            },
                          text: "click here ",
                          style: TextStyle(color: Colors.blue)),
                      const TextSpan(
                          text: "to proceed to your account or visit"),
                    ],
                    style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: ScreenSize.height * 0.03,
                        color: Colors.black)),
                TextSpan(
                  text: " www.primetrics.net",
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: ScreenSize.height * 0.03,
                      color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final url = 'https://www.primetrics.net';
                      await launch(
                        url,
                      );
                    },
                ),
              ],
            )),
      ],
    );
  }
}

class WidgetModule {
  Widget icon;
  String title;
  String tag;
  Widget iconTwo;
  WidgetModule(this.icon, this.title, this.iconTwo, this.tag);
  RxBool selected = false.obs;
}






/// stage four

class _StageFourSignUpState extends State<StageFourSignUp> {
  RxList<WidgetModule> modules = RxList.empty(growable: true);
  AuthController controller = Get.find();
  @override
  void didChangeDependencies() {
    //AuthController.userInfo.data?.modules?.forEach((element) {});
    AuthController.userInfo.data?.modules?.forEach((e) {
      modules.where((p0) => e == p0.tag).first.selected(true);
    });
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  RxString isSelected = "".obs;

  // @override
  // void initState() {
  //   modules.add(WidgetModule(
  //       Image.asset(
  //         wheel,
  //         width: 20,
  //         color: grey,
  //       ),
  //       "Tyre Master",
  //       Image.asset(tyre_master),
  //       "tyre_master"));
  //   modules.add(WidgetModule(
  //       Icon(
  //         Icons.local_gas_station,
  //         color: grey,
  //       ),
  //       "Fuel Master",
  //       Image.asset(
  //         gasoline,
  //       ),
  //       "fuel_master"));
  //   modules.add(WidgetModule(Icon(Icons.offline_pin_outlined, color: grey),
  //       "Inspection Master", Image.asset(inspector), "inspection_master"));
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return


    Obx(() => 






   



      
     Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: ScreenSize.height * 0.02,
        ),


        


           InkWell(
            onTap: () {

            
              isSelected.value = "tyre_master";
            },
             child: Container(
                      width: ScreenSize.width,
                      height: ScreenSize.height * 0.07,
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenSize.width * 0.04),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 1,
                                offset: const Offset(0, 3),
                                color: Colors.black.withOpacity(0.3))
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              isSelected.value != "tyre_master"
                                ? ScreenSize.height * 0.01
                                : ScreenSize.height * 0.03),
                          ),
                          color: Colors.white),
                      child: Row(
                        children: [
                          // Container(
                          //     margin: EdgeInsets.only(
                          //         right: ScreenSize.width * 0.035),
                          //     child: ObxValue((RxBool p0) {
                          //       return p0.value
                          //           ? Container(
                          //               width: ScreenSize.width * 0.05,
                          //               height: ScreenSize.height * 0.05,
                          //               child: element.iconTwo)
                          //           : element.icon;
                          //     }, element.selected)),
                          Expanded(
                              child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Tyre Master",
                                  style: TextStyle(
                                      color: isSelected.value == "tyre_master"
                                          ? Colors.black
                                          : grey),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: ScreenSize.width * 0.045,
                                height: ScreenSize.width * 0.045,
                                decoration: BoxDecoration(
                                    color: green, shape: BoxShape.circle),
                                child: Icon(
                                  isSelected.value == "tyre_master"
                                      ? Icons.check
                                      : Icons.circle,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
           ),

           SizedBox(height: Get.height * 0.02,),



                     InkWell(
                      onTap: () {
                        isSelected.value = "fuel_master";
                      },
                       child: Container(
                                         width: ScreenSize.width,
                                         height: ScreenSize.height * 0.07,
                                         padding: EdgeInsets.symmetric(
                          horizontal: ScreenSize.width * 0.04),
                                         decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 1,
                                offset: const Offset(0, 3),
                                color: Colors.black.withOpacity(0.3))
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              isSelected.value != "fuel_master"
                                ? ScreenSize.height * 0.01
                                : ScreenSize.height * 0.03),
                          ),
                          color: Colors.white),
                                         child: Row(
                        children: [
                          // Container(
                          //     margin: EdgeInsets.only(
                          //         right: ScreenSize.width * 0.035),
                          //     child: ObxValue((RxBool p0) {
                          //       return p0.value
                          //           ? Container(
                          //               width: ScreenSize.width * 0.05,
                          //               height: ScreenSize.height * 0.05,
                          //               child: element.iconTwo)
                          //           : element.icon;
                          //     }, element.selected)),
                          Expanded(
                              child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Fuel Master",
                                  style: TextStyle(
                                      color: isSelected.value == "fuel_master"
                                          ? Colors.black
                                          : grey),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: ScreenSize.width * 0.045,
                                height: ScreenSize.width * 0.045,
                                decoration: BoxDecoration(
                                    color: green, shape: BoxShape.circle),
                                child: Icon(
                                  isSelected.value == "fuel_master"
                                      ? Icons.check
                                      : Icons.circle,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                        ],
                                         ),
                                       ),
                     ),





                     SizedBox(height: Get.height * 0.02,),


                               InkWell(
                      onTap: () {
                        isSelected.value = "inspection_master";
                      },
                       child: Container(
                                         width: ScreenSize.width,
                                         height: ScreenSize.height * 0.07,
                                         padding: EdgeInsets.symmetric(
                          horizontal: ScreenSize.width * 0.04),
                                         decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 1,
                                offset: const Offset(0, 3),
                                color: Colors.black.withOpacity(0.3))
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              isSelected.value != "inspection_master"
                                ? ScreenSize.height * 0.01
                                : ScreenSize.height * 0.03),
                          ),
                          color: Colors.white),
                                         child: Row(
                        children: [
                          // Container(
                          //     margin: EdgeInsets.only(
                          //         right: ScreenSize.width * 0.035),
                          //     child: ObxValue((RxBool p0) {
                          //       return p0.value
                          //           ? Container(
                          //               width: ScreenSize.width * 0.05,
                          //               height: ScreenSize.height * 0.05,
                          //               child: element.iconTwo)
                          //           : element.icon;
                          //     }, element.selected)),
                          Expanded(
                              child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Inspection Master",
                                  style: TextStyle(
                                      color: isSelected.value == "inspection_master"
                                          ? Colors.black
                                          : grey),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: ScreenSize.width * 0.045,
                                height: ScreenSize.width * 0.045,
                                decoration: BoxDecoration(
                                    color: green, shape: BoxShape.circle),
                                child: Icon(
                                  isSelected.value == "inspection_master"
                                      ? Icons.check
                                      : Icons.circle,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                        ],
                                         ),
                                       ),
                     ),










        // ...modules.map((element) {
        //   return InkWell(
        //     onTap: () {
        //       // element.selected(!element.selected.value);


        //       isSelected = "tyre_master";

              

        //     },
        //     child: Obx(
        //       () => Column(
        //         children: [

                   

        //           Container(
        //             width: ScreenSize.width,
        //             height: ScreenSize.height * 0.07,
        //             padding: EdgeInsets.symmetric(
        //                 horizontal: ScreenSize.width * 0.04),
        //             decoration: BoxDecoration(
        //                 boxShadow: [
        //                   BoxShadow(
        //                       blurRadius: 3,
        //                       spreadRadius: 1,
        //                       offset: const Offset(0, 3),
        //                       color: Colors.black.withOpacity(0.3))
        //                 ],
        //                 borderRadius: BorderRadius.all(
        //                   Radius.circular(element.selected.isFalse
        //                       ? ScreenSize.height * 0.01
        //                       : ScreenSize.height * 0.03),
        //                 ),
        //                 color: Colors.white),
        //             child: Row(
        //               children: [
        //                 Container(
        //                     margin: EdgeInsets.only(
        //                         right: ScreenSize.width * 0.035),
        //                     child: ObxValue((RxBool p0) {
        //                       return p0.value
        //                           ? Container(
        //                               width: ScreenSize.width * 0.05,
        //                               height: ScreenSize.height * 0.05,
        //                               child: element.iconTwo)
        //                           : element.icon;
        //                     }, element.selected)),
        //                 Expanded(
        //                     child: Row(
        //                   children: [
        //                     Expanded(
        //                       child: Text(
        //                         "${element.title}",
        //                         style: TextStyle(
        //                             color: element.selected.isTrue
        //                                 ? Colors.black
        //                                 : grey),
        //                       ),
        //                     ),
        //                     Container(
        //                       alignment: Alignment.center,
        //                       width: ScreenSize.width * 0.045,
        //                       height: ScreenSize.width * 0.045,
        //                       decoration: BoxDecoration(
        //                           color: green, shape: BoxShape.circle),
        //                       child: Icon(
        //                         element.selected.isTrue
        //                             ? Icons.check
        //                             : Icons.circle,
        //                         size: 12,
        //                         color: Colors.white,
        //                       ),
        //                     ),
        //                   ],
        //                 )),
        //               ],
        //             ),
        //           ),
        //           SizedBox(
        //             height: ScreenSize.height * 0.012,
        //           ),
        //         ],
        //       ),
        //     ),
        //   );
        // }).toList(),
        Stack(
          alignment: Alignment.center,
          children: [



              Obx((() => 
                            
                             

                              controller.isFinalSignUpLoading.value
                        ? Align(
                            alignment: Alignment.center,
                            child: Platform.isAndroid
                                ? CircularProgressIndicator(color: green, strokeWidth: 1,)
                                : CupertinoActivityIndicator())
                        :





            Container(
              margin: EdgeInsets.only(
                  top: ScreenSize.height * 0.05,
                  bottom: ScreenSize.height * 0.1),
              child: InkWell(
                onTap: () async {

                  signUpMap["modules"] = isSelected.toString();

                  AuthController authController = AuthController();
                  authController.finalRegister(signUpMap);


                  




                  
                },
                child: Container(
                  alignment: Alignment.center,
                  width: ScreenSize.width * 0.82,
                  height: ScreenSize.height * 0.065,
                  child: Obx(() {
                    if (widget.currentstep.value == 4) {
                      return const Text(
                        "Proceed to Web",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 18),
                      );
                    } else if (widget.currentstep.value == 3) {
                      return 

                       
                      
                      
                      
                     const Text(
                        "Submit",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 18),
                      );
                    }
                    return const Text(
                      "Next",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 18),
                    );
                  }),
                  decoration: BoxDecoration(
                      color: green,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            spreadRadius: 1.2,
                            offset: const Offset(0, 3),
                            color: Colors.black.withOpacity(0.3))
                      ],
                      borderRadius:
                          BorderRadius.circular(ScreenSize.width * 0.1)),
                ),
              ),
            ))),
          ],
        ),
      ],
    )
  
  
    
    
    );
    
     
    
    
  
  
  
  }
}






/// stage third

class _StageThreeSignUpState extends State<StageThreeSignUp> {
  TextEditingController textEditingControllerRigid = TextEditingController();
  TextEditingController textEditingControllerArtic = TextEditingController();

  TextEditingController textEditingControllerDrawbar = TextEditingController();
  AuthController controller = Get.find();

  TextEditingController textEditingControllerInterLink =
      TextEditingController();
  @override
  void didChangeDependencies() {
    UserInfo userInfo = AuthController.userInfo;
    textEditingControllerArtic.text = (userInfo.data?.fleets?.artic == null
        ? ""
        : userInfo.data?.fleets?.artic.toString() ?? "");

    textEditingControllerRigid.text = (userInfo.data?.fleets?.rigid == null)
        ? ""
        : userInfo.data?.fleets?.rigid.toString() ?? "";

    textEditingControllerDrawbar.text = (userInfo.data?.fleets?.drawbar == null)
        ? ""
        : userInfo.data?.fleets?.drawbar.toString() ?? "";

    textEditingControllerInterLink.text =
        (userInfo.data?.fleets?.interlink == null)
            ? ""
            : userInfo.data?.fleets?.interlink.toString() ?? "";
    print(userInfo.data?.toJson());

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Fleet Size",
          style: getStyle(fontSize: 18, color: Colors.black),
        ),
        SizedBox(
          height: ScreenSize.height * 0.01,
        ),
        Container(
          width: ScreenSize.width,
          height: ScreenSize.height * 0.07,
          padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 1.2,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.3))
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(ScreenSize.height * 0.01),
              ),
              color: Colors.white),
          child: Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: textEditingControllerRigid,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Rigid",
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                    border: InputBorder.none),
              )),
            ],
          ),
        ),
        SizedBox(
          height: ScreenSize.height * 0.012,
        ),
        Container(
          width: ScreenSize.width,
          height: ScreenSize.height * 0.07,
          padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 1.2,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.3))
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(ScreenSize.height * 0.01),
              ),
              color: Colors.white),
          child: Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: textEditingControllerArtic,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Artic",
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                    border: InputBorder.none),
              )),
            ],
          ),
        ),
        SizedBox(
          height: ScreenSize.height * 0.012,
        ),
        Container(
          width: ScreenSize.width,
          height: ScreenSize.height * 0.07,
          padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 1.2,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.3))
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(ScreenSize.height * 0.01),
              ),
              color: Colors.white),
          child: Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: textEditingControllerDrawbar,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Drawbar",
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                    border: InputBorder.none),
              )),
            ],
          ),
        ),
        SizedBox(
          height: ScreenSize.height * 0.012,
        ),
        Container(
          width: ScreenSize.width,
          height: ScreenSize.height * 0.07,
          padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 1.2,
                    offset: const Offset(0, 3),
                    color: Colors.black.withOpacity(0.3))
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(ScreenSize.height * 0.01),
              ),
              color: Colors.white),
          child: Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: textEditingControllerInterLink,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Interlink",
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                    border: InputBorder.none),
              )),
            ],
          ),
        ),
        SizedBox(
          height: ScreenSize.height * 0.012,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: ScreenSize.height * 0.05,
                  bottom: ScreenSize.height * 0.1),
              child: InkWell(
                onTap: () {

                  signUpMap["rigid"] = textEditingControllerRigid.text;
                  signUpMap["artic"] = textEditingControllerArtic.text;
                  signUpMap["drawbar"] = textEditingControllerDrawbar.text;
                  signUpMap["interlink"] = textEditingControllerInterLink.text;



                  if (widget.currentstep.value == 2) {
                    int a =
                        int.tryParse(textEditingControllerInterLink.text) ?? 0;
                    int b = int.tryParse(textEditingControllerRigid.text) ?? 0;
                    int c =
                        int.tryParse(textEditingControllerDrawbar.text) ?? 0;
                    int d = int.tryParse(textEditingControllerArtic.text) ?? 0;
                    controller.validateStepThree(
                        interlink: a,
                        fleetDrawbar: c,
                        fleetRigid: b,
                        fleetArtic: d);
                    widget.currentstep(3);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: ScreenSize.width * 0.82,
                  height: ScreenSize.height * 0.065,
                  child: Obx(() {
                    if (widget.currentstep.value == 4) {
                      return const Text(
                        "Proceed to Web",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 18),
                      );
                    } else if (widget.currentstep.value == 3) {
                      return const Text(
                        "Submit",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 18),
                      );
                    }
                    return const Text(
                      "Next",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 18),
                    );
                  }),
                  decoration: BoxDecoration(
                      color: green,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            spreadRadius: 1.2,
                            offset: const Offset(0, 3),
                            color: Colors.black.withOpacity(0.3))
                      ],
                      borderRadius:
                          BorderRadius.circular(ScreenSize.width * 0.1)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SignUpProgressIndicator extends StatelessWidget {
  RxInt currentstep;
  SignUpProgressIndicator({
    Key? key,
    required this.currentstep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: Row(children: [
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: green,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(ScreenSize.width * 0.03),
                    topLeft: Radius.circular(ScreenSize.width * 0.03))),
            height: ScreenSize.height * 0.005,
          )),
          Container(
            width: ScreenSize.height * 0.05,
            height: ScreenSize.height * 0.05,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(stops: const [
                0.2,
                0.3,
                0.5,
                0.7,
                0.8,
                1
              ], colors: [
                green.withOpacity(0.4),
                green.withOpacity(0.3),
                green.withOpacity(0.35),
                green.withOpacity(0.3),
                green.withOpacity(0.2),
                green.withOpacity(0.1)
              ]),
            ),
            child: Padding(
              padding: EdgeInsets.all(ScreenSize.height * 0.01),
              child: Container(
                alignment: Alignment.center,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 10,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: green,
                ),
                width: ScreenSize.height * 0.04,
                height: ScreenSize.height * 0.04,
              ),
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: currentstep.value >= 1 ? green : white,
            ),
            height: ScreenSize.height * 0.005,
          )),
          Container(
            width: ScreenSize.height * 0.05,
            height: ScreenSize.height * 0.05,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: currentstep.value >= 1
                  ? RadialGradient(stops: const [
                      0.2,
                      0.3,
                      0.5,
                      0.7,
                      0.8,
                      1
                    ], colors: [
                      green.withOpacity(0.4),
                      green.withOpacity(0.3),
                      green.withOpacity(0.35),
                      green.withOpacity(0.3),
                      green.withOpacity(0.2),
                      green.withOpacity(0.1)
                    ])
                  : null,
            ),
            child: Padding(
              padding: EdgeInsets.all(ScreenSize.height * 0.01),
              child: Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.people,
                  color: currentstep.value >= 1 ? white : grey,
                  size: 10,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentstep.value >= 1 ? green : white,
                ),
                width: ScreenSize.height * 0.04,
                height: ScreenSize.height * 0.04,
              ),
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: currentstep.value >= 2 ? green : white,
            ),
            height: ScreenSize.height * 0.005,
          )),
          Container(
            width: ScreenSize.height * 0.05,
            height: ScreenSize.height * 0.05,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: currentstep.value >= 2
                  ? RadialGradient(stops: const [
                      0.2,
                      0.3,
                      0.5,
                      0.7,
                      0.8,
                      1
                    ], colors: [
                      green.withOpacity(0.4),
                      green.withOpacity(0.3),
                      green.withOpacity(0.35),
                      green.withOpacity(0.3),
                      green.withOpacity(0.2),
                      green.withOpacity(0.1)
                    ])
                  : null,
            ),
            child: Padding(
              padding: EdgeInsets.all(ScreenSize.height * 0.01),
              child: Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.local_shipping_outlined,
                  color: currentstep.value >= 2 ? white : grey,
                  size: 10,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentstep.value >= 2 ? green : white,
                ),
                width: ScreenSize.height * 0.04,
                height: ScreenSize.height * 0.04,
              ),
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: currentstep.value >= 3 ? green : white,
            ),
            height: ScreenSize.height * 0.005,
          )),
          Container(
            width: ScreenSize.height * 0.05,
            height: ScreenSize.height * 0.05,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: currentstep.value >= 3
                  ? RadialGradient(stops: const [
                      0.2,
                      0.3,
                      0.5,
                      0.7,
                      0.8,
                      1
                    ], colors: [
                      green.withOpacity(0.4),
                      green.withOpacity(0.3),
                      green.withOpacity(0.35),
                      green.withOpacity(0.3),
                      green.withOpacity(0.2),
                      green.withOpacity(0.1)
                    ])
                  : null,
            ),
            child: Padding(
              padding: EdgeInsets.all(ScreenSize.height * 0.01),
              child: Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.contacts_outlined,
                  color: currentstep.value >= 3 ? white : grey,
                  size: 10,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentstep.value >= 3 ? green : white,
                ),
                width: ScreenSize.height * 0.04,
                height: ScreenSize.height * 0.04,
              ),
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
              color: currentstep.value >= 4 ? green : white,
            ),
            height: ScreenSize.height * 0.005,
          )),
          Container(
            width: ScreenSize.height * 0.05,
            height: ScreenSize.height * 0.05,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: currentstep.value >= 4
                  ? RadialGradient(stops: const [
                      0.2,
                      0.3,
                      0.5,
                      0.7,
                      0.8,
                      1
                    ], colors: [
                      green.withOpacity(0.4),
                      green.withOpacity(0.3),
                      green.withOpacity(0.35),
                      green.withOpacity(0.3),
                      green.withOpacity(0.2),
                      green.withOpacity(0.1)
                    ])
                  : null,
            ),
            child: Padding(
              padding: EdgeInsets.all(ScreenSize.height * 0.01),
              child: Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.done,
                  color: currentstep.value >= 4 ? white : grey,
                  size: 10,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: currentstep.value >= 4 ? green : white,
                ),
                width: ScreenSize.height * 0.04,
                height: ScreenSize.height * 0.04,
              ),
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: currentstep.value >= 4 ? green : white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(ScreenSize.width * 0.03),
                    topRight: Radius.circular(ScreenSize.width * 0.03))),
            height: ScreenSize.height * 0.005,
          )),
        ]),
      ),
    );
  }
}

getTitles(RxInt currentstep) {
  if (currentstep.value == 0) {
    return Column(
      children: [
        Text.rich(
          const TextSpan(
            text: "Bio Details",
          ),
          softWrap: false,
          style:
              getStyle(color: green, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: ScreenSize.height * 0.01,
        ),
        Text.rich(
          const TextSpan(
            text: "Please fill your bio details",
          ),
          softWrap: false,
          style: getStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
  if (currentstep.value == 1) {
    return Column(
      children: [
        Text.rich(
          const TextSpan(
            text: "Select Role",
          ),
          softWrap: false,
          style:
              getStyle(color: green, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: ScreenSize.height * 0.01,
        ),
        Text.rich(
          const TextSpan(
            text: "Please define your role",
          ),
          softWrap: false,
          style: getStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
  if (currentstep.value == 2) {
    return Column(
      children: [
        Text.rich(
          const TextSpan(
            text: "Fleet Size",
          ),
          softWrap: false,
          style:
              getStyle(color: green, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: ScreenSize.height * 0.01,
        ),
        Text.rich(
          const TextSpan(
            text: "Please enter fleet size",
          ),
          softWrap: false,
          style: getStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
  if (currentstep.value == 3) {
    return Column(
      children: [
        Text.rich(
          const TextSpan(
            text: "Module",
          ),
          softWrap: false,
          style:
              getStyle(color: green, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: ScreenSize.height * 0.01,
        ),
        Text.rich(
          const TextSpan(
            text: "Please select the modules to sign up for",
          ),
          softWrap: false,
          style: getStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
  if (currentstep.value == 4) {
    return Column(
      children: [],
    );
  }
}
