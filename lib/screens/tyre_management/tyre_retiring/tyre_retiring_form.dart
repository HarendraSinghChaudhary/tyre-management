import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/screen_size.dart';
import '../../fuel_master/fuel_master_widgets/searchable_dropdown.dart';
import '../../fuel_master/fuel_master_widgets/shadow_textfield.dart';

class TyreRetiringForm extends StatelessWidget {
  const TyreRetiringForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController serialNumberController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchableDropdown(
          enabled: true,
          hintText: "Select Tyre",
          listItems:
          ['Tyre 1', 'Tyre 2'].map((e) => "${e}").toList(),
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
          hintText: "Type the Serial Number",
          controller: serialNumberController,
          onChanged: (value) {},
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
          enabled: true,
          hintText: "Reason for Retiring",
          listItems:
          ['Reason 1', 'Reason 2'].map((e) => "${e}").toList(),
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
          height: 20,
        ),
      ],
    );
  }
}
