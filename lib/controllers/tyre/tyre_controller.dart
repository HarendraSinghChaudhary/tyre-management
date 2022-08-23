// ignore_for_file: prefer_const_constructors

import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:PrimeMetrics/models/tyre_module/defect_model.dart';
import 'package:PrimeMetrics/models/tyre_module/dismount_reason.dart';
import 'package:PrimeMetrics/models/tyre_module/menufactur_model.dart';
import 'package:PrimeMetrics/models/tyre_module/puncture_repair.dart';
import 'package:PrimeMetrics/models/tyre_module/retiring_reason.dart';
import 'package:PrimeMetrics/models/tyre_module/retread_tyre_model.dart';
import 'package:PrimeMetrics/models/tyre_module/tyre_serial_number.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_inspection/inspection_home_screen.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_mount/mount_home_screen.dart';
import 'package:PrimeMetrics/screens/tyre_management/tyre_retread/post_retread_screen.dart';
import 'package:PrimeMetrics/utils/app_extensions.dart';
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
  RxBool isInspectionLoading = false.obs;
  RxBool isRetreadLoading = false.obs;
  RxBool isRetiringLoading = false.obs;
  RxBool isDismountReason = false.obs;
  RxBool isDetailLoading = false.obs;
  RxBool isVehicleStructureLoading = false.obs;


  RxList<StoreCode> storeList = RxList();
  RxList<Brand> tyreBrandList = RxList();
  RxList<TyreModel> tyreModelList = RxList();
  RxList<TyreSize> tyreSizeList = RxList();
  RxList<DismountReason> dismountReasonList = RxList();
  RxList<TyreSpecification> tyreSpecificationList = RxList();
  RxList<ThreadPattern> threadPatternList = RxList();
  RxList<Vendor> vendorList = RxList();
  RxList<VehecleStructure> vehicleStructureList = RxList();
  RxList<PunctureTyreRepairModel> punctureRepairReasonList = RxList();
  RxList<DefectModel> defectList = RxList();
  RxList<MenufactureModel> menufactureList = RxList();
  RxList<MenufactureModel> rubberTyreList = RxList();
  RxList<RetiringReasonModel> retiringReasonList = RxList();

  RxList<Tyre> tyreList = RxList();
  String tyreId = "";
  String? thread_depth;
  String? maximum_psi;
  String recomPsi = "";
  String messageunit = "";
  RxList<Vehicle> companyVehicles = RxList();
  RxList<SerialNumberModel> tyreSerialNumberList = RxList();
  RxList<SerialNumberModel> newUnmountTyreList = RxList();
  RxList<RetreadTyreModel> retreaTyreSerialNumberList = RxList();
  RxList<SerialNumberModel> getTyreForRetireList = RxList();

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
    // isSubmitting(true);
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }
    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";
    print("Tpkekmc " + token.toString() + "^");
    try {
      // isSubmitting(true);
      res.Response response = await dioo.get("/storelist");
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          storeList.clear();
          List list = response.data['data'];

          print("list: " + response.data['data'].toString());
          storeList.addAll(list.map((e) => StoreCode.fromJson(e)).toList());

          // isSubmitting(false);
        }
      }
      // isSubmitting(false);
      print("storeList tt: ${storeList.length}");
      storeList.forEach((element) {
        print("${element.storeCode} -- ${element.storeName}");
      });
    } on res.DioError catch (e, trace) {
      print(trace);
      // isSubmitting(false);
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
    isSubmitting(true);
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
        print("yesss: " + data.toString());

        if (data['status'] == true) {
          print("object is here...");
          tyreSerialNumberList.clear();
          List list = data['data'];
          tyreSerialNumberList
              .addAll(list.map((e) => SerialNumberModel.fromJson(e)).toList());

              isSubmitting(false);
              update();
        }
      }
      print("tyreSizeList : ${tyreSizeList.length}");
      tyreSerialNumberList.forEach((element) {
        print("serial number: ${element.tyre_serial_number}");
        print("tyrePsi: ${element.tyre_psi}");
        print("tyreId: ${element.id}");
      });
        isSubmitting(false);
         update();
    } on res.DioError catch (e, trace) {
      print(trace);
      isSubmitting(false);
         update();
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

  dismountReason() async {

    isDismountReason (true);


    print("cleck here 1");
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';

    try {
       isDismountReason (true);
      res.Response response = await dioo.get("/dismountResion");
      print("cleck here 2");
      if (response.statusCode == 200) {
        print("cleck here 3");
        if (response.data['data'] != null) {
          print("cleck here 4....");
          dismountReasonList.clear();
          List list = response.data['data'];
          dismountReasonList
              .addAll(list.map((e) => DismountReason.fromJson(e)).toList());
               isDismountReason (false);
        }
         isDismountReason (false);
      }
      print("dismountResion list : ${dismountReasonList.length}");
      dismountReasonList.forEach((element) {
        print("${element.dismount_reason}");
      });
       isDismountReason (false);
    } on res.DioError catch (e, trace) {
      print(trace);
       isDismountReason (false);
    }
  }

  getVehicles( String vehicle_type) async {
    print("vehicle_type: "+ vehicle_type.toString());
    var token = "";
    isSubmitting(true);
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";
    var jsonRes;

    try {
      res.Response response = await dioo.get("/company/vehicles", queryParameters: {"vehicle_type": vehicle_type});
      if (response.statusCode == 200) {
        var jesres = jsonDecode(response.data);
        if (jesres['data'] != null) {
          companyVehicles.clear();
          List list = jesres['data'];
          companyVehicles.addAll(list.map((e) => Vehicle.fromJson(e)).toList());
          print("data: "+jesres['data'].toString());

          isSubmitting(false);
          update();
        }
      }
    } on res.DioError catch (e, trace) {
      print(trace);
      isSubmitting(false);
          update();
    }
  }

  Future<bool> getVehicleStructure({required int vehicleId, required String tyre_vehicle_id, }) async {
    isVehicleStructureLoading (true);
    print("vehcle id: " + vehicleId.toString());
    print("tyre_vehicle_id: " + tyre_vehicle_id.toString());
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

      Map<String, dynamic> payload = {
      "vehicle_id": vehicleId, //boool
      "tyre_vehicle_id": tyre_vehicle_id.toString(), // string

    };

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {

         isVehicleStructureLoading(true);
      res.Response response = await dioo
          .get("/vehiclestructure", 
           queryParameters: payload
          // {"vehicle_id": vehicleId, "tyre_vehicle_id": tyre_vehicle_id.toString()}
          );
      print("response..: " + response.toString());
      if (response.statusCode == 200) {
         vehicleStructureList.clear();
        if (response.data['success'] == true) {
          vehicleStructureList.clear();
          List list = response.data['data']['tyres'];
          vehicleStructureList
              .addAll(list.map((e) => VehecleStructure.fromJson(e)).toList());
          //VehicleStructure vehicleStructure = VehicleStructure.fromJson(response.data['data']);

          isVehicleStructureLoading (false);
          // update();
          vehicleStructure =
              VehicleStructure.fromJson(response.data['data']).obs;
              // message = response.data['message'].toString().obs;
          return Future.value(true);
        } else {
          isVehicleStructureLoading (false);
          // update();
          // sfdsds
          // message = response.data['message'].toString().obs;

          show("Error", response.data['message'].toString());
          return Future.value(false);
        }
      }

      return Future.value(false);
    } on res.DioError catch (e, trace) {
      print(trace);
      return Future.value(false);
    }
  }

  rotateTyre({
    required String deploy_on,
    required String tyre_position,
    required String tyreId,
    required String tyre_axel_id,
  }) async {
    isSubmitting(true);
    Map<String, String> map = HashMap();
    map["deploy_on"] = deploy_on.toString();
    map["tyreId"] = tyreId.toString();
    map["tyre_position"] = tyre_position.toString();

    map["tyre_axel_id"] = tyre_axel_id.toString();

    print("deploy_on: " + deploy_on.toString());
    print("tyreId: " + tyreId.toString());
    print("tyre_position: " + tyre_position.toString());

    print("tyre_axel_id: " + tyre_axel_id.toString());

    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      isSubmitting(true);
      res.FormData formData = res.FormData.fromMap(map);

      // formData.files.add(MapEntry(
      //     "tyre_image",
      //     await res.MultipartFile.fromFile(
      //       file.path,
      //       filename: file.name,
      //     )));

      print("Data: " + formData.toString());
      res.Response response = await dioo.post("/rotatetyre", data: formData);
      print("Res " + response.data.toString() + "^^");
      if (response.statusCode == 200) {
        print("press here...!");
        isSubmitting(false);

        Get.snackbar("Tyre Rotated successfully", "");

        Get.offAll(TyreHomeScreen(), transition: Transition.leftToRight);
        isSubmitting(false);
      } else {
        show("Error", response.data['message']);
        isSubmitting(false);
      }
    } on res.DioError catch (e, trace) {
      isSubmitting(false);
      print(trace);
    }
  }

  tyreUnMount({
    required String deploy_on,
    required String vehicle_id,
    required String odometer,
    required String tyre_id,
    required String dismount_resion,
  }) async {
    isSubmitting(true);
    Map<String, String> map = HashMap();
    map["deploy_on"] = deploy_on.toString();
    map["tyre_id"] = tyre_id.toString();
    map["odometer"] = odometer.toString();
    map["vehicle_id"] = vehicle_id.toString();
    map["dismount_resion"] = dismount_resion.toString();

    print("deploy_on: " + deploy_on.toString());
    print("tyre_id: " + tyre_id.toString());
    print("odometer: " + odometer.toString());
    print("vehicle_id: " + vehicle_id.toString());
    print("dismount_resion: " + dismount_resion.toString());

    print("serial numner onBoarding:" + vehicle_id.toString());
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      isSubmitting(true);
      res.FormData formData = res.FormData.fromMap(map);

      // formData.files.add(MapEntry(
      //     "tyre_image",
      //     await res.MultipartFile.fromFile(
      //       file.path,
      //       filename: file.name,
      //     )));

      print("Data: " + formData.toString());
      res.Response response = await dioo.post("/tyre-unmount", data: formData);
      print("Res " + response.data.toString() + "^^");
      if (response.statusCode == 200) {
        print("press here...!");
        if (response.data['success'] == true) {
          print("press here...2");
          isSubmitting(false);

          Get.snackbar("Tyre dismounted successfully", "");

          Get.offAll(TyreHomeScreen(), transition: Transition.leftToRight);
           isSubmitting(false);
        }
      } else {
        show("Error", response.data['message']);
        isSubmitting(false);
      }
    } on res.DioError catch (e, trace) {
      isSubmitting(false);
      print(trace);
    }
  }

  tyreMount(
      {required String id,
      required String deploy_on,
      required String tyre_psi,
      required String vehicle_id,
      required String odometer,
      required String vehicle_axcel,
      required String tyre_position,
      required String tyre_status}) async {
    isSubmitting(true);
    Map<String, String> map = HashMap();
    map["tyre_id"] = id.toString();
    map["tyre_psi"] = tyre_psi.toString();
    map["deploy_on"] = deploy_on.toString();
    map["vehicle_id"] = vehicle_id.toString();
    map["odometer"] = odometer.toString();
    map["vehicle_axcel"] = vehicle_axcel.toString();
    map["tyre_position"] = tyre_position.toString();
    map["tyre_status"] = "2";

    print("id " + id.toString());
    print("tyre PSI " + tyre_psi.toString());
    print("deploy_on " + deploy_on.toString());
    print("vehicle_id " + vehicle_id.toString());
    print("odometer " + odometer.toString());
    print("vehicle_axcel " + vehicle_axcel.toString());
    print("tyre_position " + tyre_position.toString());
    print("tyre_status " + "2");

    print("serial numner onBoarding:" + vehicle_id.toString());
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      isSubmitting(true);
      res.FormData formData = res.FormData.fromMap(map);

      // formData.files.add(MapEntry(
      //     "tyre_image",
      //     await res.MultipartFile.fromFile(
      //       file.path,
      //       filename: file.name,
      //     )));

      print("Data: " + formData.toString());
      res.Response response = await dioo.post("/tyre-mount", data: formData);
      print("Res " + response.data.toString() + "^^");
      if (response.statusCode == 200) {
        print("press here...!");
        if (response.data['success'] == true) {
          print("press here...2");
          isSubmitting(false);

          Get.snackbar("Tyre mounted successfully", "");

          Get.offAll(TyreHomeScreen(), transition: Transition.leftToRight);
          isSubmitting(false);
        }
      } else {
        show("Error", response.data['message']);
        isSubmitting(false);
      }
    } on res.DioError catch (e, trace) {
      isSubmitting(false);
      print(trace);
    }
  }

  onBoardingTyre(
      {required Map<String, dynamic> data,
      required XFile file,
      required bool isNavigate,
      String? serialNumber}) async {
    print("Data: " + data.toString());

    print("file image:  " + file.toString());
    print("serial numner onBoarding:" + serialNumber.toString());
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

      print("file image" + file.name.toString());
      res.Response response =
          await dioo.post("/tyre-onboarding", data: formData);
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          print("response: " + response.data['data'].toString());

          tyreId = response.data['data']['id'].toString();
          thread_depth = response.data['data']['tread_depth'].toString();
          maximum_psi = response.data['data']['max_psi'].toString();
          recomPsi = response.data['data']['recom_psi'].toString();

          print("id: " + tyreId.toString());
          print("thread_depth: " + thread_depth.toString());
          print("maxPsi: " + maximum_psi.toString());
          isSubmitting(false);
          isNavigate != true
              ? Get.offAll(TyreHomeScreen(), transition: Transition.leftToRight)
              : Get.offAll(
                  MountHomeScreen(
                    serialNumber: serialNumber.toString(),
                  ),
                  transition: Transition.leftToRight);
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

  pressureCheckApi({
    required String tyre_id,
    required String Pressure,
  }) async {
    isSubmitting(true);
    Map<String, String> map = HashMap();
    map["tyre_id"] = tyre_id.toString();
    map["Pressure"] = Pressure.toString();

    print("tyre_id: " + tyre_id.toString());
    print("Pressure: " + Pressure.toString());

    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
     
      res.FormData formData = res.FormData.fromMap(map);

      print("Data: " + formData.toString());
      res.Response response = await dioo.post("/checkPressure", data: formData);
      print("Res " + response.data.toString() + "^^");
      if (response.statusCode == 200) {
        print("press here...!");
        if (response.data['success'] == true) {
          print("press here...2");
          isSubmitting(false);
          update();

          // Get.snackbar("Pressure check successfully", "");
          Get.snackbar(response.data['message'], "");
          // message = response.data['message'];

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
                  Text(response.data['message'],
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
              // 7302833684
       

          // Get.offAll(TyreHomeScreen(), transition: Transition.leftToRight);

        }
      } else {
        show("Error", response.data['message']);
        isSubmitting(false);
        update();
      }
    } on res.DioError catch (e, trace) {
      isSubmitting(false);
      update();
      print(trace);
    }
  }

  punctureRepairReasonApi() async {
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      res.Response response = await dioo.get("/puncturerepairlist");
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          punctureRepairReasonList.clear();
          List list = response.data['data'];
          punctureRepairReasonList.addAll(
              list.map((e) => PunctureTyreRepairModel.fromJson(e)).toList());
        }
      }
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }

  tyreInspectionApi({
    required String deploy_on,
    required String tyre_id,
    required String type,
    required String tyre_psi,
    required String is_puncture,
    required String tyre_puncture_repair_id,
    required String odometer,
  }) async {
    isInspectionLoading(true);
    Map<String, String> map = HashMap();
    map["tyre_id"] = tyre_id.toString();
    map["type"] = type.toString();
    map["tyre_psi"] = tyre_psi.toString();
    map["is_puncture"] = is_puncture.toString();
    map["tyre_puncture_repair_id"] = tyre_puncture_repair_id.toString();
    map["odometer"] = odometer.toString();
    map["deploy_on"] = deploy_on.toString();

    print("tyre_id: " + tyre_id.toString());
    print("type: " + type.toString());
    print("tyre_psi: " + tyre_psi.toString());
    print("is_puncture: " + is_puncture.toString());
    print("tyre_puncture_repair_id: " + tyre_puncture_repair_id.toString());
    print("odometer: " + odometer.toString());
    print("deploy_on: " + deploy_on.toString());

    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      isInspectionLoading(true);
      res.FormData formData = res.FormData.fromMap(map);

      print("Data: " + formData.toString());
      res.Response response =
          await dioo.post("/tyreinspection", data: formData);
      print("Res " + response.data.toString() + "^^");
      if (response.statusCode == 200) {
        print("press here...!");
        if (response.data['success'] == true) {
          print("press here...2");
          isSubmitting(false);

          // Get.snackbar("Pressure check successfully", "");
          Get.snackbar(response.data['message'], "");


         Get.offAll(InspectionHomeScreen(),
              transition: Transition.leftToRight);

          print("image: "+ response.data['message'].toString());

          // Get.(TyreHomeScreen(), transition: Transition.leftToRight);
          isInspectionLoading(false);
        }
      } else {
        show("Error", response.data['message']);
        isInspectionLoading(false);
      }
    } on res.DioError catch (e, trace) {
      isInspectionLoading(false);
      print(trace);
    }
  }

  defectApi() async {
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      res.Response response = await dioo.get("/tyredefectlist");
      if (response.statusCode == 200) {
       
        if (response.data['data'] != null) {
          defectList.clear();
          List list = response.data['data'];
          defectList.addAll(list.map((e) => DefectModel.fromJson(e)).toList());
        }
      }
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }

  detailedInspectionApi(
      {
      required int isSelect,
      required String deploy_on,
      required String type,
      required XFile file,
      required String tyre_id,
      required String tyre_serial_number,
      required String tread_depth,
      required String tyre_psi,
      required String tyre_defect,
      required String inspection_note,
      required String is_retread,
      required String defect_id,

      required String odometer,
      }) async {
    isSubmitting(true);
    isDetailLoading(true);
    Map<String, String> map = HashMap();
    map["deploy_on"] = deploy_on.toString();
    map["type"] = type.toString();
    map["tyre_id"] = tyre_id.toString();
    map["tyre_serial_number"] = tyre_serial_number.toString();
    map["tread_depth"] = tread_depth.toString();
    map["tyre_psi"] = tyre_psi.toString();
    map["tyre_defect"] = tyre_defect.toString();
    map["inspection_note"] = inspection_note.toString();
    map["is_retread"] = is_retread.toString();
    map["defect_id"] = defect_id.toString();
    map["odometer"] = odometer.toString();

    print("type " + type.toString());
    print("tyre id: "+ tyre_id.toString()); 
    print("tyre_serial_number " + tyre_serial_number.toString());
    print("tread_depth " + tread_depth.toString());
    print("tyre_psi " + tyre_psi.toString());
    print("tyre_defect " + tyre_defect.toString());
    print("inspection_note " + inspection_note.toString());
    print("is_retread " + is_retread);
    print("defect_id " + defect_id);
    print("odometer " + odometer);
    print("deploy_on " + deploy_on);

    print("serial numner :" + tyre_defect.toString());
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      isSubmitting(true);
       isDetailLoading(true);
      res.FormData formData = res.FormData.fromMap(map);

       formData.files.add(MapEntry(
          "image",
          await res.MultipartFile.fromFile(
            file.path,
            filename: file.name,
          )));

      print("file image" + file.name.toString());

      print("Data: " + formData.toString());
      res.Response response =
          await dioo.post("/tyreinspection", data: formData);
      print("Res " + response.data.toString() + "^^");
      if (response.statusCode == 200) {
        print("press here...!");
        if (response.data['success'] == true) {
          print("press here...2");
          isSubmitting(false);
           isDetailLoading(false);

          Get.snackbar(response.data['message'], "");

          isSelect == 0 ?

          Get.offAll(InspectionHomeScreen(),
              transition: Transition.leftToRight)

              :

               Get.offAll(TyreHomeScreen(),
              transition: Transition.leftToRight)
              
              ;

                isSubmitting(false);
                   isDetailLoading(false);
        }
      } else {
        show("Error", response.data['message']);
        isSubmitting(false);
           isDetailLoading(false);
      }
    } on res.DioError catch (e, trace) {
      isSubmitting(false);
         isDetailLoading(false);
      print(trace);
    }
  }

  getVehiclesbyShopApi(String id) async {

   
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
 
      res.Response response = await dioo
          .get(
        "/tyresbystoresid?store=" + id,
      )
          .then((value) {
        print("Value " + value.toString() + "^^");
        return value;
      });

      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          tyreSerialNumberList.clear();
          List list = response.data['data'];
          tyreSerialNumberList
              .addAll(list.map((e) => SerialNumberModel.fromJson(e)).toList());
              isSubmitting(false);
        }
          isSubmitting(false);
      }

      print("tyreSizeList : ${tyreSizeList.length}");
      tyreSerialNumberList.forEach((element) {
        print("serial number: ${element.tyre_serial_number}");
        print("tyrePsi: ${element.tyre_psi}");
        print("tyreId: ${element.id}");
      });
        isSubmitting(false);
    } on res.DioError catch (e, trace) {
      print(trace);
        isSubmitting(false);
    }
  }

  getRetreadTyreApi() async {
    isRetreadLoading(true);
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      res.Response response = await dioo
          .get(
        "/is_retread",
      )
          .then((value) {
        print("Value " + value.toString() + "^^");
        return value;
      });

      var jsonRes;

      if (response.statusCode == 200) {
        print("here 1");

        final JsonDecoder _decoder = new JsonDecoder();
        print("here 2");
        jsonRes = _decoder.convert(response.body.toString());
        print("here 3");

        retreaTyreSerialNumberList.clear();

        List list = jsonRes['data'];
        print("here 4");
        // print("response: "+ response.data['data'].toString());
        retreaTyreSerialNumberList
            .addAll(list.map((e) => RetreadTyreModel.fromJson(e)).toList());
        print("here 5");

        isRetreadLoading(false);
      }

      print("tyreSizeList : ${retreaTyreSerialNumberList.length}");
      retreaTyreSerialNumberList.forEach((element) {
        print("serial number: ${element.tyre_serial_number}");
        print("tyrePsi: ${element.tyre_psi}");
        print("tyreId: ${element.id}");
        print("tyreId: ${element.retreads_status}");
      });
      isRetreadLoading(false);
    } on res.DioError catch (e, trace) {
      print(trace);
      isRetreadLoading(false);
    }
  }

  preRetreadApi(
      {required String tyre_id,
      required String weight,
      required String width,
      required String thread_depth,
      required String day,
      required String month,
      required String year,
      required String vendor}) async {
    isSubmitting(true);
    Map<String, String> map = HashMap();

    map["tyre_id"] = tyre_id.toString();
    map["weight"] = weight.toString();
    map["width"] = width.toString();
    map["thread_depth"] = thread_depth.toString();
    map["day"] = day.toString();
    map["month"] = month.toString();
    map["year"] = year.toString();
    map["vendor"] = vendor.toString();

    print("tyre_id " + tyre_id.toString());
    print("width " + width.toString());
    print("thread_depth " + thread_depth.toString());
    print("day " + day.toString());
    print("month " + month.toString());
    print("year " + year);
    print("vendor " + vendor.toString());

    print("serial numner onBoarding:" + day.toString());
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      isSubmitting(true);
      res.FormData formData = res.FormData.fromMap(map);

      //  formData.files.add(MapEntry(
      //       "image",
      //       await res.MultipartFile.fromFile(
      //         file.path,
      //         filename: file.name,
      //       )));

      //   print("file image" + file.name.toString());

      var jsonRes;

      print("Data: " + formData.toString());
      res.Response response =
          await dioo.post("/Preretread_Details", data: formData);
      print("Res " + response.data.toString() + "^^");
      if (response.statusCode == 200) {
        final JsonDecoder _decoder = new JsonDecoder();
        print("here 2");
        jsonRes = _decoder.convert(response.body.toString());
        print("press here...!");
        if (jsonRes['data'] != null) {
          print("press here...2");
          isSubmitting(false);

          Get.snackbar(jsonRes['message'], "");

          Get.to(
              PostRetreadScreen(
                tyre_id: tyre_id,
              ),
              transition: Transition.leftToRight);
        }
      } else {
        show("Error", jsonRes['message']);
        isSubmitting(false);
      }
    } on res.DioError catch (e, trace) {
      isSubmitting(false);
      print(trace);
    }
  }

  postRetreadApi({
    required String tyre_id,
    required String tyre_weight,
    required String tread_depth,
    required String tyre_width,
    required String tyre_warranty_kms,
    required String cost_of_retread,
    required String retread_warranty_duration,
    required String completion_date,
    required String completion_month,
    required String completion_year,
    required String manufacturer,
    required String retread_rubber_tyre,
  }) async {
    isSubmitting(true);
    Map<String, String> map = HashMap();

    map["tyre_id"] = tyre_id.toString();
    map["tyre_weight"] = tyre_weight.toString();
    map["tread_depth"] = tread_depth.toString();
    map["tyre_width"] = tyre_width.toString();
    map["tyre_warranty_kms"] = tyre_warranty_kms.toString();
    map["cost_of_retread"] = cost_of_retread.toString();
    map["retread_warranty_duration"] = retread_warranty_duration.toString();
    map["completion_date"] = completion_date.toString();
    map["completion_month"] = completion_month.toString();
    map["completion_year"] = completion_year.toString();
    map["manufacturer"] = manufacturer.toString();
    map["retread_rubber_tyre"] = retread_rubber_tyre.toString();

    print("tyre_id " + tyre_id.toString());
    print("tyre_weight " + tyre_weight.toString());
    print("thread_depth " + thread_depth.toString());
    print("tyre_width " + tyre_width.toString());
    print("tyre_warranty_kms " + tyre_warranty_kms.toString());
    print("cost_of_retread " + cost_of_retread);
    print("retread_warranty_duration " + retread_warranty_duration.toString());
    print("completion_date " + completion_date.toString());
    print("completion_month " + completion_month.toString());
    print("completion_year " + completion_year.toString());
    print("manufacturer " + manufacturer.toString());
    print("retread_rubber_tyre " + retread_rubber_tyre.toString());

    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      isSubmitting(true);
      res.FormData formData = res.FormData.fromMap(map);

     

      var jsonRes;

      print("Data: " + formData.toString());
      res.Response response =
          await dioo.post("/postRetread_details", data: formData);
      print("Res " + response.data.toString() + "^^");
      if (response.statusCode == 200) {
        final JsonDecoder _decoder = new JsonDecoder();
        print("here 2");
        jsonRes = _decoder.convert(response.body.toString());
        print("press here...!");
        if (jsonRes['data'] != null) {
          print("press here...2");
          isSubmitting(false);

          Get.snackbar(jsonRes['message'], "");

          Get.offAll(TyreHomeScreen(), transition: Transition.leftToRight);
          isSubmitting(false);
        }
      } else {
        show("Error", jsonRes['message']);
        isSubmitting(false);
      }
    } on res.DioError catch (e, trace) {
      isSubmitting(false);
      print(trace);
    }
  }

  menufactureApi() async {
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      res.Response response = await dioo
          .get(
        "/get_manufacturer",
      )
          .then((value) {
        print("Value " + value.toString() + "^^");
        return value;
      });

      var jsonRes;

      if (response.statusCode == 200) {
        print("here 1");

        final JsonDecoder _decoder = new JsonDecoder();
        print("here 2");
        jsonRes = _decoder.convert(response.body.toString());
        print("here 3");

        menufactureList.clear();

        List list = jsonRes['data'];
        print("here 4");
        // print("response: "+ response.data['data'].toString());
        menufactureList
            .addAll(list.map((e) => MenufactureModel.fromJson(e)).toList());
        print("here 5");
      }

      print("tyreSizeList : ${retreaTyreSerialNumberList.length}");
      menufactureList.forEach((element) {
        print("serial number: ${element.name}");
        print("tyrePsi: ${element.company_reg_number}");
        print("tyreId: ${element.id}");
      });
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }




    rubberTyreApi() async {
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      res.Response response = await dioo
          .get(
        "/get_retread_rubber_tyre",
      )
          .then((value) {
        print("Value " + value.toString() + "^^");
        return value;
      });

      var jsonRes;

      if (response.statusCode == 200) {
        print("here 1");

        final JsonDecoder _decoder = new JsonDecoder();
        print("here 2");
        jsonRes = _decoder.convert(response.body.toString());
        print("here 3");

        rubberTyreList.clear();

        List list = jsonRes['data'];
        print("here 4");
        // print("response: "+ response.data['data'].toString());
        rubberTyreList
            .addAll(list.map((e) => MenufactureModel.fromJson(e)).toList());
        print("here 5");
      }

      print("tyreSizeList : ${rubberTyreList.length}");
      rubberTyreList.forEach((element) {
        print("serial number: ${element.name}");
        print("tyrePsi: ${element.company_reg_number}");
        print("tyreId: ${element.id}");
      });
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }





      retiringReasonApi() async {
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      res.Response response = await dioo
          .get(
        "/get_retiring_reason",
      )
          .then((value) {
        print("Value " + value.toString() + "^^");
        return value;
      });

      var jsonRes;

      if (response.statusCode == 200) {
        print("here 1");

        
        print("here 2");
        jsonRes = jsonDecode(response.body.toString());
        print("here 3");

        retiringReasonList.clear();

        List list = jsonRes['data'];
        print("here 4");
        // print("response: "+ response.data['data'].toString());
        retiringReasonList
            .addAll(list.map((e) => RetiringReasonModel.fromJson(e)).toList());
        print("here 5");
      }

      print("retiringReasonList : ${retiringReasonList.length}");
      retiringReasonList.forEach((element) {
   
        print("reason: ${element.reason}");
        print("tyreId: ${element.id}");
      });
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }





    tyreRetiringApi({
    required String tyre_retiring,
   
  }) async {
    isSubmitting(true);
    Map<String, String> map = HashMap();
    map["tyre_retiring"] = tyre_retiring.toString();


    print("tyre_retiring: " + tyre_retiring.toString());
   

    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      isSubmitting(true);
      res.FormData formData = res.FormData.fromMap(map);

    

      print("Data: " + formData.toString());
      res.Response response = await dioo.post("/retiring_tyre", data: formData);
      print("Res " + response.data.toString() + "^^");
      if (response.statusCode == 200) {
        print("press here...!");
        isSubmitting(false);

        Get.snackbar(response.data['message'], "");

        Get.offAll(TyreHomeScreen(), transition: Transition.leftToRight);
         isSubmitting(false);
      } else {
        show("Error", response.data['message']);
        isSubmitting(false);
      }
    } on res.DioError catch (e, trace) {
      isSubmitting(false);
      print(trace);
    }
  }




  getNewUnmountTyreApi() async {
   
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      res.Response response = await dioo
          .get(
        "/get_unmount_tyre",
      )
          .then((value) {
        print("Value " + value.toString() + "^^");
        return value;
      });

      if (response.statusCode == 200) {
        print("object is here...1");
        var data = jsonDecode(response.data);
        print("yesss: " + data.toString());

        if (data['status'] == true) {
          print("object is here...");
          newUnmountTyreList.clear();
          List list = data['data'];
          newUnmountTyreList
              .addAll(list.map((e) => SerialNumberModel.fromJson(e)).toList());

           
        }
      }
      print("tyreSizeList : ${tyreSizeList.length}");
      tyreSerialNumberList.forEach((element) {
        print("serial number: ${element.tyre_serial_number}");
        print("tyrePsi: ${element.tyre_psi}");
        print("tyreId: ${element.id}");
      });
       
    
    } on res.DioError catch (e, trace) {
      print(trace);
    
    }
  }


  
    getTyreForRetiringApi() async {
    isSubmitting(true);
    var token = "";
    if (getUserInfo() != null) {
      token = getUserInfo()!.data!.token.toString();
    }

    dioo.options.headers['content-Type'] = 'application/json';
    dioo.options.headers["Authorization"] = "Bearer ${token}";

    try {
      res.Response response = await dioo
          .get(
        "/get_tyre_for_retire",
      )
          .then((value) {
        print("Value " + value.toString() + "^^");
        return value;
      });

      if (response.statusCode == 200) {
        print("object is here...1");
        var data = jsonDecode(response.data);
        print("yesss: " + data.toString());

        if (data['status'] == true) {
          print("object is here...");
          getTyreForRetireList.clear();
          List list = data['data'];
          getTyreForRetireList
              .addAll(list.map((e) => SerialNumberModel.fromJson(e)).toList());

              isSubmitting(false);
              update();
        }
      }
      print("tyreSizeList : ${tyreSizeList.length}");
      getTyreForRetireList.forEach((element) {
        print("serial number: ${element.tyre_serial_number}");
        print("tyrePsi: ${element.tyre_psi}");
        print("tyreId: ${element.id}");
      });
        isSubmitting(false);
         update();
    } on res.DioError catch (e, trace) {
      print(trace);
      isSubmitting(false);
         update();
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
