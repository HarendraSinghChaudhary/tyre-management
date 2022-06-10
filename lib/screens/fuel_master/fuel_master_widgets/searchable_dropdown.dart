import 'package:PrimeMetrics/models/dropdown_item_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SearchableDropdown extends StatelessWidget {
  final List<String>? listItems;
  final Function(String?)? onChanged;
  final Widget? prefixIcon;
  final TextFieldProps? searchFieldProps;
  final String hintText;
  final bool enabled;
  final bool withIcon;

  const SearchableDropdown(
      {Key? key,
      required this.listItems,
      this.onChanged,
      this.prefixIcon,
      this.searchFieldProps,
      required this.hintText,
      required this.enabled,this.withIcon=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: DropdownSearch<String>(
        enabled: enabled,
        dropdownSearchDecoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
          prefixIcon: prefixIcon,
          contentPadding: withIcon?EdgeInsets.all(0):EdgeInsets.symmetric(horizontal: 10),
        ),
        dropDownButton: Icon(Icons.keyboard_arrow_down),
        mode: Mode.MENU,
        showSearchBox: true,
        items: listItems?.map((e) => e).toList()??[],
        positionCallback: (RenderBox popupButtonObject, RenderBox overlay) {
          final buttonSize = popupButtonObject.size;
          final size = overlay.size;
          final offset = popupButtonObject.localToGlobal(Offset.zero);
          return RelativeRect.fromLTRB(offset.dx, offset.dy, offset.dx, 0);
        },
        onChanged: onChanged,
        popupElevation: 5,
        searchFieldProps: searchFieldProps,
        popupShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        popupItemBuilder: (context, value, bool) {
          print("Value $value");
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$value"),
                Divider(
                  thickness: 1,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
