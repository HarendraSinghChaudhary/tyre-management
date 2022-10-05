import 'package:PrimeMetrics/controllers/fuel/fuel_controller.dart';
import 'package:PrimeMetrics/controllers/trip/trip_controller.dart';
import 'package:PrimeMetrics/controllers/tyre/tyre_controller.dart';
import 'package:PrimeMetrics/models/user_info.dart';
 
import 'package:PrimeMetrics/screens/dashboard/module.dart';

import 'package:PrimeMetrics/utils/store.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';

import 'package:splashscreen/splashscreen.dart';

import 'controllers/auth/auth_controller.dart';
import 'screens/auth/user_company.dart';
import 'screens/driver/add_stop_destination.dart';

import 'screens/auth/welcome.dart';
import 'utils/colors.dart';
import 'utils/screen_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await GetStorage.init();

     await FacebookAuth.instance.webInitialize(
      appId: "1356832061430027",
      cookie: true,
      xfbml: true,
      version: "v13.0",
    );

  await GetStorage.init();
  Get.put(AuthController());
  Get.put(TripController());
  Get.put(FuelController());
  Get.put(TyreController());

  print(getUserInfo().runtimeType);
  runApp(GetMaterialApp(
    home:
    //  WelcomeScreen()
     SplashScreen.timer(
      seconds: 3,
      //  navigateAfterSeconds: ScreenSize(
      //     child:
      //          MainDashboard()),
      navigateAfterSeconds: ScreenSize(child: WelcomeScreen()),
      backgroundColor: green,
      loaderColor: white,
    ),
  ));
}

var storage = GetStorage();

class FoundationApp extends StatelessWidget {
  const FoundationApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding: BindingsBuilder(
          () {},
        ),
        home: ScreenSize(child: StopDestination()));
  }
}

Future<double> whenNotZero(Stream<double> source) async {
  await for (double value in source) {
    print("Width:" + value.toString());
    if (value > 0) {
      print("Width > 0: " + value.toString());
      return value;
    }
  }
  return Future.value(1);
  // stream exited without a true value, maybe return an exception.
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.

          ),
      home:
          ScreenSize(child: const MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return WelcomeScreen();
  }
}

userHasCompany() {
  // return StopDestination();
  // // return ConfirmTrip(
  // //   onCaptureTime: (dateTime) {
  // //     print("time ${dateTime.toString()}");
  // //   },
  // //   onCancelCaptureTime: () {
  // //     Get.back();
  // //     print("Canceled");
  // //   },
  // // );
  var data = getUserInfo();
  if (data == null) {
    return WelcomeScreen();
  }
  AuthController authController = Get.find();
  return FutureBuilder<UserInfo?>(
      future: authController.getProfile(),
      builder: (ctx, snap) {
        if (snap.hasData) {
          data = snap.data;
          if (data?.data?.currentCompany != null) {
            return ChooseModule();
          }
        }
        if (data == null) {
          return WelcomeScreen();
        }
        if (data?.data?.currentCompany == null) {
          return UserCompanyNotice();
        }
        return ChooseModule();
      });
}
