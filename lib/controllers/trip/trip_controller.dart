import 'dart:async';
import 'dart:io';

import 'package:PrimeMetrics/controllers/BaseController.dart';
import 'package:PrimeMetrics/models/Companies.dart';
import 'package:PrimeMetrics/models/CompanyCommodity.dart';
import 'package:PrimeMetrics/models/CompanyVehicle.dart';
import 'package:PrimeMetrics/models/Trip.dart';
import 'package:PrimeMetrics/screens/dashboard/dashboard.dart';
import 'package:PrimeMetrics/screens/dashboard/dashboarrd.dart';
import 'package:PrimeMetrics/utils/endpoints.dart';
import 'package:PrimeMetrics/utils/toast.dart';
import 'package:dio/dio.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart' as G;

import '../../models/CompanyTown.dart';
import '../../screens/driver/confirm_end_trip.dart';

class TripController extends BaseController {
  RxBool loadingTrip = RxBool(false);
  RxBool loadingTripSammary = RxBool(false);
  RxBool addingDestination = RxBool(false);
  TripData? tripData;
  RxBool hasActiveTrip = RxBool(false);
  RxList<CompanyTown> companyTowns = List<CompanyTown>.empty().obs;
  RxList<Vehicle> companyVehicles =
      RxList.of(CompanyVehicle().data?.toList() ?? []);
  RxList<Commodity> companyCommodity =
      RxList.of(CompanyCommodity().data?.toList() ?? []);

  RxList<Company> companies = List<Company>.empty(growable: true).obs;
  RxBool creatingTrip = false.obs;
  TripController() : super.netwowk();
  void onError() {
    loadingTrip(false);
    creatingTrip(false);
  }

  loadActiveTrip() async {
    loadingTrip(true);
    loadingTripSammary(true);
    try {
      Response response = await dio.get(ACTIVE_TRIP_SAMMARY);
      print(response.statusCode);
      loadingTripSammary(false);
      if (response.statusCode == 201) {
        tripData = TripData.fromJson(response.data);
        if (tripData?.data?.signatureImg == null) {
          hasActiveTrip(true);
        } else {
          hasActiveTrip(false);
        }
      } else if (response.statusCode == 404) {
        hasActiveTrip(false);
        tripData = null;
      }
      update();
      print(response.data);
      print("something");
    } on DioError catch (e, trace) {
      print(trace);
    } on Exception catch (e, trace) {
      print(trace);
    }

    loadingTrip(false);
  }

