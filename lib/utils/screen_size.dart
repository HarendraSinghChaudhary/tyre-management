import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ScreenSize extends StatelessWidget {
  static late double width=Get.width;
  static late double height=Get.height;
  static late Orientation orientation;
  Widget? child;
  Widget? protraitScreen;
  Widget? landScapeScreen;
  ScreenSize({
    Key? key,
    this.child,
    this.landScapeScreen,
    this.protraitScreen,
  }) : super(key: key) {
    assert(
        (child != null || protraitScreen != null || landScapeScreen != null));
  }
  @override
  Widget build(BuildContext context) {
    // MediaQueryData mediaQuery = MediaQuery.of(context);
  
    // ScreenSize.width = Get.width;
    // ScreenSize.height = Get.width;
    // orientation = mediaQuery.orientation;

    // switch (orientation) {
    //   case Orientation.portrait:
    //     ScreenSize.width = mediaQuery.size.width;
    //     ScreenSize.height = mediaQuery.size.height;
    //     if (protraitScreen != null) {
    //       return protraitScreen!;
    //     }

    //     break;
    //   case Orientation.landscape:
    //     ScreenSize.width = mediaQuery.size.height;
    //     ScreenSize.height = mediaQuery.size.width;
    //     if (landScapeScreen != null) {
    //       return landScapeScreen!;
    //     }

    //     break;
    // }
    return child!;
  }
}
