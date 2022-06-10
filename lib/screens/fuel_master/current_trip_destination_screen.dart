import 'package:PrimeMetrics/controllers/fuel/fuel_controller.dart';
import 'package:PrimeMetrics/models/dropdown_item_model.dart';
import 'package:PrimeMetrics/screens/fuel_master/fuel_master_widgets/shadow_textfield.dart';
import 'package:PrimeMetrics/screens/fuel_master/trip_summary_screen.dart';
import 'package:PrimeMetrics/utils/images.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';
import '../../utils/screen_size.dart';
import '../../utils/toast.dart';
import 'fuel_master_widgets/searchable_dropdown.dart';

class CurrentTripDestinationScreen extends StatefulWidget {
  const CurrentTripDestinationScreen({Key? key}) : super(key: key);

  @override
  _CurrentTripDestinationScreenState createState() =>
      _CurrentTripDestinationScreenState();
}

class _CurrentTripDestinationScreenState
    extends State<CurrentTripDestinationScreen> {
  TextEditingController destinationController = TextEditingController();
  TextEditingController productController = TextEditingController();
  TextEditingController manufactureController = TextEditingController();

  late int destinationId,productId,manufacturerId;
  FuelController fuelController=Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    destinationId=0;
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
                    "Current Trip Destination",
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
                        "Please enter the details of the Destination",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenSize.width * 0.04,
                      ),
                      child: Text(
                        'In case of adding multiple destinations please add destinations in order. System will ask you if you want to add more destinations after this screen.',
                      ),
                    ),
                    /*ShadowTextField(
                      hintText: "Destination",
                      controller: destinationController,
                      icon: Image.asset(trip_destination,
                          width: ScreenSize.width * 0.04),
                    ),*/
                    Obx((){
                      return SearchableDropdown(
                        enabled: true,
                        hintText: "Destination",
                        listItems: fuelController.townListing.map((element) => element.name??"").toList(),
                        onChanged: (value) {
                          destinationId = fuelController.townListing.firstWhere((element) => element.name == value).id ?? 0;
                          print("destinationId $destinationId :: value $value");
                        },
                        prefixIcon: Image.asset(
                          trip_destination,
                          width: ScreenSize.width * 0.04,
                          height: ScreenSize.width * 0.04,
                        ),
                        searchFieldProps: TextFieldProps(
                          decoration: InputDecoration(
                            prefixIcon: Image.asset(
                              trip_destination,
                              width: ScreenSize.width * 0.04,
                              height: ScreenSize.width * 0.04,
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
            if(destinationId!=0 && productId!=0 && manufacturerId!=0){
              showGeneralDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.9),
                // Background color
                barrierDismissible: false,
                transitionDuration: Duration(milliseconds: 400),
                pageBuilder: (_, __, ___) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Is it Final Destination?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.off(TripSummaryScreen(),
                              transition: Transition.rightToLeft);
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
                                    color: Colors.black.withOpacity(0.3))
                              ],
                              borderRadius:
                              BorderRadius.circular(ScreenSize.width * 0.1)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: ScreenSize.width * 0.82,
                          height: ScreenSize.height * 0.065,
                          child: Text(
                            "No, Add More",
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
                                    color: Colors.black.withOpacity(0.3))
                              ],
                              borderRadius:
                              BorderRadius.circular(ScreenSize.width * 0.1)),
                        ),
                      ),
                    ],
                  );
                },
              );
            }else{
              show('Field required',"All Fields are required ");
            }
            //Get.to(TripSummaryScreen(), transition: Transition.rightToLeft);
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
                borderRadius: BorderRadius.circular(ScreenSize.width * 0.1)),
          ),
        ),
      ),
    );
  }
}
