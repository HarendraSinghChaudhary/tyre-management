// import 'package:PrimeMetrics/utils/colors.dart';
// import 'package:PrimeMetrics/utils/screen_size.dart';
// import 'package:flutter/material.dart';




// class MyWidget extends StatefulWidget {
//   const MyWidget({Key? key}) : super(key: key);

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColors,

//       body:       
//       SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Container(
//           color: primaryColors,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 100,
//                 alignment: Alignment.bottomLeft,
//                 padding: EdgeInsets.only(left: 20),
//                 child: Row(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Get.offAll(const TyreHomeScreen());
//                       },
//                       child: CircleAvatar(
//                         backgroundColor: green,
//                         radius: 18,
//                         child: Icon(
//                           Icons.arrow_back,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 20.0,
//                     ),
//                     Text(
//                       "Select Rim",
//                       style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black,
//                           fontSize: 22),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 30),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 35,
//                       height: 8,
//                       decoration: BoxDecoration(
//                           color: green,
//                           borderRadius: BorderRadius.circular(30)),
//                     ),
//                     SizedBox(
//                       width: 2,
//                     ),
//                     Container(
//                       width: 15,
//                       height: 8,
//                       decoration: BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.circular(30)),
//                     ),
//                     SizedBox(
//                       width: 2,
//                     ),
//                     Container(
//                       width: 15,
//                       height: 8,
//                       decoration: BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.circular(30)),
//                     ),
//                     SizedBox(
//                       width: 2,
//                     ),
//                     Container(
//                       width: 15,
//                       height: 8,
//                       decoration: BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.circular(30)),
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(30),
//                 child: SingleChildScrollView(
//                   physics: NeverScrollableScrollPhysics(),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SearchableDropdown(
//                         enabled: true,
//                         hintText: "Select Rim (Optional)",
//                         listItems:
//                             ['Rim 1', 'Rim 2'].map((e) => "${e}").toList(),
//                         onChanged: (value) {},
//                         searchFieldProps: TextFieldProps(
//                           decoration: InputDecoration(
//                             suffixIcon: Icon(
//                               Icons.keyboard_arrow_down,
//                               color: Colors.black,
//                             ),
//                             hintText: "Search",
//                             border: InputBorder.none,
//                           ),
//                         ),
//                         withIcon: false,
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       ShadowTextField(
//                         controller: pressureController,
//                         maxLine: 1,
//                         keyboardType: TextInputType.number,
//                         hintText: "Pressure of inflation (PSI)",
//                         onChanged: (value) {
//                           // data.remove('tyre_psi');
//                           // data.putIfAbsent(
//                           //     'tyre_psi', () => pressureController.text);
//                         },
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),

//                       widget.serialNumber.toString().trim() == "null"
//                           ? Container(
//                               padding: EdgeInsets.all(0),
//                               child: SingleChildScrollView(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     ObxValue((RxList list) {
//                                       return SearchableDropdown(
//                                         withIcon: false,
//                                         enabled: true,
//                                         hintText: "Select serial number",
//                                         listItems: tyreController
//                                             .newUnmountTyreList
//                                             .map((e) =>
//                                                 "${e.tyre_serial_number}")
//                                             .toList(),
//                                         onChanged: (value) {
//                                           id = tyreController
//                                               .newUnmountTyreList
//                                               .firstWhere((element) =>
//                                                   value ==
//                                                   element.tyre_serial_number
//                                                       .toString())
//                                               .id
//                                               .toString();

//                                           storeCodeSerialNumber = tyreController
//                                               .newUnmountTyreList
//                                               .firstWhere((element) =>
//                                                   value ==
//                                                   element.tyre_serial_number
//                                                       .toString())
//                                               .tyre_serial_number
//                                               .toString();

//                                           tyre_psi = tyreController
//                                               .newUnmountTyreList
//                                               .firstWhere((element) =>
//                                                   value ==
//                                                   element.tyre_serial_number)
//                                               .tyre_psi
//                                               .toString();

//                                           tread_depth = tyreController
//                                               .newUnmountTyreList
//                                               .firstWhere((element) =>
//                                                   value ==
//                                                   element.tyre_serial_number)
//                                               .tread_depth
//                                               .toString();

