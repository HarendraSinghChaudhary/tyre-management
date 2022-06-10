import 'package:PrimeMetrics/utils/images.dart';
import 'package:PrimeMetrics/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../utils/screen_size.dart';

enum ProgressType { START_TRIP, REFUEL, END_TRIP, DESTINATION, LOADING }

class TripProgress {
  late String name;
  ProgressType progressType;
  bool active = false;
  TripProgress(
      {required this.name,
      this.active = false,
      this.progressType = ProgressType.DESTINATION});
}

class CustomeProgressIndicator extends StatelessWidget {
  RxInt currentstep;
   List<TripProgress>? tripProgress;
  CustomeProgressIndicator(
      {Key? key, required this.currentstep, List<TripProgress>? tripProgress})
      : super(key: key) {
    if (tripProgress == null) {
      tripProgress = [];
    } else {
      this.tripProgress = tripProgress;
    }
    // this.tripProgress = [
    //   // TripProgress(name: "Mombasa", progressType: ProgressType.START_TRIP),
    //   // TripProgress(name: "Kitui", progressType: ProgressType.REFUEL),
    //   // TripProgress(name: "Nairobi", active: true,progressType: ProgressType.START_TRIP),
    //   // TripProgress(name: "Naivasha", progressType: ProgressType.LOADING),
    //   // TripProgress(name: "Nakuru", progressType: ProgressType.START_TRIP),
    //   // TripProgress(name: "Eldoret", progressType: ProgressType.START_TRIP),
    //   // TripProgress(name: "KITALE", progressType: ProgressType.START_TRIP)
    // ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
            left: ScreenSize.height * 0.003,
            right: ScreenSize.height * 0.003,
            top: ScreenSize.height * 0.003),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tripProgress?.length??0,
            itemBuilder: (context, count) {
              var e = tripProgress![count];
              Widget icon;
              switch (e.progressType) {
                case ProgressType.START_TRIP:
                  icon = Container(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 18,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ));

                  // TODO: Handle this case.
                  break;
                case ProgressType.REFUEL:
                  icon = Container(
                    alignment: Alignment.center,
                    height: double.maxFinite,
                    child: Image.asset(refuel,
                        color: grey,
                        height: ScreenSize.width * 0.04,
                        width: ScreenSize.width * 0.04),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  );

                  // TODO: Handle this case.
                  break;
                case ProgressType.END_TRIP:
                  icon = Container(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 18,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ));

                  // TODO: Handle this case.
                  break;
                case ProgressType.DESTINATION:
                  icon = Container(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 18,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ));

                  // TODO: Handle this case.
                  break;
                case ProgressType.LOADING:
                  icon = Container(
                    alignment: Alignment.center,
                    height: double.maxFinite,
                    child: Image.asset(
                      load_cargo,
                      color: grey,
                      height: ScreenSize.width * 0.04,
                      width: ScreenSize.width * 0.04,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  );
                  // TODO: Handle this case.
                  break;
              }
              var radioGradient = e.active
                  ? RadialGradient(stops: const [
                      0.2,
                      0.3,
                      0.5,
                      0.7,
                      0.8,
                      1
                    ], colors: [
                      Colors.red.withOpacity(0.4),
                      Colors.red.withOpacity(0.4),
                      Colors.red.withOpacity(0.4),
                      Colors.red.withOpacity(0.4),
                      Colors.red.withOpacity(0.4),
                      Colors.red.withOpacity(0.4),
                    ])
                  : RadialGradient(stops: const [
                      0.2,
                      0.3,
                      0.5,
                      0.7,
                      0.8,
                      1
                    ], colors: [
                      green.withOpacity(0.4),
                      green.withOpacity(0.3),
                      green.withOpacity(0.35),
                      green.withOpacity(0.3),
                      green.withOpacity(0.2),
                      green.withOpacity(0.1)
                    ]);
              return Container(
                  alignment: Alignment.center,
                  width: ScreenSize.width * 0.2,
                  height: ScreenSize.width * 0.01,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                color: green,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                        ScreenSize.width * 0.03),
                                    topLeft: Radius.circular(
                                        ScreenSize.width * 0.03))),
                            height: ScreenSize.height * 0.005,
                          )),
                          Container(
                            width: ScreenSize.height * 0.04,
                            height: ScreenSize.height * 0.04,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              gradient: radioGradient,
                            ),
                            child: Container(
                                height: ScreenSize.height * 0.022, child: icon),
                          ),
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                              color: currentstep.value >= 1 ? green : white,
                            ),
                            height: ScreenSize.height * 0.005,
                          )),
                        ],
                      ),
                      Flexible(
                          child: Text(e.name,
                              style: getStyle(
                                fontSize: ScreenSize.width * 0.03,
                                color: Colors.green,
                              )))
                    ],
                  ));
            }));
  }
}
