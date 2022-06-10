import 'package:PrimeMetrics/controllers/fuel/fuel_controller.dart';
import 'package:PrimeMetrics/screens/fuel_master/current_trip_destination_screen.dart';
import 'package:PrimeMetrics/screens/fuel_master/fuel_master_widgets/shadow_textfield.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../models/CompanyTown.dart';
import '../../models/dropdown_item_model.dart';
import '../../utils/colors.dart';
import '../../utils/screen_size.dart';
import '../../utils/toast.dart';
import 'fuel_master_widgets/searchable_dropdown.dart';

class CurrentTripOriginScreen extends StatefulWidget {
  const CurrentTripOriginScreen({Key? key}) : super(key: key);

  @override
  _CurrentTripOriginScreenState createState() =>
      _CurrentTripOriginScreenState();
}

class _CurrentTripOriginScreenState extends State<CurrentTripOriginScreen> {
  TextEditingController originController = TextEditingController();
  TextEditingController productController = TextEditingController();
  TextEditingController manufactureController = TextEditingController();


  late int originId,productId,manufacturerId;
  FuelController fuelController=Get.find();
  List<CompanyTown> towns=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    originId=0;
    productId=0;
    manufacturerId=0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    "Current Trip Origin",
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
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenSize.width * 0.04,
                      ),
                      child: Text(
                        'Please enter the details of the Trip Origin',
                      ),
                    ),
                    /*ShadowTextField(
                      hintText: "Origin",
                      controller: originController,
                      icon: Image.asset(trip_origin,
                          width: ScreenSize.width * 0.04),
                    ),*/
                    Obx((){
                      return SearchableDropdown(
                        enabled: true,
                        hintText: "Origin",
                        listItems: fuelController.townListing.map((element) => element.name??"").toList(),
                        onChanged: (value) {
                          originId = fuelController.townListing.firstWhere((element) => element.name == value).id ?? 0;
                          print("originId $originId :: originValue $value");
                        },
                        prefixIcon: Image.asset(
                          trip_origin,
                          width: ScreenSize.width * 0.04,
                        ),
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            prefixIcon: Image.asset(
                              trip_origin,
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
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    /*ShadowTextField(
                      hintText: "Product",
                      controller: productController,
                      icon: Image.asset(trip_product,
                          width: ScreenSize.width * 0.04),
                    ),*/
                    Obx((){
                      return SearchableDropdown(
                        enabled: true,
                        hintText: "Product",
                        listItems: fuelController.productList.map((element) => element.name??"").toList(),
                        onChanged: (value) {
                          print("value $value");
                          productId = fuelController.productList.firstWhere((element) => element.name == value).id ?? 0;
                          print("productId $productId :: value $value");
                        },
                        prefixIcon: Image.asset(
                          trip_product,
                          width: ScreenSize.width * 0.04,
                        ),
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            prefixIcon: Image.asset(
                              trip_product,
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
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    /*ShadowTextField(
                      hintText: "Manufacturer",
                      controller: manufactureController,
                      icon: Image.asset(trip_manufacturer,
                          width: ScreenSize.width * 0.04),
                    ),*/
                    Obx((){
                      return SearchableDropdown(
                        enabled: true,
                        hintText: "Manufacturer",
                        listItems: fuelController.manufacturerList.map((element) => element.name??"").toList(),
                        onChanged: (value) {
                          manufacturerId = fuelController.manufacturerList.firstWhere((element) => element.name == value).id ?? 0;
                          print("manufacturerId $manufacturerId :: value $value");
                        },
                        prefixIcon: Image.asset(
                          trip_manufacturer,
                          width: ScreenSize.width * 0.04,
                        ),
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            prefixIcon: Image.asset(
                              trip_manufacturer,
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
                    }),
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
            if(originId!=0 && productId!=0 && manufacturerId!=0){
              Get.to(CurrentTripDestinationScreen(),
                  transition: Transition.rightToLeft);
            }else{
              show('Field required',"All Fields are required ");
              /*Get.showSnackbar(GetSnackBar(
                backgroundColor: greenText,
                isDismissible: true,
                snackPosition: SnackPosition.TOP,
                duration: Duration(seconds: 3),
                title: "Field required",
                message: "All Fields are required ",
              ));*/
            }
          },
          child: Container(
            alignment: Alignment.center,
            width: ScreenSize.width * 0.82,
            height: ScreenSize.height * 0.065,
            child: const Text(
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
                borderRadius: BorderRadius.circular(
                    ScreenSize.width * 0.1)),
          ),
        ),
      ),
    );
  }
}
