import 'dart:async';
import 'dart:convert';

import 'package:PrimeMetrics/controllers/BaseController.dart';
import 'package:PrimeMetrics/models/SocialLogin.dart';
import 'package:PrimeMetrics/screens/dashboard/dashboard.dart';
import 'package:PrimeMetrics/screens/fuel_master/fuel_master_landing_screen.dart';
import 'package:PrimeMetrics/utils/app_extensions.dart';
import 'package:PrimeMetrics/utils/screen_size.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as D;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_info.dart' as U;

import '../../screens/tyre_management/tyre_home_screen.dart';
import '../../utils/constants.dart';
import '../../utils/endpoints.dart';
import '../../utils/store.dart';
import '../../utils/toast.dart';

class AuthController extends BaseController {
  RxBool sendingEmail = false.obs;
  RxBool veryfyingOtp = false.obs;
  RxString timeEllapsedForOtp = 60.toString().obs;
  RxBool activateResend = false.obs;
  RxBool submittingOtp = false.obs;
  RxBool loggingIn = false.obs;
  RxBool isLoadingSocialService = false.obs;
  static SocialLogin? social;
  static U.UserInfo userInfo = U.UserInfo();
    RxBool isLoading = false.obs;
  RxList jobList = [].obs;

  @override
  void onInit() {

    super.onInit();
  }



