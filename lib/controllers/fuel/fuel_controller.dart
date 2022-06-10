import 'package:PrimeMetrics/controllers/BaseController.dart';
import 'package:PrimeMetrics/models/Companies.dart';
import 'package:PrimeMetrics/models/CompanyTown.dart';
import 'package:PrimeMetrics/models/driver_model.dart';
import 'package:PrimeMetrics/models/recent_trip_model.dart';
import 'package:PrimeMetrics/models/route_code_model.dart';
import 'package:dio/dio.dart' as res;
import 'package:get/get.dart';
import '../../models/CompanyCommodity.dart';
import '../../models/CompanyVehicle.dart';
import '../../models/fueling_point_model.dart';
import '../../screens/fuel_master/current_trip_origin_screen.dart';
import '../../screens/fuel_master/fuel_master_select_truck_screen.dart';
import '../../screens/fuel_master/recent_trip_screen.dart';
import '../../utils/endpoints.dart';

class FuelController extends BaseController {
  RxBool isSubmitting = false.obs;

  RxList<Vehicle> companyVehicles =
      RxList.of(CompanyVehicle().data?.toList() ?? []);

  RxList<RecentTripModel> recentTips = RxList();
  RxList<Company> manufacturerList = RxList();
  RxList<Commodity> productList = RxList();

  RxList<FuelingPointModel> fuelingPointList = RxList();
  RxList<RouteCodeModel> routeCodeListing = RxList();
  RxList<DriverModel> driversListing = RxList();
  RxList<CompanyTown> townListing = RxList();

  setLoadingsFalse() {
    isSubmitting(false);
  }

  getTrucks() async {
    try {
      isSubmitting(true);
      res.Response response = await dio.get(COMPANY_VEHICLES);
      if (response.statusCode == 200) {
        if (response.data != null) {
          companyVehicles.clear();
          companyVehicles.addAll(CompanyVehicle.fromJson(response.data).data?.toList() ?? []);
        }
      }
      print(response.data);
      print("companyVehicles.length:: ${companyVehicles.length}");
      companyVehicles.forEach((element) {
        print("${element.regNumber}");
      });
      isSubmitting(false);
      Get.to(FuelMasterSelectTruckScreen(),
          transition: Transition.rightToLeft);

    } on res.DioError catch (e, trace) {
      isSubmitting(false);
      print(trace);
    }
  }

  getRecentTrips({required int truckId}) async {
    try {
      isSubmitting(true);
      res.Response response = await dio.get(RECENT_TRIPS,queryParameters: {"vehicle_id":truckId});
      if (response.statusCode == 200) {
        if (response.data != null) {
          recentTips.clear();
          List list = response.data;
          recentTips.addAll(list.map((e) => RecentTripModel.fromJson(e)).toList());
        }
      }
      print(response.data);
      print("recentTips.length:: ${recentTips.length}");
      recentTips.forEach((element) {
        print("${element.route}");
      });
      isSubmitting(false);
      Get.to(RecentTripScreen(), transition: Transition.rightToLeft);

    } on res.DioError catch (e, trace) {
      isSubmitting(false);
      print(trace);
    }
  }

  getManufacturer() async {
    try {
      res.Response response = await dio.get(MANUFACTURER);
      if (response.statusCode == 200) {
        if (response.data != null) {
          manufacturerList.clear();
          List list = response.data;
          manufacturerList.addAll(list.map((e) => Company.fromJson(e)).toList());
        }
      }
      print(response.data);
      print("manufacturerList.length:: ${manufacturerList.length}");
      manufacturerList.forEach((element) {
        print("${element.name}");
      });
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }

  getProducts() async {
    try {
      res.Response response = await dio.get(PRODUCT);
      if (response.statusCode == 200) {
        if (response.data != null) {
          productList.clear();
          List list = response.data;
          productList.addAll(list.map((e) => Commodity.fromJson(e)).toList());
        }
      }
      print(response.data);
      print("productList.length:: ${productList.length}");
      productList.forEach((element) {
        print("${element.name}");
      });
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }

  getFuelingPoints({required int companyId}) async {
    try {
      res.Response response = await dio.get(FUELING_POINT,queryParameters: {"company_id":companyId});
      if (response.statusCode == 200) {
        if (response.data != null) {
          fuelingPointList.clear();
          List list = response.data;
          fuelingPointList.addAll(list.map((e) => FuelingPointModel.fromJson(e)).toList());
        }
      }
      print(response.data);
      print("fuelingPointList.length:: ${fuelingPointList.length}");
      fuelingPointList.forEach((element) {
        print("${element.name}");
      });
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }

  getRouteCodes() async {
    try {
      res.Response response = await dio.get(ROUTES);
      if (response.statusCode == 200) {
        if (response.data != null) {
          routeCodeListing.clear();
          List list = response.data;
          routeCodeListing.addAll(list.map((e) => RouteCodeModel.fromJson(e)).toList());
        }
      }
      print(response.data);
      print("routeCodeListing.length:: ${routeCodeListing.length}");
      routeCodeListing.forEach((element) {
        print("${element.routeCode}");
      });
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }

  addLastTripDetails({required Map<String,dynamic> data}) async {
    try {
      isSubmitting(true);
      res.Response response = await dio.post(ADD_LAST_TRIP_DETAILS,data: data);
      if(response.data['data']!=null){
        isSubmitting(false);
        Get.to(CurrentTripOriginScreen(),
            transition: Transition.rightToLeft);
      }
      print(response.data);

    } on res.DioError catch (e, trace) {
      isSubmitting(false);
      print(trace);
    }
  }

  getTowns() async {
    try {
      res.Response response = await dio.get(GET_COMPANY_TOWNS);
      if (response.statusCode == 200) {
        if (response.data != null) {
          townListing.clear();
          List list = response.data;
          townListing.addAll(list.map((e) => CompanyTown.fromJson(e)).toList());
        }
      }
      print(response.data);
      print("townListing.length:: ${townListing.length}");
      townListing.forEach((element) {
        print("${element.name}");
      });
    } on res.DioError catch (e, trace) {
      print(trace);
    }
  }

  getDrivers() async {
    try {
      res.Response response = await dio.get(DRIVER_LIST);
      if (response.statusCode == 200) {
        if (response.data != null) {
          driversListing.clear();
          List list = response.data;
          driversListing.addAll(list.map((e) => DriverModel.fromJson(e)).toList());
        }
      }
      print(response.data);
      print("driversListing.length:: ${driversListing.length}");
      driversListing.forEach((element) {
        print("${element.firstName} -- ${element.lastName}");
      });
    } on res.DioError catch (e, trace) {
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
  FuelController() : super.netwowk() {}
}
