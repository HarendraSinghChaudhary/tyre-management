// ignore_for_file: prefer_const_constructors

import 'package:PrimeMetrics/controllers/tyre/tyre_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';
import '../../fuel_master/fuel_master_widgets/searchable_dropdown.dart';
import '../tyre_home_screen.dart';

class SelectStoreCodeScreen extends StatefulWidget {
  Map<String,dynamic> data;
  XFile file;
  SelectStoreCodeScreen({Key? key, required this.data,required this.file}) : super(key: key);

  @override
  _SelectStoreCodeScreenState createState() => _SelectStoreCodeScreenState();
}

class _SelectStoreCodeScreenState extends State<SelectStoreCodeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TyreController tyreController = Get.find();
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
                    ObxValue((RxList list){
                      return  SearchableDropdown(
                        withIcon: false,
                        enabled: true,
                        hintText: "Store Code",
                        listItems: tyreController.storeList.map((e) => "${e.storeCode}").toList(),
                        onChanged: (value) {
                          storeCode = tyreController.storeList.firstWhere((element) => value == element.storeCode).id??0;
                          widget.data.remove('store');
                          widget.data.putIfAbsent('store', () => storeCode);
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
                      );
                    }, tyreController.storeList),
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
            if(storeCode!=0){
              tyreController.onBoardingTyre(data: widget.data,file: widget.file, isNavigate: false,  );
            }else{
              Get.showSnackbar(GetSnackBar(
                backgroundColor: greenText,
                isDismissible: true,
                snackPosition: SnackPosition.TOP,
                duration: Duration(seconds: 3),
                title: "Error",
                message: "Please select store code",
              ));
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
                "Add To Store",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                    fontSize: 18),
              );
            }, tyreController.isSubmitting),
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
