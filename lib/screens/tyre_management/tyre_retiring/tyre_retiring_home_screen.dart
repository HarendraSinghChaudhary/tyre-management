import 'package:PrimeMetrics/controllers/tyre/tyre_controller.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_retiring/tyre_retiring_confirmation_screen.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_retiring/tyre_retiring_form.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';
import '../../fuel_master/fuel_master_widgets/searchable_dropdown.dart';
import '../../fuel_master/fuel_master_widgets/shadow_textfield.dart';

class TyreRetiringHomeScreen extends StatefulWidget {
  const TyreRetiringHomeScreen({Key? key}) : super(key: key);

  @override
  _TyreRetiringHomeScreenState createState() => _TyreRetiringHomeScreenState();
}

class _TyreRetiringHomeScreenState extends State<TyreRetiringHomeScreen> with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<TyreRetiringFormModel> tyres= [];
   TyreController tyreController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tyres.add(TyreRetiringFormModel());
    //  tyreController.getTyreSerialNumberApi();
    // tyreController.retiringReasonApi();
  }

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
                    "Tyre Retiring",
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
                    ListView.builder(
                      addAutomaticKeepAlives: true,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: tyres.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            index>0 ?Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "Tyre ${index+1}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ) : Container(height: 0,),
                           

                            TyreRetiringForm(datamodel:  tyres[index],),
                            
                            SizedBox(height: 30,),
                          ],
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: ScreenSize.width*0.5,
                          alignment: Alignment.center,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            onTap: () async {
                              setState(() {
                                tyres.add(
                                  TyreRetiringFormModel()
                                  
                                );
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: ScreenSize.width * 0.82,
                              height: ScreenSize.height * 0.065,
                              child: Text(
                                "Add New",
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
                      ],
                    )
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

             if (tyres.first.id.toString() != "null") {

                        

                       Get.to(TyreRetiringConfirmationScreen(
              data: tyres
            ), transition: Transition.rightToLeft);

                        }else {
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
                      color: Colors.black.withOpacity(0.3))
                ],
                borderRadius: BorderRadius.circular(ScreenSize.width * 0.1)),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
