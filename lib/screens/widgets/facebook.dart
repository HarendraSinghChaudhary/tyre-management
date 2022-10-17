import 'package:PrimeMetrics/utils/constants.dart';
import 'package:PrimeMetrics/utils/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/auth/auth_controller.dart';
import '../../main.dart';
import '../../models/user_info.dart';
import '../../utils/colors.dart';
import '../../utils/images.dart';
import '../../utils/screen_size.dart';
import '../../utils/style.dart';
import '../../utils/toast.dart';
import '../dashboard/dashboarrd.dart';
import '../auth/finalize_signup.dart';

class Facebook extends StatelessWidget {
  String? title;
  Facebook({Key? key, this.title = "Sign Up"}) : super(key: key);

  final _facebookSignIn = FacebookLogin();
  String? email;
 AuthController controller = AuthController();
 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () async {
          // Log in
          await _facebookSignIn.logOut();
          final res = await _facebookSignIn.logIn(permissions: [
            FacebookPermission.publicProfile,
            FacebookPermission.email,
            FacebookPermission.userFriends
          ]);
          switch (res.status) {
            case FacebookLoginStatus.success:
              final FacebookAccessToken? accessToken = res.accessToken;
               email = await _facebookSignIn.getUserEmail();
               print("email fb: "+email.toString());
               final storage = GetStorage();
                
                  controller.checkUser(email!, true);
                  storage.write('email', email);
              UserInfo? info = await controller.checkUser(email.toString(), true);
              // await controller.socialSignInApi(
              //     email ?? "", accessToken?.token ?? "",
              //     company: "Facebook", accountId: accessToken?.userId ?? "");

              //      controller.checkUser(email.toString());


                  

              print(
                  "Accounts ${(info?.data?.socialAccounts?.length ?? 0) > 0 ? true : false}");
                  // print("email fb: "+email.toString());

              if (info != null &&
                  ((info.data?.socialAccounts?.length ?? 0) > 0)) {
                var account = info.data?.socialAccounts
                    ?.where((element) => element.social == "Facebook");
                if (account?.isEmpty ?? false) {
                  // Get.to(FinalizeSignup());

                  signUpMap["email"] = email.toString();
                  controller.checkUser(email!, true);

                  return;
                }
                //store.remove(social_account);
                await setUser(info);
                Get.offAll(userHasCompany());
              } else if (userinfo != null) {
                if (info?.data?.id == null) {
                  // Get.to(FinalizeSignup());
                  controller.checkUser(email!, true);
                } else {
                  var userifo = await controller.linkAccountWithGoogle();
                  if (userinfo != null) {
                    //  store.remove(social_account);
                    Get.offAll(userHasCompany());
                  } else {
                    show("Failed to link account",
                        "could not link your account");
                  }
                }

                ///Get.to(OtpScreen());
              }

              break;
            case FacebookLoginStatus.cancel:
              // User cancel log in
              break;
            case FacebookLoginStatus.error:
              // Log in failed
              print('Error while log in: ${res.error}');
              break;
          }
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(
              top: ScreenSize.height * 0, bottom: ScreenSize.height * 0.02),
          width: ScreenSize.width * 0.82,
          height: ScreenSize.height * 0.065,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                fb,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(
                width: ScreenSize.width * 0.02,
              ),
              Text(
                "$title With Facebook",
                style: getStyle(),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: blue,
              borderRadius: BorderRadius.circular(ScreenSize.width * 0.01)),
        ),
      ),
    );
  }
}