//                                           max_psi = tyreController
//                                               .newUnmountTyreList
//                                               .firstWhere((element) =>
//                                                   value ==
//                                                   element.tyre_serial_number)
//                                               .max_psi
//                                               .toString();

//                                           recom_psi = tyreController
//                                               .newUnmountTyreList
//                                               .firstWhere((element) =>
//                                                   value ==
//                                                   element.tyre_serial_number)
//                                               .recom_psi
//                                               .toString();

//                                           print("tyrePsi: " +
//                                               tyre_psi.toString());
//                                           print("tread depth: " +
//                                               tread_depth.toString());
//                                           print("tyre id: " + id.toString());

//                                           // widget.data.remove('store');
//                                           // widget.data.putIfAbsent('store', () => storeCodeSerialNumber);
//                                         },
//                                         searchFieldProps: TextFieldProps(
//                                           decoration: InputDecoration(
//                                             suffixIcon: Icon(
//                                               Icons.keyboard_arrow_down,
//                                               color: Colors.black,
//                                             ),
//                                             hintText: "Search",
//                                             border: InputBorder.none,
//                                           ),
//                                         ),
//                                       );
//                                     }, tyreController.tyreSerialNumberList),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           : Container(),
//                       // : Container() ,

//                       // ignore: unrelated_type_equality_checks
//                       widget.serialNumber.toString().trim() != "null"
//                           ? ShadowTextField(
//                               enabled: false,
//                               maxLine: 1,
//                               keyboardType: TextInputType.number,
//                               controller: serialNumberController,
//                               hintText: "Tyre Serial Number",
//                               onChanged: (value) {
//                                 // data.remove('tyre_psi');
//                                 // data.putIfAbsent('tyre_psi', () => pressureController.text);
//                               },
//                             )
//                           : Container(),
//                       // : Container(),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Text(
//                         "Deploy On",
//                         style: TextStyle(color: Colors.black, fontSize: 18),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.only(bottom: 8),
//                             child: Material(
//                               elevation: 4,
//                               borderRadius: BorderRadius.circular(10),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                       padding: EdgeInsets.only(left: 10),
//                                       child: Image.asset(images[index])),
//                                   Expanded(
//                                     child: RadioListTile(
//                                       controlAffinity:
//                                           ListTileControlAffinity.trailing,
//                                       activeColor: green,
//                                       value: index,
//                                       groupValue: value,
//                                       onChanged: (index) {
//                                         setState(
//                                           () {
//                                             value = int.parse(index.toString());
//                                             print("value: " + value.toString());
//                                           },
//                                         );
//                                       },
//                                       title: Text(deployOn[index] ?? ""),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                         itemCount: deployOn.length,
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
      
      
      
      
     
      
      
      
    
      
      
//       bottomNavigationBar: Container(
//         height: 100,
//         alignment: Alignment.center,
//         child: InkWell(
//           splashColor: Colors.transparent,
//           onTap: () async {
//             tyreController.getVehicles(value.toString());

//             recordedPsi = pressureController.text.toString();
//             data.remove('deploy_on');
//             data.putIfAbsent('deploy_on', () => deployOn[value]);
//             if (pressureController.text.isNotEmpty &&
//                 serialNumberController.text.isNotEmpty) {
//               _toggleFirst();
//             } else {
//               show("Error", "All Fields are required");
//             }
//           },
//           child: Container(
//             alignment: Alignment.center,
//             width: ScreenSize.width * 0.82,
//             height: ScreenSize.height * 0.065,
//             child: Text(
//               "Next",
//               style: TextStyle(
//                   fontWeight: FontWeight.normal,
//                   color: Colors.white,
//                   fontSize: 18),
//             ),
//             decoration: BoxDecoration(
//               color: green,
//               boxShadow: [
//                 BoxShadow(
//                   blurRadius: 3,
//                   spreadRadius: 1.2,
//                   offset: Offset(0, 3),
//                   color: Colors.black.withOpacity(0.3),
//                 )
//               ],
//               borderRadius: BorderRadius.circular(
//                 ScreenSize.width * 0.1,
//               ),
//             ),
//           ),
//         ),
//       ),
    
    

//     );
    
//   }
// }