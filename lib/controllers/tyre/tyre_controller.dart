// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:PrimeMetrics/models/tyre_module/tyre_serial_number.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_mount/mount_home_screen.dart';
import 'package:flutter/material.dart';

import 'package:PrimeMetrics/models/CompanyVehicle.dart';
import 'package:PrimeMetrics/models/tyre_module/store_code.dart';
import 'package:PrimeMetrics/models/tyre_module/thread_pattern.dart';
import 'package:PrimeMetrics/models/tyre_module/tyre_model.dart';
import 'package:PrimeMetrics/models/tyre_module/tyre_size.dart';
import 'package:PrimeMetrics/models/tyre_module/tyre_specification.dart';
import 'package:PrimeMetrics/utils/endpoints.dart';
import 'package:PrimeMetrics/utils/store.dart';
import 'package:PrimeMetrics/utils/toast.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as res;
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import '../../models/tyre_module/brand.dart';
import '../../models/tyre_module/tyre.dart';
import '../../models/tyre_module/vehicle_structure.dart';
import '../../models/tyre_module/vendor.dart';
import '../../screens/tyre_management/tyre_home_screen.dart';
import '../BaseController.dart';
import 'package:dio/src/multipart_file.dart' as multiFile;
import 'package:http/http.dart' as http;

class TyreController extends BaseController {
  RxBool isSubmitting = false.obs;

  RxList<StoreCode> storeList = RxList();
  RxList<Brand> tyreBrandList = RxList();
  RxList<TyreModel> tyreModelList = RxList();
  RxList<TyreSize> tyreSizeList = RxList();
  RxList<TyreSpecification> tyreSpecificationList = RxList();
  RxList<ThreadPattern> threadPatternList = RxList();
  RxList<Vendor> vendorList = RxList();

  RxList<Tyre> tyreList = RxList();
  RxList<Vehicle> companyVehicles = RxList();
  RxList<SerialNumberModel> tyreSerialNumberList = RxList();

  Rx<VehicleStructure?>? vehicleStructure;
  final dioo = Dio(BaseOptions(
    connectTimeout: 30000,
    baseUrl: baseUrl,
    responseType: ResponseType.json,
    contentType: ContentType.json.toString(),
  ));

  setLoadingsFalse() {
    isSubmitting(false);
  }

