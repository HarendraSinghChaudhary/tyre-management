import 'package:flutter/material.dart';

import '../../../utils/screen_size.dart';

class ShadowTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? icon;
  final Function(String?)? onChanged;
  final double? width;
  final int? maxLine;
  final bool? enabled;
  final TextInputType? keyboardType;

  const ShadowTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.onChanged,
    this.width,
    this.maxLine,
    this.enabled=true,
    this.keyboardType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? ScreenSize.width,
      /*height: ScreenSize.height * 0.07,*/
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
        color: Colors.white,
      ),
      child: Row(
        children: [
          icon != null
              ? Container(
                  margin: EdgeInsets.only(right: ScreenSize.width * 0.035),
                  child: icon,
                )
              : Container(height: 0),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  border: InputBorder.none),
              onChanged: onChanged,
              maxLines: maxLine,
              enabled: enabled,
            ),
          ),
        ],
      ),
    );
  }
}
