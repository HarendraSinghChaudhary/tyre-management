import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

class Google extends StatelessWidget {
  String? title;
  Google({Key? key, this.title = "Sign Up"}) : super(key: key);
  final GoogleSignIn _googleSignIn = getGoogleService();
  AuthController controller = Get.find();

 String name ="";
 String email = "";
  String firstName = "";
  String lastName = "";



  AuthController authController = AuthController();

    Future googleLogin() async {
    var familyname;
    authController.isLoading(true);
    print("googleLogin method Called");
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var reslut = await _googleSignIn.signIn();
      if (reslut != null) {
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

        authController.isLoading(false);


        await  storage.write('email', email);
        await  storage.write('firstName', firstName);
        await  storage.write('lastName', lastName);
        return true;
      }
      authController.isLoading(false);
      return false;
      
    } catch (error) {
      authController.isLoading(false);
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {


           googleLogin().then((value) {
                               authController.isLoading(false);

                                print("response google: " + value.toString());
                                if (value) {

                                  authController.checkUser(email);

                                  

                               
                                  
                                }
                              });










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
              "$title With Google",
              style: getStyle(color: Colors.black),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ScreenSize.width * 0.01)),
      ),
    );
  }
}