  getStoreList() async {
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }
    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";
    print("Tpkekmc " + token.toString() + "^");
    try {
      res.Response response = await dioo.get("/storelist");
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          storeList.clear();
          List list = response.data['data'];

          print("list: " + response.data['data'].toString());
          storeList.addAll(list.map((e) => StoreCode.fromJson(e)).toList());
        }
      }
      print("storeList tt: ${storeList.length}");
      storeList.forEach((element) {
        print("${element.storeCode} -- ${element.storeName}");
      });
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }

  getTyreBrandList() async {
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      res.Response response = await dioo.get("/brandlist");
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          tyreBrandList.clear();
          List list = response.data['data'];
          tyreBrandList.addAll(list.map((e) => Brand.fromJson(e)).toList());
        }
      }
      print("tyreBrandList : ${tyreBrandList.length}");
      tyreBrandList.forEach((element) {
        print("${element.brandName}");
      });
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }

  getTyreModelList() async {
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      res.Response response = await dioo.get("/modellist");
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          tyreModelList.clear();
          List list = response.data['data'];
          tyreModelList.addAll(list.map((e) => TyreModel.fromJson(e)).toList());
        }
      }
      print("tyreModelList : ${tyreModelList.length}");
      tyreModelList.forEach((element) {
        print("${element.modelName}");
      });
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }

  getTyreSizeList() async {
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      res.Response response = await dioo
          .get(
        "/sizelist",
      )
          .then((value) {
        print("Value " + value.toString() + "^^");
        return value;
      });

      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          tyreSizeList.clear();
          List list = response.data['data'];
          tyreSizeList.addAll(list.map((e) => TyreSize.fromJson(e)).toList());
        }
      }
      print("tyreSizeList : ${tyreSizeList.length}");
      tyreSizeList.forEach((element) {
        print("${element.sizeName}");
      });
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }

    getTyreSerialNumberApi() async {
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      res.Response response = await dioo
          .get(
        "/get_tyre",
      )
          .then((value) {
        print("Value " + value.toString() + "^^");
        return value;
      });

      if (response.statusCode == 200) {
           print("object is here...1");
        var data = jsonDecode(response.data);
        print("yesss: "+data.toString());


        if (data['status'] == true) {

          


          print("object is here...");
          tyreSerialNumberList.clear();
          List list = data['data'];
         tyreSerialNumberList.addAll(list.map((e) => SerialNumberModel.fromJson(e)).toList());
        }
      }
      print("tyreSizeList : ${tyreSizeList.length}");
      tyreSerialNumberList.forEach((element) {
        print("${element.tyre_serial_number}");
      });
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }

  getTyreSpecificationList() async {
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      res.Response response = await dioo.get("/tyrespecificationlist");
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          tyreSpecificationList.clear();
          List list = response.data['data'];
          tyreSpecificationList
              .addAll(list.map((e) => TyreSpecification.fromJson(e)).toList());
        }
      }
      print("tyreSpecificationList : ${tyreSpecificationList.length}");
      tyreSpecificationList.forEach((element) {
        print("${element.specifictionName}");
      });
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }

  getThreadPatternList() async {
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      res.Response response = await dioo.get("/treadPatternlist");
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          threadPatternList.clear();
          List list = response.data['data'];
          threadPatternList
              .addAll(list.map((e) => ThreadPattern.fromJson(e)).toList());
        }
      }
      print("threadPatternList : ${threadPatternList.length}");
      threadPatternList.forEach((element) {
        print("${element.treadPatternName}");
      });
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }

  getTyreVendorList() async {
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      res.Response response = await dioo.get("/vendorlist");
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          vendorList.clear();
          List list = response.data['data'];
          vendorList.addAll(list.map((e) => Vendor.fromJson(e)).toList());
        }
      }
      print("vendorList : ${vendorList.length}");
      vendorList.forEach((element) {
        print("${element.vendorName}");
      });
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }

  getTyreList() async {
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      res.Response response = await dioo.get("/tyrelist");
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          tyreList.clear();
          List list = response.data['data'];
          tyreList.addAll(list.map((e) => Tyre.fromJson(e)).toList());
        }
      }
      print("tyreList : ${tyreList.length}");
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }

  getVehicles() async {
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      res.Response response = await dioo.get("/vehicle");
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          companyVehicles.clear();
          List list = response.data['data'];
          companyVehicles.addAll(list.map((e) => Vehicle.fromJson(e)).toList());
        }
      }
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }

  Future<bool> getVehicleStructure({required int vehicleId}) async {
    print("vehcle id: "+vehicleId.toString());
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      res.Response response = await dioo
          .get("/vehiclestructure", queryParameters: {"vehicle_id": vehicleId});
          print("response..: "+response.toString());
      if (response.statusCode == 200) {
        if (response.data['success']) {
          //VehicleStructure vehicleStructure = VehicleStructure.fromJson(response.data['data']);
          vehicleStructure =
              VehicleStructure.fromJson(response.data['data']).obs;
          return Future.value(true);
        } else {
          show("Error", response.data['message']);
          return Future.value(false);
        }
      }
      return Future.value(false);
    } on res.DioError catch (e, trace) {
      print(trace);
      return Future.value(false);
    }
  }

  onBoardingTyre(
      {required Map<String, dynamic> data, required XFile file, required bool isNavigate,String? serialNumber}) async {
    print("Data " + data.toString());
    print("file image:  " + file.toString());
     print("serial numner onBoarding:" +serialNumber.toString());
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      isSubmitting(true);
      res.FormData formData = res.FormData.fromMap(data);

      formData.files.add(MapEntry(
          "tyre_image",
          await res.MultipartFile.fromFile(
            file.path,
            filename: file.name,
          )));
      res.Response response =
          await dioo.post("/tyre-onboarding", data: formData);
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          isSubmitting(false);
          isNavigate != true ?
          Get.offAll(TyreHomeScreen(), transition: Transition.leftToRight) :
          Get.offAll(MountHomeScreen(serialNumber: serialNumber.toString(),), transition: Transition.leftToRight);
          Get.defaultDialog(
              contentPadding: EdgeInsets.all(10),
              title: "",

              // titleStyle: TextStyle(color: Colors.black, fontSize: 17),

              content: Column(
                children: [
                  Lottie.asset(
                    "assets/images/loading.json",
                    width: 200,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Thank you for onboarding tyre",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: 140,
                    height: 40,
                    child: FlatButton(
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Ok",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ));
        }
      } else {
        show("Error", response.data['message']);
      }
    } on res.DioError catch (e, trace) {
      isSubmitting(false);
      print(trace);
    }
  }

  @override
  void onError() {
    setLoadingsFalse();

    // TODO: implement onError
    super.onError();
  }

  @override
  TyreController() : super.netwowk() {}
}
