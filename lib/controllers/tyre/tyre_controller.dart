import 'package:PrimeMetrics/models/CompanyVehicle.dart';
import 'package:PrimeMetrics/models/tyre_module/store_code.dart';
import 'package:PrimeMetrics/models/tyre_module/thread_pattern.dart';
import 'package:PrimeMetrics/models/tyre_module/tyre_model.dart';
import 'package:PrimeMetrics/models/tyre_module/tyre_size.dart';
import 'package:PrimeMetrics/models/tyre_module/tyre_specification.dart';
import 'package:PrimeMetrics/utils/endpoints.dart';
import 'package:PrimeMetrics/utils/toast.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as res;
import 'package:image_picker/image_picker.dart';
import '../../models/tyre_module/brand.dart';
import '../../models/tyre_module/tyre.dart';
import '../../models/tyre_module/vehicle_structure.dart';
import '../../models/tyre_module/vendor.dart';
import '../../screens/tyre_management/tyre_home_screen.dart';
import '../BaseController.dart';
import 'package:dio/src/multipart_file.dart' as multiFile;

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

  Rx<VehicleStructure?>? vehicleStructure;

  setLoadingsFalse() {
    isSubmitting(false);
  }

  getStoreList() async {
    try {
      res.Response response = await dio.get(STORE_LIST);
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          storeList.clear();
          List list = response.data['data'];
          storeList.addAll(list.map((e) => StoreCode.fromJson(e)).toList());
        }
      }
      print("storeList : ${storeList.length}");
      storeList.forEach((element) {
        print("${element.storeCode} -- ${element.storeName}");
      });
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }

  getTyreBrandList() async {
    try {
      res.Response response = await dio.get(TYRE_BRAND_LIST);
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
    try {
      res.Response response = await dio.get(TYRE_MODEL_LIST);
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
    try {
      res.Response response = await dio.get(TYRE_SIZE_LIST);
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

  getTyreSpecificationList() async {
    try {
      res.Response response = await dio.get(TYRE_SPECIFICATION_LIST);
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          tyreSpecificationList.clear();
          List list = response.data['data'];
          tyreSpecificationList.addAll(list.map((e) => TyreSpecification.fromJson(e)).toList());
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
    try {
      res.Response response = await dio.get(THREAD_PATTERN_LIST);
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          threadPatternList.clear();
          List list = response.data['data'];
          threadPatternList.addAll(list.map((e) => ThreadPattern.fromJson(e)).toList());
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
    try {
      res.Response response = await dio.get(TYRE_VENDOR);
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
    try {
      res.Response response = await dio.get(TYRE_LIST);
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
    try {
      res.Response response = await dio.get(COMPANY_VEHICLES);
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
    try {
      res.Response response = await dio.get(VEHICLE_STRUCTURE,queryParameters: {"vehicle_id":vehicleId});
      if (response.statusCode == 200) {
        if (response.data['success']) {
          //VehicleStructure vehicleStructure = VehicleStructure.fromJson(response.data['data']);
          vehicleStructure = VehicleStructure.fromJson(response.data['data']).obs;
          return Future.value(true);
        }else{
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

  onBoardingTyre({required Map<String,dynamic> data,required XFile file}) async {
    try {
      isSubmitting(true);
      res.FormData formData = res.FormData.fromMap(data);
      /*formData.files.add(MapEntry("tyre_image",await res.MultipartFile.fromFile(
        file.path,
        filename: file.name,
      )));*/
      res.Response response = await dio.post(TYRE_ONBOARDING,data: formData);
      if(response.statusCode==200){
        if(response.data['data']!=null){
          isSubmitting(false);
          Get.offAll(TyreHomeScreen(),
              transition: Transition.leftToRight);
        }
      }else{
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