  addStopDestination(
    String town_id,
    String odometerValue,
    String fuelObc,
    String customerName,
    XFile file,
  ) async {
    if (tripData == null) {
      show("Failed", "Your trip not available");

      return;
    }

    FormData formData = FormData.fromMap({
      "trip_id": tripData?.data?.id,
      "town_id": town_id,
      "odometer": odometerValue,
      "fuel_obc": fuelObc,
      "lat": position?.latitude ?? 0,
      "long": position?.longitude ?? 0,
      "customer_name": customerName,
      "derivery_note":
          await MultipartFile.fromFile(file.path, filename: file.name),
    });

    print("creating trip ${ADD_DESTINATION}");
    print(file.path);
    print(tripData?.data?.id);
    // if (addingDestination.isTrue) {
    //   return;
    // }
    addingDestination(true);
    try {
      Response response = await dio.post(ADD_DESTINATION, data: formData,
          onSendProgress: (a, b) {
        print({a, b});
      });

      addingDestination(false);
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 201) {
        tripData = TripData.fromJson(response.data);
        if (tripData?.data?.signatureImg == null) {
          hasActiveTrip(true);
        } else {
          hasActiveTrip(false);
        }
        update();
        G.Get.back();
        show("Success", "New Destination created");
      } else if (response.statusCode == 201) {
        show("Failed", "Failed to create destination ");

        print("something went wrong");
      } else {
        show("Failed", "Something went Wrong");
      }
    } on DioError catch (e, trace) {
      print(trace);
    }
  }

  getCompanyTowns() async {
    try {
      Response response = await dio.get(GET_COMPANY_TOWNS);
      if (response.statusCode == 200) {
        if (response.data != null) {
          companyTowns.clear();
          companyTowns = (response.data as List)
              .map((e) => CompanyTown.fromJson(e))
              .toList()
              .obs;
        }
      }
      print(response.data);
      print("something");
    } on DioError catch (e, trace) {
      print(trace);
    } on Exception catch (e, trace) {
      print(trace);
    }
  }

  getCompanyVehicles() async {
    try {
      Response response = await dio.get(COMPANY_VEHICLES);
      if (response.statusCode == 200) {
        if (response.data != null) {
          companyVehicles.clear();
          companyVehicles.addAll(
              CompanyVehicle.fromJson(response.data).data?.toList() ?? []);
        }
      }
      print(response.data);
      print("something");
    } on DioError catch (e, trace) {
      print(trace);
    } on Exception catch (e, trace) {
      print(trace);
    }
  }

  getCompanyCommodies() async {
    try {
      Response response = await dio.get(COMPANY_PRODUCTS);
      if (response.statusCode == 200) {
        if (response.data != null) {
          companyCommodity.clear();

          companyCommodity.addAll(
              CompanyCommodity.fromJson(response.data).data?.toList() ?? []);
        }
      }
      print(response.data);
      print("something");
    } on DioError catch (e, trace) {
      print(trace);
    } on Exception catch (e, trace) {
      print(trace);
    }
  }

  getWithCommodies(int commodity_id) async {
    try {
      Response response = await dio.get(PRODUCT_COMPANIES,
          queryParameters: {"product_id": commodity_id});
      if (response.statusCode == 200) {
        if (response.data != null) {
          companies.clear();
          companies = Companies.fromJson(response.data).data?.obs ??
              RxList<Company>.empty(growable: true);
        }
      }
      print(response.data);
      print("something");
    } on DioError catch (e, trace) {
      print(trace);
    } on Exception catch (e, trace) {
      print(trace);
    }
  }

  void loadingPoint(
      {required String ordometer,
      required String city_id,
      required String obc,
      required String commodity_id,
      required String manufacture_id,
      required XFile file}) async {
    creatingTrip(true);

    FormData formData = FormData.fromMap({
      "town_id": city_id,
      "odometer": ordometer,
      "trip_id": tripData?.data?.id,
      "fuel_obc": obc,
      "lat": position?.latitude ?? 0,
      "long": position?.longitude ?? 0,
      "goods_id": commodity_id,
      "manufacture_id": manufacture_id,
      "derivery_note":
          await MultipartFile.fromFile(file.path, filename: file.name),
    });

    print("Add loading point ${ADD_LOADING_POINT}");
    print(file.path);
    Response response = await dio.post(ADD_LOADING_POINT, data: formData,
        onSendProgress: (a, b) {
      print({a, b});
    });

    creatingTrip(false);
    print(response.data);
    print(response.statusCode);
    if (response.statusCode == 201) {
      tripData = TripData.fromJson(response.data);
      if (tripData?.data?.signatureImg == null) {
        hasActiveTrip(true);
      } else {
        hasActiveTrip(false);
      }
      update();
      G.Get.back();
      show("Success", "Loading point recorded");
    } else if (response.statusCode == 201) {
      show("Failed", "Your trip has already started");

      print("something went wrong");
    } else {}
  }

  void starTrip(
      {required String ordometer,
      required String city_id,
      required String vehicle_id,
      required String obc,
      required String commodity_id,
      required String manufacture_id,
      required XFile file}) async {
    creatingTrip(true);
    print(vehicle_id);
    FormData formData = FormData.fromMap({
      "town_id": city_id,
      "odometer": ordometer,
      "vehicle_id": vehicle_id,
      "fuel_obc": obc,
      "lat": position?.latitude ?? 0,
      "long": position?.longitude ?? 0,
      "goods_id": commodity_id,
      "manufacture_id": manufacture_id,
      "derivery_note":
          await MultipartFile.fromFile(file.path, filename: file.name),
    });

    print("creating trip ${START_TRIP}");
    print(file.path);
    Response response =
        await dio.post(START_TRIP, data: formData, onSendProgress: (a, b) {
      print({a, b});
    });

    creatingTrip(false);
    print(response.data);
    print(response.statusCode);
    if (response.statusCode == 201) {
      tripData = TripData.fromJson(response.data);
      if (tripData?.data?.signatureImg == null) {
        hasActiveTrip(true);
      } else {
        hasActiveTrip(false);
      }
      update();
      G.Get.back();
      show("Success", "A new trip has being engaged");
    } else if (response.statusCode == 201) {
      show("Failed", "Your trip has already started");

      print("something went wrong");
    }
  }

  void midTripRefuel(
      {required String fuel_quantity,
      required String city_id,
      required String station_name,
      required String obc,
      required XFile file}) async {
    creatingTrip(true);

    FormData formData = FormData.fromMap({
      "town_id": city_id,
      "trip_id": tripData?.data?.id,
      "fuel_quantity": fuel_quantity,
      "fuel_obc": obc,
      "lat": position?.latitude ?? 0,
      "long": position?.longitude ?? 0,
      "fuel_station": station_name,
      "derivery_note":
          await MultipartFile.fromFile(file.path, filename: file.name),
    });

    print("creating trip ${START_TRIP}");
    print(file.path);
    Response response = await dio.post(ADD_REFUEL_POINT, data: formData,
        onSendProgress: (a, b) {
      print({a, b});
    });

    creatingTrip(false);
    print(response.data);
    print(response.statusCode);
    if (response.statusCode == 201) {
      tripData = TripData.fromJson(response.data);
      if (tripData?.data?.signatureImg == null) {
        hasActiveTrip(true);
      } else {
        hasActiveTrip(false);
      }
      update();
      G.Get.back();
      show("Success", "A new vehicle refill recorded");
    } else if (response.statusCode == 409) {
      show("Trip Ended", "Trip Just ended");

      print("something went wrong");
    }
  }

  void endTrip({
    required String odometer,
    required String city_id,
    required String obc,
  }) async {
    creatingTrip(true);
    print("lat ${position?.latitude ?? 0}");
    FormData formData = FormData.fromMap({
      "town_id": city_id,
      "trip_id": tripData?.data?.id,
      "odometer": odometer,
      "fuel_obc": obc,
      // "lat": 10,
      // "long": 10,
      "lat": position?.latitude ?? 0,
      "long": position?.longitude ?? 0,
    });

    print("creat   ing trip ${END_TRIP}");

    Response response =
        await dio.post(END_TRIP, data: formData, onSendProgress: (a, b) {
      //print({a, b});
    });

    creatingTrip(false);
    print(response.data);
    print(response.statusCode);
    if (response.statusCode == 201) {
      tripData = TripData.fromJson(response.data);
      if (tripData?.data?.signatureImg == null) {
        hasActiveTrip(true);
      } else {
        hasActiveTrip(false);
      }
      update();
      //   show("Success", "Please confirm the trip");
      G.Get.off(ConfirmEndTrip());
    } else if (response.statusCode == 409) {
      show("Trip Ended", "Trip Just ended");

      print("something went wrong");
    } else {
      show("Error", "Something went wrong");
    }
  }

  confirmTrip(List<int> image) async {
    creatingTrip(true);
    print("trip_id ${tripData?.toJson()}");
    FormData formData = FormData.fromMap({
      "lat": position?.latitude ?? 0,
      "long": position?.longitude ?? 0,
      "trip_id": tripData?.data?.id,
      "signature": await MultipartFile.fromBytes(image,
          filename: DateTime.now().toString() + ".png"),
    });

    print("creat   ing trip ${CLOSE_TRIP}");

    Response response =
        await dio.post(CLOSE_TRIP, data: formData, onSendProgress: (a, b) {
      print({a, b});
    });

    creatingTrip(false);
    print(response.data);
    print(response.statusCode);
    if (response.statusCode == 201) {
      tripData = TripData.fromJson(response.data);
      if (tripData?.data?.signatureImg == null) {
        hasActiveTrip(true);
      } else {
        hasActiveTrip(false);
      }
      tripData == null;
      update();
      G.Get.off(MainDashboard());
      show("Voila", "You have comleted the trip");
    } else if (response.statusCode == 404) {
      tripData == null;
      update();
      // G.Get.off(MainDashboard());
    } else if (response.statusCode == 409) {
      show("Trip Ended", "Trip Just ended");

      print("something went wrong");
    } else {
      show("Error", "Something went wrong");
      // G.Get.off(MainDashboard());
    }
  }

  Sammary performSammary() {
    Sammary sammary = Sammary();
    if (tripData != null) {
      Trip? data = tripData?.data;
      if (data != null) {
        sammary.route = data.route;
         sammary.duration= data.duration;
        var refuelcount = (data.intermediary ?? List<Intermediary>.empty())
            .where((Intermediary element) => element.serviceName == "Refuel");
        sammary.numberofRefuels = refuelcount.length;
        var totalfuel = refuelcount.fold<int>(0, (int previousValue, element) {
          return previousValue +
              (int.tryParse(element.fuelQuantity ?? "0")?.toInt() ?? 0);
        });
        sammary.fuel_cost = data.closingFuel.toString();

        var lastodometer = (data.intermediary ?? List<Intermediary>.empty())
            .reduce((current, next) =>
                ((int.tryParse(current.odometer ?? "0") ?? 0) >
                        (int.tryParse(next.odometer ?? "0") ?? 0))
                    ? current
                    : next)
            .odometer
            ?.toInt();

        var firstOdometer = data.startOdometer?.toInt();
        sammary.distance = (lastodometer - firstOdometer).toString();
      }
    }
    return sammary;
  }
}

class Sammary {
  String? route;
  String? distance;
  String? duration;
  String? fuel_cost;
  int? numberofRefuels;
}

extension ToInt on String {
  toInt() {
    return int.tryParse(this);
  }
}
