// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:PrimeMetrics/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../main.dart';
import '../../models/user_info.dart';
import '../../utils/constants.dart';
import '../../utils/images.dart';
import '../../utils/screen_size.dart';
import '../../utils/services.dart';
import '../../utils/store.dart';
import '../../utils/style.dart';
import '../../utils/toast.dart';
import '../dashboard/dashboarrd.dart';
import '../auth/finalize_signup.dart';

class Google extends StatefulWidget {
  String? title;
  Google({Key? key, this.title = "Sign Up"}) : super(key: key);

  @override
  State<Google> createState() => _GoogleState();
}

class _GoogleState extends State<Google> {
  final GoogleSignIn _googleSignIn = getGoogleService();

  AuthController controller = Get.find();

 String name ="";

 String email = "";

  String firstName = "";

  String lastName = "";

  bool isLoading = false;

    Future googleLogin() async {

      isLoading = true;
    controller.isSocialSignInLoading.value=true;


    print("googleLogin method Called");
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      Get.dialog(
        Center(child: CircularProgressIndicator.adaptive(),)
      );
      var reslut = await _googleSignIn.signIn();
      if (reslut != null) {
        isLoading = true;


      
         controller.isSocialSignInLoading.value=true;
 
        final userData = await reslut.authentication;
        final credential = GoogleAuthProvider.credential(
            accessToken: userData.accessToken, idToken: userData.idToken);
        var finalResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        print("Result $reslut");
        print("userData: $userData");
        print("credential : $credential");
        print("finalResult : $finalResult");
        print("name:" + reslut.displayName.toString());
        // print("family name: "+ )
        name = reslut.displayName.toString();
        
        firstName = finalResult.additionalUserInfo?.profile!["given_name"];
        lastName = finalResult.additionalUserInfo?.profile!["family_name"];


        print("=========="+lastName.toString());
        email = reslut.email.toString();

        print("name: " + name);
        print("email: " + email);

       isLoading = false;
        controller.isSocialSignInLoading.value=false;


        await  storage.write('email', email);
        await  storage.write('firstName', firstName);
        await  storage.write('lastName', lastName);
        Get.back();
        return true;
        
      }
      isLoading = false;
       controller.isSocialSignInLoading.value=false;
       Get.back();
      return false;
      
    } catch (error) {
      isLoading = false;
       controller.isSocialSignInLoading.value=false;
       Get.back();

      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return 



    Obx(() => 


                             controller.isSocialSignInLoading.value
                        ? Align(
                            alignment: Alignment.center,
                            child: Platform.isAndroid
                                ? CircularProgressIndicator(color: Colors.orange, strokeWidth: 1,)
                                : CupertinoActivityIndicator())
                        :


  
    
    
    
    
    
    InkWell(
      onTap: () async {
        controller.isSocialSignInLoading.value=true;


           googleLogin().then((value) {
                           

                                print("response google: " + value.toString());
                                if (value) {

                                  controller.checkUser(email, true);

                                  

                               
                                  
                                }
                              });


                              controller.isSocialSignInLoading.value=false;










        // try {
        //   await _googleSignIn.signOut();
        //   var googleAccount = await _googleSignIn.signIn();
        //   if (googleAccount != null) {
        //     print("user sign in");
        //     GoogleSignInAuthentication auth =
        //         (await googleAccount.authentication);
        //     print(auth.accessToken);
        //     UserInfo? info = await controller.authWithSocial(
        //         googleAccount.email, auth.accessToken ?? "",
        //         company: "Google", accountId: googleAccount.id);
        //     print(
        //         "Accounts:........ ${(info?.data?.socialAccounts?.length ?? 0) > 0 ? true : false}");

        //     if (info != null &&
        //         ((info.data?.socialAccounts?.length ?? 0) > 0)) {
        //       var account = info.data?.socialAccounts
        //           ?.where((element) => element.social == "Google");
        //       if (account?.isEmpty ?? false) {
        //         Get.to(FinalizeSignup());
        //         return;
        //       }
        //      await setUser(info);
        //       //await store.write(userinfo, info);
        //       // store.remove(social_account);
        //       Get.offAll(userHasCompany());
        //     } else if (userinfo != null) {
        //       if (info?.data?.id == null) {
        //         Get.to(FinalizeSignup());
        //       } else {
        //         var userifo = await controller.linkAccountWithGoogle();
        //         if (userinfo != null) {
        //           // store.remove(social_account);
        //           Get.offAll(userHasCompany());
        //         } else {
        //           show("Failed to link account",
        //               "could not link your account");
        //         }
        //       }

        //       ///Get.to(OtpScreen());
        //     }

        //     print("........$info?.toJson()");
        //   }
        // } catch (error) {
        //   print(error);
        // }
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          top: ScreenSize.height * 0.0,
        ),
        width: ScreenSize.width * 0.82,
        height: ScreenSize.height * 0.065,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              google,
              fit: BoxFit.scaleDown,
            ),
            SizedBox(
              width: ScreenSize.width * 0.02,
            ),
            Text(
              "${widget.title} With Google",
              style: getStyle(color: Colors.black),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ScreenSize.width * 0.01)),
      ),
    ));
  }
}