    Future<dynamic> loginApi(String email, String password, ) async {
    // FirebaseMessaging.instance.getToken().then((value) {
    //   fcm_token = value.toString();
    //   print("FCM "+fcm_token.toString()+"^^");
    // });
    // setState(() {
    //   isloading = true;
    // });
    print(email);
    print(password);
    String msg = "";
    var jsonRes;
    http.Response? res;
    var request = http.post(
        Uri.parse(

          // RestDatasource.LOGIN_URL,
          "https://builtenance.com/development/primemetics/api/user/signIn",

         
         
        ),
        body: {
          "email": email.toString().trim(),
          "password": password.toString().trim(),
         

        },

       
        
        );
var responsedynamic;
    await request.then((http.Response response) {
      res = response;
      responsedynamic = response.body;
      final JsonDecoder _decoder = new JsonDecoder();
      jsonRes = _decoder.convert(response.body.toString());
      print("Response: " + response.body.toString() + "_");
      print("ResponseJSON: " + jsonRes.toString() + "_");
      // print("status: " + jsonRes["status"].toString() + "_");
      // print("message: " + jsonRes["message"].toString() + "_");
      // msg = jsonRes["message"].toString();
    });
    if (res!.statusCode == 200) {
      if (res!.statusCode == 200) {

        print("press here 1");
        
           await setUser(U.UserInfo.fromJson(jsonRes));

      show("Success", "Login Succeful");
       print("press here2");

      var user =getUserInfo();
      var role = user?.data?.role?.userRole.toString();
      print("press here 3" +role.toString()+"");
      // user?.data?.role?.userRole=="fuel_master" ? Get.offAll(FuelMasterLandingScreen()) : Get.offAll(MainDashboard());
      user?.data?.role?.userRole=="fuel_master" ? Get.offAll(TyreHomeScreen()) : Get.offAll(MainDashboard());
  // Get.offAll(TyreHomeScreen());
   print("press here 4");
        // SharedPreferences prefs = await SharedPreferences.getInstance();
        // prefs.setString('id', jsonRes["data"]["id"].toString());
        // prefs.setString('token', jsonRes["data"]["token"].toString());
        //  print("press here 5");
        var tokeenen = user?.data?.token.toString();
        print("token: "+tokeenen.toString()+"");
       
        // prefs.commit();
         print("press here 6");
      
       
      }else{
        // setState(() {
        //   isloading = false;
        // });
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text(msg,style: TextStyle(),)));

      }
    } else {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('Error while fetching data')));

      // setState(() {
      //   //isloading = false;
      // });
    }
  }




  Future<U.UserInfo?> getProfile() async {
    if (getUserInfo() == null) {
      return null;
    }
    var userInfo = getUserInfo();
    try {
      print(getHost());
      print("Url is "+USER);
      var response = await dio.get("https://builtenance.com/development/primemetics/api/users?id=4",
          options: D.Options(headers:
           {"Authorization":"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2J1aWx0ZW5hbmNlLmNvbS9kZXZlbG9wbWVudC9wcmltZW1ldGljcy9hcGkvdXNlciIsImlhdCI6MTY1NTIwNjg4MCwiZXhwIjoxNjU1MjA3MDAwLCJuYmYiOjE2NTUyMDY4ODAsImp0aSI6IjBqYkw2MWNnTFc5NmZWTGQiLCJzdWIiOiI0IiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyIsImlkIjo0fQ.uAiELmJb6nMTVRH2wxHZ6VNunKOEwm4m4A5cwLkx3Ls"
          //   'accept': "application/json",
          //   "Content-Type": "application/json",
          //   "Accept": "application/json",
          //   "User-Agent": "PostmanRuntime/7.29.0",
          //   "Cache-Control": "no-cache",
          //   "Postman-Token": "38c764b1-1bbd-4d93-825b-2d52516e7da3",
          //     "Host": getHost(),
          //   "Accept-Encoding": "gzip, deflate, br",
          //   "Connection": "keep-alive",
          //   "Authorization": "Bearer ${userInfo?.data?.token}",
           }
          
          )
          
          );

      print("Responseee "+response.toString()+"^^");
      if (response.isOk) {
        var user = U.UserInfo.fromJson(response.data);
        await setUser(user);
        return show("Success", "Loaded profile");
      } else {
        show("Error login", "Error gettin gprofile");
      }
      print(response.requestOptions.headers);
    } on D.DioError catch (e, status) {
      print(status);
    }
  }

  setLoadingsFalse() {
    submittingOtp(false);
    activateResend(false);
    isLoadingSocialService(false);
    loggingIn(false);
  }

  @override
  void onError() {
    setLoadingsFalse();

    // TODO: implement onError
    super.onError();
  }

  @override
  AuthController() : super.netwowk() {
    this.isLoadingSocialService.listen((p0) {
      if (p0) {
        Get.dialog(
          Container(
              width: ScreenSize.width * 0.1,
              height: ScreenSize.width * 0.1,
              child: Center(child: CircularProgressIndicator())),
          barrierDismissible: false,
        );
      } else {
        Get.back();
      }
    });
  }

  Future<U.UserInfo?> linkAccountWithGoogle() async {
    //var social = store.read<SocialLogin>(social_account);
    // social?.userId = userInfo.data?.id;
    // social?.socialToken = social.socialToken;
    var data = social?.toLinkJson();
    print(userInfo.data?.id);
    print("link account ${data}");
    D.Response response = await dio.post(
      link_account,
      data: data,
    );
    if (response.statusCode == 200) {
      return U.UserInfo.fromJson(response.body);
    }
    print(response.body);
    return null;
  }

  Future<U.UserInfo?> authWithSocial(String email, String token,
      {String company = "Google", String accountId = ""}) async {
    isLoadingSocialService(true);
    print("start signing");
    print(
        "Service ${company} Email : ${email} Token :${token} AccountId : ${accountId}");
    try {
      print("Login in at " + SOCIAL_SIGNIN);

      var response = await dio.post(
        SOCIAL_SIGNIN,
        data: {
          "token": token,
          "email": email,
          "company": company,
          "accountId": accountId
        },
      );

      if (response.statusCode == 200) {
        print("recieved an Ok from ${SOCIAL_SIGNIN}");
        userInfo = U.UserInfo.fromJson(response.data);

        var soci = SocialLogin.fromJson({
          "social_token": token,
          "email": email,
          "social": company,
          "account_id": accountId
        });
        print(response.data);
        social = soci;

        isLoadingSocialService(false);
        return userInfo;
      } else {
        isLoadingSocialService(false);
        show("Oops", "Service timeout");
        print(response.data);
      }
      isLoadingSocialService(false);
    } on D.DioError catch (e, trace) {
      isLoadingSocialService(false);
      print(e);
      print(trace);
    } on TimeoutException catch (e, trace) {
      isLoadingSocialService(false);
      print(e);
      print(trace);
    }

    print("return");
    return null;
  }

  authWithFacebook(String email) {}
  resend() async {
    sendingEmail(true);

    var response = await dio.post(
      SEND_EMAIL,
      data: {"email": getEmail()},
    );
    if (response.statusCode == 200 || response.statusCode == 405) {
      int start = 60;
      activateResend(false);
      Timer.periodic(Duration(seconds: 1), (timer) {
        if (start == 0) {
          activateResend(true);
          timeEllapsedForOtp("");
          timer.cancel();
        }
        print("timer");
        timeEllapsedForOtp("in " + (start--).toString() + " seconds.");
      });
    }
  }

  Future<U.UserInfo?> sendEmail(String email, String password) async {
    sendingEmail(true);
    print(SEND_EMAIL);
    var response = await dio.post(
      SEND_EMAIL,
      data: {"email": email},
    );
    print(response.statusCode);
    await setEmail(email);
    await setPassword(email);

    if (response.statusCode == 200 || response.statusCode == 405) {
      activateResend(false);
      int start = 60;
      Timer.periodic(Duration(seconds: 1), (timer) {
        if (start == 0) {
          activateResend(true);
          timeEllapsedForOtp("");
          timer.cancel();
        }
        print("timer");
        timeEllapsedForOtp("in " + (start--).toString() + " seconds.");
      });
    } else if (response.statusCode == 409) {
      sendingEmail(false);
      // Get.dialog(
      //     Container(
      //         width: ScreenSize.width * 0.1,
      //         height: ScreenSize.width * 0.1,
      //         child: Center(child: CircularProgressIndicator())),
      //     barrierDismissible: false,
      //   );
      //print(response.body.runtimeType);
      userInfo = U.UserInfo.fromJson(response.body);
      return userInfo;
    }

    sendingEmail(false);
    print(response.statusCode);
    print(response.body);
    print(response.headers);
    return null;
  }

  registerUser(U.Data user) async {
    var response = await dio.post(signUp, data: user.toJson());
  }

  loginUser(String email, String password) async {
    print({"email": email, "password": password});
    loggingIn(true);
    var response = await this
        .dio
        .post(login, data: jsonEncode({"email": email, "password": password}));
    loggingIn(false);
    if (response.isOk) {
      await setUser(U.UserInfo.fromJson(response.data));

      show("Success", "Login Succeful");

      var user =getUserInfo();
      // user?.data?.role?.userRole=="fuel_master" ? Get.offAll(FuelMasterLandingScreen()) : Get.offAll(MainDashboard());
      user?.data?.role?.userRole=="fuel_master" ? Get.offAll(TyreHomeScreen()) : Get.offAll(MainDashboard());

    } else {
      show("Error login", "Username or Password is wrong");
      printError();
      
    }
    print("is it out? "+response.requestOptions.headers.toString());
  }

  verifyOtp(String otp) async {
    print("verying otp ${otp}");
    submittingOtp(true);
    var response =
        await dio.post(veryfy_otp, data: {"otp": otp, "email": getEmail()});
    submittingOtp(false);
    if (response.statusCode == 200) {
      submittingOtp(false);
      await setSecret(response.body["secret"]);
      print(response.body["secret"]);
      return true;
    }

    print(response.statusCode);
    print(response.body);
    show("Error verying", "Invalid code");
    return false;
  }

  validateStepOne(
    String firstname,
    String lastName,
    String phoneNumber,
    String countrycode,
    String companyName, {
    String? addressone,
    String? addressTwo,
  }) {
    if (firstname.isEmpty) {
      show("Field Required", "First Name  required");
      return false;
    }
    if (lastName.isEmpty) {
      show("Field Required", "Last name required");
      return false;
    }
    if (phoneNumber.isEmpty) {
      show("Field Required", "Phone Number required");
      return false;
    }
    if (countrycode.isEmpty) {
      show("Field Required", "Please choose a country code");
      return false;
    }
    if (companyName.isEmpty) {
      show("Field Required", "Please enter company");
      return false;
    }

    userInfo.data?.firstName = firstname;
    userInfo.data?.lastName = lastName;
    userInfo.data?.company = companyName;
    userInfo.data?.addressOne = addressone;
    userInfo.data?.addressTwo = addressTwo;
    userInfo.data?.phoneNumber = phoneNumber;
    userInfo.data?.countryCode = countrycode;

    return true;
  }

  validateStepTwo(
    String companyrole,
    String signUpAs,
  ) {
    if (companyrole.isEmpty) {
      show("Field Required", "First Name  required");
      return false;
    }
    if (signUpAs.isEmpty) {
      show("Field Required", "Last name required");
      return false;
    }
    print("singing up wit role ${signUpAs}");
    userInfo.data?.signupRole = signUpAs.toLowerCase();
    userInfo.data?.role?.userRole = companyrole.toLowerCase();
  }

  validateStepThree(
      {int? fleetRigid, int? fleetArtic, int? fleetDrawbar, int? interlink}) {
    userInfo.data?.fleets?.artic = fleetArtic;
    userInfo.data?.fleets?.rigid = fleetRigid;
    userInfo.data?.fleets?.drawbar = fleetDrawbar;
    userInfo.data?.fleets?.interlink = interlink;

    return true;
  }

  validateStepFlour({
    bool? tyreMaster,
    bool? fuelMaster,
    bool? inspectionMaster,
  }) async {
    userInfo.data?.modules?.clear();
    if (tyreMaster ?? false) {
      userInfo.data?.modules?.add("tyre_master");
    } else {
      userInfo.data?.modules?.remove("tyre_master");
    }
    if (fuelMaster ?? false) {
      userInfo.data?.modules?.add("fuel_master");
    } else {
      userInfo.data?.modules?.remove("fuel_master");
    }
    if (inspectionMaster ?? false) {
      userInfo.data?.modules?.add("inspection_master");
    } else {
      userInfo.data?.modules?.remove("inspection_master");
    }
    print(userInfo.data?.modules);
    userInfo.data?.email = getEmail();

    return await register();
  }

  Future<bool> register() async {
    if (social != null) {
      print("registering social");
      jsonEncode(userInfo.data?.getUserRegInfoFormartSocial());
      print(userInfo.data?.getUserRegInfoFormartSocial());
      var response = await dio.post(
        signUp,
        data: userInfo.data?.getUserRegInfoFormartSocial(),
      );
      print(response.body);
      if (response.statusCode == 201) {
        userInfo = U.UserInfo.fromJson(response.body);
        await setUser(userInfo);
        return true;
      }
      show("Signup error", "error occured while signing up");
      return false;
    } else {
      print("sign up with username and password");
      print(userInfo.data?.getUserRegInfoFormart());
      var response = await dio.post(
        signUp,
        data: userInfo.data?.getUserRegInfoFormart(),
      );
      print(response.body);
      if (response.statusCode == 201) {
        print("user created successfully");

        userInfo = U.UserInfo.fromJson(response.body);
        await setUser(userInfo);
        return true;
      }
      show("Signup error", "error occured while signing up");
      return false;
    }
    return false;
  }
}
