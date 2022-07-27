import 'package:PrimeMetrics/controllers/tyre/tyre_controller.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';
import '../../fuel_master/fuel_master_widgets/searchable_dropdown.dart';
import '../../fuel_master/fuel_master_widgets/shadow_textfield.dart';

class TyreRetiringForm extends StatefulWidget {
  const TyreRetiringForm({Key? key, required this.datamodel}) : super(key: key);
  final TyreRetiringFormModel datamodel ; 

  @override
  State<TyreRetiringForm> createState() => _TyreRetiringFormState();
}

class _TyreRetiringFormState extends State<TyreRetiringForm> {


TyreRetiringFormModel tyreRetiringFormModel = TyreRetiringFormModel();

  TyreController tyreController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tyreRetiringFormModel = widget.datamodel;

    tyreController.getTyreSerialNumberApi();
    tyreController.retiringReasonApi();
  }

  @override
  Widget build(BuildContext context) {
    // final TextEditingController serialNumberController = TextEditingController();

 return

    Obx((() => 
    
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchableDropdown(
          enabled: true,
          hintText: "Select Tyre",
          listItems: ['Tyre 1', 'Tyre 2'].map((e) => "${e}").toList(),
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
        SearchableDropdown(
          withIcon: false,
          enabled: true,
          hintText: "Select serial number",
          listItems: tyreController.tyreSerialNumberList
              .map((e) => "${e.tyre_serial_number}")
              .toList(),
          onChanged: (value) {
           tyreRetiringFormModel.id = tyreController.tyreSerialNumberList
                .firstWhere(
                    (element) => value == element.tyre_serial_number.toString())
                .id
                .toString();

            tyreRetiringFormModel.storeCodeSerialNumber = tyreController.tyreSerialNumberList
                .firstWhere(
                    (element) => value == element.tyre_serial_number.toString())
                .tyre_serial_number
                .toString();

            tyreRetiringFormModel.tyre_psi = tyreController.tyreSerialNumberList
                .firstWhere((element) => value == element.tyre_serial_number)
                .tyre_psi
                .toString();

           tyreRetiringFormModel. tread_depth = tyreController.tyreSerialNumberList
                .firstWhere((element) => value == element.tyre_serial_number)
                .tread_depth
                .toString();

            tyreRetiringFormModel.max_psi = tyreController.tyreSerialNumberList
                .firstWhere((element) => value == element.tyre_serial_number)
                .max_psi
                .toString();

           tyreRetiringFormModel. recom_psi = tyreController.tyreSerialNumberList
                .firstWhere((element) => value == element.tyre_serial_number)
                .recom_psi
                .toString();

            print("tyrePsi: " + tyreRetiringFormModel.tyre_psi.toString());
            print("tread depth: " + tyreRetiringFormModel.tread_depth.toString());
            print("tyre id: " + tyreRetiringFormModel.id.toString());

            // widget.data.remove('store');
            // widget.data.putIfAbsent('store', () => storeCodeSerialNumber);
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
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "Enter the serial on the side of the corresponsing tyre to ensure they match.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        SearchableDropdown(
          withIcon: false,
          enabled: true,
          hintText: "Reason for Retiring",
          listItems: tyreController.retiringReasonList
              .map((e) => "${e.reason}")
              .toList(),
          onChanged: (value) {
            tyreRetiringFormModel.reason = tyreController.retiringReasonList
                .firstWhere(
                    (element) => value == element.reason.toString())
                .reason
                .toString();

            print("tyrePsi: " + tyreRetiringFormModel.reason.toString());
            //  print("tread depth: "+tread_depth.toString());
            //  print("tyre id: "+id.toString());

            // widget.data.remove('store');
            // widget.data.putIfAbsent('store', () => storeCodeSerialNumber);
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
        ),
    
        SizedBox(
          height: 20,
        ),
      ],
    )
 
 
    
    
    ));

    
  }
}


class TyreRetiringFormModel {

   int vehicleId = 0;
  String? tyre_psi;
  String? tread_depth;
  String? regNumber;
  String? axle;
  String? positionaxle;
  String? totalUnit;
  String? storeCodeSerialNumber;
  String? retreads_status;
  String? max_psi;
  String? recom_psi;
  String? reasonId;

  String? reason;

  // ignore: prefer_final_fields
  String _1LO = "1LO";

  String? id;

}