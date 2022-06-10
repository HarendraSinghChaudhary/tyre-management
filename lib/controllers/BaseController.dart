import 'package:PrimeMetrics/controllers/auth/auth_controller.dart';
import 'package:PrimeMetrics/models/user_info.dart';
import 'package:PrimeMetrics/utils/app_extensions.dart';
import 'package:PrimeMetrics/utils/constants.dart';
import 'package:PrimeMetrics/utils/endpoints.dart';
import 'package:PrimeMetrics/utils/store.dart';
import 'package:PrimeMetrics/utils/style.dart';
import 'package:dio/dio.dart' as D;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../models/user_info.dart' as U;
import '../../utils/toast.dart';

class BaseController extends GetxController {
  D.Dio dio = D.Dio();
  Position? position;
  void onError() {
    print("error");
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      show("Error", "Please enable location for better services");
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        show("Error", "The app required location permission granted");
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      show("Location Disabled",
          "The app required location permission please go to location settings to enable",
          durationInSeconds: 20,
          icon: Icon(Icons.location_disabled),
          messageText: Container(
            child: Text.rich(TextSpan(
                text:
                    "The app required location permission please go to location  ",
                style: getStyle(color: Colors.white),
                children: [
                  TextSpan(
                      text: " settings ",
                      style: getStyle(color: Colors.red),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Geolocator.openLocationSettings();
                          Get.closeCurrentSnackbar();
                        }),
                  TextSpan(text: " to enable ")
                ])),
          ));
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    position = await Geolocator.getCurrentPosition();
    print(position?.toJson());
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return position;
  }

  BaseController.netwowk() {
    determinePosition();
    var hasToken = false;
    var token;
    if (getUserInfo() != null) {
      token = getUserInfo()?.data?.token;
    } else {
      print("no user");
    }
    dio.interceptors
        .add(D.InterceptorsWrapper(onRequest: (options, handler) async {
      var headers = {
        'accept': "application/json",
        "Content-Type": "application/json",
        "Accept": "application/json",
        "User-Agent": "PostmanRuntime/7.29.0",
        "Cache-Control": "no-cache",
        "Postman-Token": "38c764b1-1bbd-4d93-825b-2d52516e7da3",

        // "Host": "primemetrics.herokuapp.com",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
      };
      headers.addIf(token != null, "Authorization", "Bearer $token");
      options.headers = headers;
      options.validateStatus = (status) => status! < 500;

      // Do something before request is sent
      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onResponse: (response, handler) async {
      if (response.statusCode == 401) {
        print("token expired");

        if (getUserInfo() != null) {
          token = getUserInfo()?.data?.token;
        } else {
          print("no user");
        }
        try {
          print({"Authorization": "Bearer $token"});
          var r = await dio.get(REFRESH_TOKEN,
              options: D.Options(headers: {"Authorization": "Bearer $token"}));
          print("here");
          if (r.statusCode == 200) {
            UserInfo? info = getUserInfo();
            if (info != null) {
              info.data?.token = r.data["accessToken"];
              print("new token :${r.data["accessToken"]}");

              await setUser(info);
              AuthController.userInfo = info;
              var secondresponse = await dio.request(
                  response.requestOptions.path,
                  options: D.Options(
                      method: response.requestOptions.method,
                      headers: response.requestOptions.headers),
                  data: response.requestOptions.data);
              return handler.next(secondresponse);
              //reponse.requestOptions.m
            }
          } else {
            print(r.body);
          }
        } on D.DioError catch (e, status) {
          print(status);
        }
      }
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }, onError: (D.DioError e, error) {
      show("Error Connecting", e.message);
      print(e.requestOptions.headers);
      onError();
      //throw e;
      // Do something with response error
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
    }));
  }
}
