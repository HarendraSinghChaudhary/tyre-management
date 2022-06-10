import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'colors.dart';

show(String title, String message, {int durationInSeconds = 3,Widget? titleText,Widget? messageText,Widget ?icon}) {
  Get.showSnackbar(GetSnackBar(
    icon: icon,
    backgroundColor: greenText,
    titleText: titleText,
    messageText: messageText,
    isDismissible: true,
    snackPosition: SnackPosition.TOP,
    duration: Duration(seconds: durationInSeconds),
    title: title,
    message: message,
  ));
}
